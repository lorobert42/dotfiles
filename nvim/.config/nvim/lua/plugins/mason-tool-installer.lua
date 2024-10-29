return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  opts = {
    ensure_installed = {
			'autotools-language-server',
      'bash-language-server',
			'clangd',
			'css-lsp',
			'eslint-lsp',
      'groovy-language-server',
			'html-lsp',
      'java-language-server',
      'jedi-language-server',
      'jinja_lsp',
			'rust-analyzer',
      'some-sass-language-server',
      'typescript-language-server',
      -- Linters
      'ansible-lint',
      'commitlint',
      'flake8',
      'gitleaks',
      'typos',
      -- Formatters
      'black',
      'isort',
    },
    auto_update = true,
    run_on_start = true,
    debounce_hours = 24,
  },
}
