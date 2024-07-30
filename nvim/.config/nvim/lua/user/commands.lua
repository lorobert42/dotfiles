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

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('jenkinsfile_detect', {clear = true}),
  pattern = { 'Jenkinsfile' },
  callback = function()
    vim.cmd('set filetype=groovy')
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'java', 'groovy' },
  callback = function()
    vim.cmd('setlocal tabstop=4')
    vim.cmd('setlocal shiftwidth=4')
  end
})
