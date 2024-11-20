require('telescope').setup({
	extensions = {
    	fzf = {
      	fuzzy = true,                    -- false will only do exact matching
      	override_generic_sorter = true,  -- override the generic sorter
      	override_file_sorter = true,     -- override the file sorter
      	case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    	}
  	}
})

require('telescope').load_extension('fzf')
-- require("telescope").load_extension("ui-select")
-- -- emoji
-- require("telescope").load_extension("emoji")
-- require("telescope").load_extension("neoclip")
-- -- git worktree
-- require("telescope").load_extension("git_worktree")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
vim.keymap.set('n', '<leader>sg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

vim.keymap.set("n", "<leader>wts", ':lua require("telescope").extensions.git_worktree.git_worktrees()<CR>', { noremap = true, silent = true, desc = "[W]ork [T]ree [S]witch" })
vim.keymap.set( "n", "<leader>wtc", ':lua require("telescope").extensions.git_worktree.create_git_worktree()<CR>', { noremap = true, silent = true, desc = "[W]ork [T]ree [C]reate" })
vim.keymap.set( "n", "<leader>wtd", ':lua require("telescope").extensions.git_worktree.git_worktrees()<CR>', { noremap = true, silent = true, desc = "[W]ork [T]ree [D]elete" })
