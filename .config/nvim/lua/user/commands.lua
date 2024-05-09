local group = vim.api.nvim_create_augroup('user_cmds', {clear = true})

vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {desc = 'Reload config'})

vim.api.nvim_create_autocmd('FileType', {
	pattern = {'help', 'man'},
	group = group,
	desc = 'Use q to close the window',
	command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

vim.api.nvim_create_autocmd('TextYankPost', {
	group = group,
	desc = 'Highlight on yank',
	callback = function(event)
		vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
	end
})
