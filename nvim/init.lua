local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

require('bufdel').setup {
  next = 'tabs',
  quit = false,  -- quit Neovim when last buffer is closed
}
