return {
	'kdheepak/lazygit.nvim',
	dependencies = {
		'nvim-telescope/telescope.nvim',
		'nvim-lua/plenary.nvim',
	},
	cmd = {
		'LazyGit',
		'LazyGitConfig',
		'LazyGitCurrentFile',
		'LazyGitFilter',
		'LazyGitFilterCurrentFile',
	},
	keys = {
		{ '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
	},
}
