return {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
    config = function()
        local status_ok, spectre = pcall(require, "spectre")
        if not status_ok then
            return
        end
        spectre.setup {
            default = {
                find = {
                    --pick one of item in find_engine
                    options = {}
                },
            },
        }
    end,
}
