local status_ok, markdownflow = pcall(require, "mkdnflow")
if not status_ok then
    return
end

markdownflow.setup()
