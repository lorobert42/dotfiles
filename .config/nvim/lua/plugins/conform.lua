return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format({ async = true, lsp_fallback = true })
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  opts = {
    formatters_by_ft = {
      rust = { 'rustfmt' },
      python = { 'isort', 'black' },
    },
  },
  format_on_save = {
    timeout_ms = 500,
  },
}
