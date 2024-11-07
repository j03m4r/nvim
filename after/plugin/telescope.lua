local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
-- Set the border color for Telescope
vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { fg = '#2c2d30' })
vim.api.nvim_set_hl(0, 'TelescopeResultsBorder', { fg = '#2c2d30' })
vim.api.nvim_set_hl(0, 'TelescopePreviewBorder', { fg = '#2c2d30' })
