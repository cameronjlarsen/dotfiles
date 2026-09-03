local wezterm = require("wezterm")
local catppuccin = require("colors.catppuccin")

return function(config)
	local colors = catppuccin.colors

	-- Set leader key to CTRL+a (tmux-style prefix)
	config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }

	-- Disable default wezterm keybindings to avoid conflicts
	config.disable_default_key_bindings = true
	config.keys = {
		-- Pane splits (tmux-style)
		{
			key = [[|]],
			mods = "LEADER|SHIFT",
			action = wezterm.action.SplitPane({
				direction = "Right",
				size = { Percent = 50 },
			}),
		},
		{
			key = [[-]],
			mods = "LEADER",
			action = wezterm.action.SplitPane({
				direction = "Down",
				size = { Percent = 50 },
			}),
		},

		-- Pane navigation (tmux-style with nvim integration)
		{ key = "h", mods = "LEADER", action = wezterm.action.EmitEvent("ActivatePaneDirection-left") },
		{ key = "j", mods = "LEADER", action = wezterm.action.EmitEvent("ActivatePaneDirection-down") },
		{ key = "k", mods = "LEADER", action = wezterm.action.EmitEvent("ActivatePaneDirection-up") },
		{ key = "l", mods = "LEADER", action = wezterm.action.EmitEvent("ActivatePaneDirection-right") },

		-- Pane resize (tmux-style with shift)
		{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 3 }) },
		{ key = "J", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 3 }) },
		{ key = "K", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 3 }) },
		{ key = "L", mods = "LEADER|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 3 }) },

		-- Pane management
		{ key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
		{ key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = false }) },

		-- Tab/Window management (tmux-style)
		{ key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
		{ key = "n", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = 1 }) },
		{ key = "p", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = -1 }) },

		-- Tab activation by number (1-9)
		{ key = "1", mods = "LEADER", action = wezterm.action({ ActivateTab = 0 }) },
		{ key = "2", mods = "LEADER", action = wezterm.action({ ActivateTab = 1 }) },
		{ key = "3", mods = "LEADER", action = wezterm.action({ ActivateTab = 2 }) },
		{ key = "4", mods = "LEADER", action = wezterm.action({ ActivateTab = 3 }) },
		{ key = "5", mods = "LEADER", action = wezterm.action({ ActivateTab = 4 }) },
		{ key = "6", mods = "LEADER", action = wezterm.action({ ActivateTab = 5 }) },
		{ key = "7", mods = "LEADER", action = wezterm.action({ ActivateTab = 6 }) },
		{ key = "8", mods = "LEADER", action = wezterm.action({ ActivateTab = 7 }) },
		{ key = "9", mods = "LEADER", action = wezterm.action({ ActivateTab = 8 }) },

		-- Copy mode (tmux-style)
		{ key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode },

		-- Workspace management (tmux-style)
		{ key = "(", mods = "LEADER|SHIFT", action = wezterm.action.SwitchWorkspaceRelative(-1) },
		{ key = ")", mods = "LEADER|SHIFT", action = wezterm.action.SwitchWorkspaceRelative(1) },

		-- Workspace switcher (fuzzy finder)
		{
			key = "s",
			mods = "LEADER",
			action = wezterm.action.ShowLauncherArgs({
				flags = "FUZZY|WORKSPACES",
			}),
		},

		-- Create/rename workspace
		{
			key = "$",
			mods = "LEADER|SHIFT",
			action = wezterm.action.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { Color = colors.pink } },
					{ Text = "Enter name for workspace" },
				}),
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:perform_action(
							wezterm.action.SwitchToWorkspace({
								name = line,
							}),
							pane
						)
					end
				end),
			}),
		},

		-- Send literal CTRL+a to application (press leader twice)
		{ key = "a", mods = "LEADER", action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }) },

		-- Standard clipboard operations (unchanged, no prefix needed)
		{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
		{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },

		-- Font size adjustments (unchanged, no prefix needed)
		{ key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
		{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },

		-- Fullscreen toggle (unchanged, no prefix needed)
		{ key = "F11", mods = "", action = wezterm.action.ToggleFullScreen },

		-- Search and selection (with prefix)
		{ key = "/", mods = "LEADER", action = wezterm.action.Search({ CaseInSensitiveString = "" }) },
		{ key = "Space", mods = "LEADER", action = wezterm.action.QuickSelect },

		-- Tab management additions
		{ key = "q", mods = "LEADER", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
		{ key = "<", mods = "LEADER|SHIFT", action = wezterm.action.MoveTabRelative(-1) },
		{ key = ">", mods = "LEADER|SHIFT", action = wezterm.action.MoveTabRelative(1) },

		-- Utilities (with prefix)
		{ key = "r", mods = "LEADER", action = wezterm.action.ReloadConfiguration },
		{ key = "d", mods = "LEADER", action = wezterm.action.ShowDebugOverlay },
		{ key = ":", mods = "LEADER|SHIFT", action = wezterm.action.ActivateCommandPalette },
		{ key = "u", mods = "LEADER", action = wezterm.action.CharSelect },
		{ key = "N", mods = "LEADER|SHIFT", action = wezterm.action.SpawnWindow },
		{ key = "0", mods = "LEADER", action = wezterm.action.ResetFontSize },

		-- Scrolling by page (no prefix needed)
		{ key = "PageUp", mods = "SHIFT", action = wezterm.action.ScrollByPage(-1) },
		{ key = "PageDown", mods = "SHIFT", action = wezterm.action.ScrollByPage(1) },

		-- Paste primary selection (X11)
		{ key = "Insert", mods = "SHIFT", action = wezterm.action.PasteFrom("PrimarySelection") },
	}

	return config
end
