local ftMap = {
    vim = "indent",
    python = { "indent" },
    git = ""
}

local function customizeSelector(bufnr)
    local function handleFallbackException(err, providerName)
        if type(err) == "string" and err:match("UfoFallbackException") then
            return require("ufo").getFolds(bufnr, providerName)
        else
            return require("promise").reject(err)
        end
    end

    return require("ufo").getFolds(bufnr, "lsp"):catch(function(err)
        return handleFallbackException(err, "treesitter")
    end):catch(function(err)
        return handleFallbackException(err, "indent")
    end)
end

local function handler(virtText, lnum, endLnum, width, truncate)
    -- Displays lines folded to the right.
    local newVirtText = {}
    local suffix = (" 󰁂 %d "):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
end

return {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        { "kevinhwang91/promise-async" },
    },
    config = function()
        require("ufo").setup({
            open_fold_hl_timeout = 150,
            preview = {
                win_config = {
                    border = { "", "─", "", "", "", "─", "", "" },
                    winhighlight = "Normal:Folded",
                    winblend = 0
                },
                mappings = {
                    scrollU = "<C-u>",
                    scrollD = "<C-d>",
                    jumpTop = "[",
                    jumpBot = "]"
                }
            },
            provider_selector = function(bufnr, filetype, buftype)
                return ftMap[filetype] or customizeSelector
            end,
            fold_virt_text_handler = handler,
        })
    end,
}
