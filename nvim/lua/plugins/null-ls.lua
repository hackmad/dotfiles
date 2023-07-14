return {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    config = function()
        local status_ok, null_ls = pcall(require, "null-ls")
        if not status_ok then
            return
        end

        local sources = {
            null_ls.builtins.formatting.clang_format,
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.formatting.rustfmt,
            null_ls.builtins.formatting.scalafmt,
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.formatting.terraform_fmt,

            null_ls.builtins.code_actions.gitsigns,

            null_ls.builtins.diagnostics.shellcheck,
        }

        null_ls.setup {
            debug = true,
            sources = sources,
        }
    end,
}
