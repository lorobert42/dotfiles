local Plugin = {'akinsho/toggleterm.nvim'}

Plugin.keys = {'<C-t>'}

-- See :help toggleterm-roadmap
Plugin.opts = {
	open_mapping = '<C-t>',
	direction = 'horizontal',
	shade_terminals = true
}

return Plugin
