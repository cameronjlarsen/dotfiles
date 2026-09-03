#Requires -Version 7
<#
  Directional monitor swaps for komorebi.
  - windows:        swap window contents between focused workspaces (indices stay put)
  - all-workspaces: swap-workspaces-with-monitor

  Uses synchronous komorebic focus/send for reliability (Cloak + focus races).
  Disables movement animation during the swap.
  Direct swap: source windows leave first, then neighbor windows come back —
  cycle-focus picks the right hwnd out of the brief overlap on the destination.
  Stack groupings may flatten (windows move one-by-one).
#>
param(
    [Parameter(Mandatory)]
    [ValidateSet('left', 'right', 'up', 'down')]
    [string] $Direction,

    [Parameter(Mandatory)]
    [ValidateSet('windows', 'all-workspaces')]
    [string] $Mode
)

Add-Type @"
using System;
using System.Runtime.InteropServices;
public static class Native {
    [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr hWnd);
    [DllImport("user32.dll")] public static extern bool IsWindow(IntPtr hWnd);
    [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr hWnd);
    [DllImport("user32.dll")] public static extern IntPtr GetForegroundWindow();
    [DllImport("user32.dll")] public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);
    [DllImport("user32.dll")] public static extern bool AttachThreadInput(uint idAttach, uint idAttachTo, bool fAttach);
    [DllImport("user32.dll")] public static extern bool BringWindowToTop(IntPtr hWnd);
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    [DllImport("user32.dll")] public static extern bool AllowSetForegroundWindow(uint dwProcessId);
    [DllImport("kernel32.dll")] public static extern uint GetCurrentThreadId();

    public const int SW_RESTORE = 9;
    public const uint ASFW_ANY = 0xFFFFFFFF;

    public static bool FocusWindow(IntPtr hwnd) {
        if (hwnd == IntPtr.Zero || !IsWindow(hwnd)) return false;

        AllowSetForegroundWindow(ASFW_ANY);
        ShowWindow(hwnd, SW_RESTORE);

        IntPtr foreground = GetForegroundWindow();
        uint fgThread = GetWindowThreadProcessId(foreground, out _);
        uint targetThread = GetWindowThreadProcessId(hwnd, out _);
        uint currentThread = GetCurrentThreadId();

        if (fgThread != 0 && fgThread != targetThread)
            AttachThreadInput(fgThread, targetThread, true);
        if (currentThread != targetThread)
            AttachThreadInput(currentThread, targetThread, true);

        BringWindowToTop(hwnd);
        bool result = SetForegroundWindow(hwnd);

        if (fgThread != 0 && fgThread != targetThread)
            AttachThreadInput(fgThread, targetThread, false);
        if (currentThread != targetThread)
            AttachThreadInput(currentThread, targetThread, false);

        return result;
    }
}
"@

$script:KomorebiSock = Join-Path $env:LOCALAPPDATA 'komorebi\komorebi.sock'

function Send-KomorebiMessage {
    param([Parameter(Mandatory)][hashtable] $Message)

    $json = $Message | ConvertTo-Json -Compress -Depth 6
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($json)
    $socket = [System.Net.Sockets.Socket]::new(
        [System.Net.Sockets.AddressFamily]::Unix,
        [System.Net.Sockets.SocketType]::Stream,
        [System.Net.Sockets.ProtocolType]::Unspecified
    )
    try {
        $endpoint = [System.Net.Sockets.UnixDomainSocketEndPoint]::new($script:KomorebiSock)
        $socket.Connect($endpoint)
        [void]$socket.Send($bytes)
        $socket.Shutdown([System.Net.Sockets.SocketShutdown]::Both)
    }
    finally {
        $socket.Dispose()
    }
}

function Get-KomorebiState {
    $raw = komorebic state 2>&1
    if ($LASTEXITCODE -ne 0) { throw "komorebic state failed: $raw" }
    $raw | ConvertFrom-Json
}

function Get-MonitorRect {
    param($Monitor)
    $size = $Monitor.size
    [PSCustomObject]@{
        Left   = [int]$size.left
        Top    = [int]$size.top
        Width  = [int]$size.right
        Height = [int]$size.bottom
    }
}

function Get-NeighborMonitorIndex {
    param($State, [int]$FromIndex, [string]$Direction)

    $monitors = $State.monitors.elements
    if ($FromIndex -lt 0 -or $FromIndex -ge $monitors.Count) { return $null }

    $from = Get-MonitorRect $monitors[$FromIndex]
    for ($idx = 0; $idx -lt $monitors.Count; $idx++) {
        if ($idx -eq $FromIndex) { continue }
        $neighbor = Get-MonitorRect $monitors[$idx]
        $isNeighbor = switch ($Direction) {
            'left'  { ($neighbor.Left + $neighbor.Width) -eq $from.Left }
            'right' { ($from.Left + $from.Width) -eq $neighbor.Left }
            'up'    { ($neighbor.Top + $neighbor.Height) -eq $from.Top }
            'down'  { ($from.Top + $from.Height) -eq $neighbor.Top }
            default { $false }
        }
        if ($isNeighbor) { return $idx }
    }
    return $null
}

function Add-HwndIfLive {
    param([System.Collections.Generic.List[int]]$Hwnds, [int]$Hwnd)
    if ($Hwnd -le 0) { return }
    if (-not [Native]::IsWindow([IntPtr]$Hwnd)) { return }
    if ($Hwnds.Contains($Hwnd)) { return }
    $Hwnds.Add($Hwnd) | Out-Null
}

function Add-ContainerHwnds {
    param([System.Collections.Generic.List[int]]$Hwnds, $Container)
    if ($null -eq $Container -or $null -eq $Container.windows) { return }
    foreach ($window in $Container.windows.elements) {
        Add-HwndIfLive -Hwnds $Hwnds -Hwnd ([int]$window.hwnd)
    }
}

function Get-WorkspaceHwnds {
    param($Workspace)
    $hwnds = [System.Collections.Generic.List[int]]::new()
    if ($null -eq $Workspace) { return @() }

    foreach ($container in $Workspace.containers.elements) {
        Add-ContainerHwnds -Hwnds $hwnds -Container $container
    }
    Add-ContainerHwnds -Hwnds $hwnds -Container $Workspace.monocle_container
    if ($null -ne $Workspace.maximized_window) {
        Add-HwndIfLive -Hwnds $hwnds -Hwnd ([int]$Workspace.maximized_window.hwnd)
    }
    if ($null -ne $Workspace.floating_windows -and $null -ne $Workspace.floating_windows.elements) {
        foreach ($window in $Workspace.floating_windows.elements) {
            Add-HwndIfLive -Hwnds $hwnds -Hwnd ([int]$window.hwnd)
        }
    }
    return @($hwnds.ToArray())
}

function Wait-Until {
    param([scriptblock]$Condition, [int]$TimeoutMs = 250, [int]$PollMs = 10)
    $deadline = [Environment]::TickCount64 + $TimeoutMs
    while ([Environment]::TickCount64 -lt $deadline) {
        if (& $Condition) { return $true }
        Start-Sleep -Milliseconds $PollMs
    }
    return [bool](& $Condition)
}

function Get-KomorebiFocusedHwnd {
    # send-to-* uses komorebi's focused container, not Win32 foreground.
    $state = Get-KomorebiState
    $monitor = $state.monitors.elements[[int]$state.monitors.focused]
    $workspace = $monitor.workspaces.elements[[int]$monitor.workspaces.focused]

    if ($null -ne $workspace.maximized_window) {
        return [int]$workspace.maximized_window.hwnd
    }

    if ($null -ne $workspace.monocle_container -and
        $null -ne $workspace.monocle_container.windows -and
        $workspace.monocle_container.windows.elements.Count -gt 0) {
        $mc = $workspace.monocle_container
        return [int]$mc.windows.elements[[int]$mc.windows.focused].hwnd
    }

    if ($null -eq $workspace.containers -or $workspace.containers.elements.Count -eq 0) {
        return $null
    }

    $container = $workspace.containers.elements[[int]$workspace.containers.focused]
    if ($null -eq $container.windows -or $container.windows.elements.Count -eq 0) {
        return $null
    }

    return [int]$container.windows.elements[[int]$container.windows.focused].hwnd
}

function Focus-MonitorWorkspaceSync {
    param([int]$Monitor, [int]$Workspace, $ExpectedVisibleHwnds = @())

    $expected = @($ExpectedVisibleHwnds | ForEach-Object { [int]$_ })
    komorebic focus-monitor-workspace $Monitor $Workspace 2>&1 | Out-Null

    if ($expected.Count -gt 0) {
        [void](Wait-Until -TimeoutMs 400 -Condition {
            foreach ($hwnd in $expected) {
                if ([Native]::IsWindowVisible([IntPtr]$hwnd)) { return $true }
            }
            return $false
        })
    }
    else {
        Start-Sleep -Milliseconds 40
    }
}

function Focus-HwndForKomorebi {
    param([int]$Hwnd, [int]$MaxCycle = 12)
    if (-not [Native]::IsWindow([IntPtr]$Hwnd)) { return $false }

    # Prefer komorebi cycle-focus — SetForegroundWindow alone does not change
    # which container send-to-monitor-workspace will move.
    for ($i = 0; $i -lt $MaxCycle; $i++) {
        $focused = Get-KomorebiFocusedHwnd
        if ($focused -eq $Hwnd) {
            [Native]::FocusWindow([IntPtr]$Hwnd) | Out-Null
            return $true
        }
        komorebic cycle-focus next 2>&1 | Out-Null
    }

    return ((Get-KomorebiFocusedHwnd) -eq $Hwnd)
}

function Move-HwndsBatch {
    param(
        $Hwnds,
        [int]$FromMonitor,
        [int]$FromWorkspace,
        [int]$ToMonitor,
        [int]$ToWorkspace
    )

    $hwndList = @($Hwnds | ForEach-Object { [int]$_ })
    if ($hwndList.Count -eq 0) { return }

    foreach ($hwnd in $hwndList) {
        if (-not [Native]::IsWindow([IntPtr]$hwnd)) { continue }

        Focus-MonitorWorkspaceSync -Monitor $FromMonitor -Workspace $FromWorkspace -ExpectedVisibleHwnds @($hwnd)
        if (-not (Focus-HwndForKomorebi -Hwnd $hwnd)) { continue }

        komorebic send-to-monitor-workspace $ToMonitor $ToWorkspace 2>&1 | Out-Null

        [void](Wait-Until -TimeoutMs 300 -Condition {
            -not [Native]::IsWindowVisible([IntPtr]$hwnd)
        })
    }
}

if (-not (Test-Path -LiteralPath $script:KomorebiSock)) {
    throw "komorebi socket not found: $script:KomorebiSock"
}

$state = Get-KomorebiState
$srcMonitor = [int]$state.monitors.focused
$srcMonitorObj = $state.monitors.elements[$srcMonitor]
$srcWs = [int]$srcMonitorObj.workspaces.focused

$dstMonitor = Get-NeighborMonitorIndex -State $state -FromIndex $srcMonitor -Direction $Direction
if ($null -eq $dstMonitor) { exit 0 }

switch ($Mode) {
    'all-workspaces' {
        komorebic swap-workspaces-with-monitor $dstMonitor 2>&1 | Out-Null
        exit $LASTEXITCODE
    }
    'windows' {
        $dstMonitorObj = $state.monitors.elements[$dstMonitor]
        $dstWs = [int]$dstMonitorObj.workspaces.focused
        $srcHwnds = @(Get-WorkspaceHwnds $srcMonitorObj.workspaces.elements[$srcWs])
        $dstHwnds = @(Get-WorkspaceHwnds $dstMonitorObj.workspaces.elements[$dstWs])

        if ($srcHwnds.Count -eq 0 -and $dstHwnds.Count -eq 0) { exit 0 }

        try {
            Send-KomorebiMessage @{ type = 'Animation'; content = @($false, 'movement') }

            # Source leaves first (monitor you're on clears), then original neighbor
            # windows are pulled back. cycle-focus in Focus-HwndForKomorebi finds each
            # hwnd in the brief overlap on the destination.
            Move-HwndsBatch -Hwnds $srcHwnds `
                -FromMonitor $srcMonitor -FromWorkspace $srcWs `
                -ToMonitor $dstMonitor -ToWorkspace $dstWs
            Move-HwndsBatch -Hwnds $dstHwnds `
                -FromMonitor $dstMonitor -FromWorkspace $dstWs `
                -ToMonitor $srcMonitor -ToWorkspace $srcWs

            komorebic focus-monitor-workspace $srcMonitor $srcWs 2>&1 | Out-Null
        }
        finally {
            Send-KomorebiMessage @{ type = 'Animation'; content = @($true, 'movement') }
        }

        exit 0
    }
}
