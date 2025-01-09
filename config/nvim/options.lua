local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.mouse = "a"
opt.cursorline = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.swapfile = false
vim.g.mapleader = " "
-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

opt.hlsearch = true
opt.incsearch = true
-- Set shell to bash or your preferred shell
vim.opt.shell = "/run/current-system/sw/bin/zsh"



vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]
if vim.g.neovide then
	vim.g.neovide_transparency = 0.3
	vim.g.neovide_window_blurred = true
	-- shadow
	vim.g.neovide_floating_shadow = true
	vim.g.neovide_floating_z_height = 10
	vim.g.neovide_light_angle_degrees = 45
	vim.g.neovide_light_radius = 5
end

