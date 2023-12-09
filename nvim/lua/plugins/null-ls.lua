return {
    -- Community fork of null-ls which is archived
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup {
            debug = true,
            sources = {
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.rustfmt,
                null_ls.builtins.formatting.scalafmt,
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.terraform_fmt,

                null_ls.builtins.code_actions.gitsigns,

                null_ls.builtins.diagnostics.shellcheck,
            },
        }
    end,
}
