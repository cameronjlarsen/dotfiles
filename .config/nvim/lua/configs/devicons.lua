local status_ok, devicons = pcall(require, "nvim-web-devicons")
if not status_ok then
    return
end

return {
    devicons.setup(),
    devicons.set_icon({
        ["NvimTree"] = {
            icon = "פּ",
            color = "#7ebae4",
            name = "NvimTree",
        },
        ["help"] = {
            icon = "",
            color = "#7ebae4",
            name = "help",
        },
        ["undotree"] = {
            icon = "פּ",
            color = "#7ebae4",
            name = "undotree",
        },
        ["toggleterm"] = {
            icon = " ",
            color = "#7ebae4",
            name = "toggleterm",
        },
        ['tsplayground'] = {
            icon = '侮',
            color = '#7ebae4',
            name = 'tsplayground',
        },
        ['Trouble'] = {
            icon = '',
            color = '#7ebae4',
            name = 'Trouble',
        },
    })
}
