return {
    "nvim-tree/nvim-tree.lua",
    event = "VeryLazy",
    dependencies = {
        { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
        local status_ok, nvim_tree = pcall(require, "nvim-tree")
        if not status_ok then
            return
        end

        local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
        if not config_status_ok then
            return
        end

        local tree_cb = nvim_tree_config.nvim_tree_callback

        nvim_tree.setup {
            git = {
                enable = true,
            },
            filters = {
                dotfiles = false,
            },
            modified = {
                enable = true,
                show_on_dirs = true,
                show_on_open_dirs = true,
            },
            view = {
                signcolumn = "yes",
                width = 30,
            },
            actions = {
                open_file = {
                    resize_window = false,
                },
            },
            update_focused_file = {
                enable = true,
                update_cwd = true,
            },
            renderer = {
                highlight_git = true,
                highlight_opened_files = "icon",
                highlight_modified = "icon",
                icons = {
                    webdev_colors = true,
                    git_placement = "signcolumn",
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                        modified = true,
                    },
                },
                root_folder_modifier = ":t",
            },
            diagnostics = {
                enable = true,
                show_on_dirs = true,
            },
        }
    end,
}
