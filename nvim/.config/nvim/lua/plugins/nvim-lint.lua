return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')

    lint.linters_by_ft = {
      python = { 'flake8' },
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
        lint.try_lint('typos')
      end,
    })

    vim.keymap.set('n', '<leader>cl', function()
      lint.try_lint()
      lint.try_lint('typos')
    end, { desc = 'Lint file' })
  end,
}
