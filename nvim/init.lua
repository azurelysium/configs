local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

-- Bufdel
require("bufdel").setup({
  next = "tabs",
  quit = false,  -- quit Neovim when last buffer is closed
})

-- Telescope
require("telescope").setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
require("telescope").load_extension("possession")
require("telescope").load_extension("fzf")

local builtin = require("telescope.builtin")
--vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
--vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

vim.keymap.set("n", "<leader>ff", function() builtin.find_files({ cwd = vim.loop.cwd() }) end, {})
vim.keymap.set("n", "<leader>fg", function() builtin.live_grep({ cwd = vim.loop.cwd() }) end, {})
vim.keymap.set("n", "<leader>fs", function() require("telescope").extensions.possession.list() end, {})

local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
      ["<esc>"] = actions.close,
      ["<C-g>"] = actions.close,
      },
    },
  },
})

-- Possession
require("possession").setup({
  autosave = {
    on_load = true,
    on_quit = true,
  },
  plugins = {
    delete_buffers = true,
  },
  hooks = {
    after_load = function(name, user_data)
      vim.cmd("NERDTree")
    end,
    before_save = function(name)
      vim.cmd("only")
      local buflist = vim.api.nvim_list_bufs()
      for _, bufnr in ipairs(buflist) do
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if vim.fn.bufwinnr(bufnr) ~= -1 and vim.fn.buflisted(bufnr) == 0 then
          vim.cmd("bd " .. bufnr)
        end
      end
      return {}
    end,
  },
})

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
require"nvim-treesitter.configs".setup({
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
})
