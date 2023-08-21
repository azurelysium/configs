local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

require('bufdel').setup {
  next = 'tabs',
  quit = false,  -- quit Neovim when last buffer is closed
}

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
        vim.cmd("NERDTreeCWD")
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
