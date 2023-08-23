local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

-- Bufdel
require('bufdel').setup({
  next = 'tabs',
  quit = false,  -- quit Neovim when last buffer is closed
})

-- Possession
require("nvim-possession").setup({
    autoswitch = {
        enable = true, -- default false
    },

    save_hook = function()
        vim.cmd("only")

        local buflist = vim.api.nvim_list_bufs()
        for _, bufnr in ipairs(buflist) do
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            if vim.fn.bufwinnr(bufnr) ~= -1 and vim.fn.buflisted(bufnr) == 0 then
                vim.cmd("bd " .. bufnr)
            end
        end
    end,

    post_hook = function()
        vim.cmd("NERDTreeCWD | wincmd p")
    end
})

local possession = require("nvim-possession")
vim.keymap.set("n", "<leader>sl", function()
    possession.list()
end)
vim.keymap.set("n", "<leader>sn", function()
    possession.new()
end)
vim.keymap.set("n", "<leader>su", function()
    possession.update()
end)
vim.keymap.set("n", "<leader>sd", function()
    possession.delete()
end)

-- Surround
require("nvim-surround").setup({})

-- Search and Replace
require("search-replace").setup({
    -- optionally override defaults
    default_replace_single_buffer_options = "gcI",
    default_replace_multi_buffer_options = "egcI",
})

local opts = {}
vim.api.nvim_set_keymap("v", "%", "<CMD>SearchReplaceWithinVisualSelection<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>%", "<CMD>SearchReplaceSingleBufferOpen<CR>", opts)

-- show the effects of a search / replace in a live preview window
vim.o.inccommand = "split"

-- Tree-sitter
require'nvim-treesitter.configs'.setup({
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
})
