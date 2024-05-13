local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
  'n', 
  '<leader>ca', 
  function()
    vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
  end,
  { silent = true, buffer = bufnr, desc = 'Code action' }
)
vim.keymap.set(
  'n',
  '<leader>cj',
  function()
    vim.cmd.RustLsp { 'moveItem', 'up' }
  end,
  { silent = true, buffer = bufnr, desc = 'Move item up'}
)
vim.keymap.set(
  'n',
  '<leader>ck',
  function()
    vim.cmd.RustLsp { 'moveItem', 'down' }
  end,
  { silent = true, buffer = bufnr, desc = 'Move item down'}
)
vim.keymap.set(
  'n',
  '<leader>ce',
  function()
    vim.cmd.RustLsp('explainError')
  end,
  { silent = true, buffer = bufnr, desc = 'Explain error'}
)
vim.keymap.set(
  'n',
  '<leader>cd',
  function()
    vim.cmd.RustLsp('renderDiagnostic')
  end,
  { silent = true, buffer = bufnr, desc = 'Show cargo build diagnostic'}
)
vim.keymap.set(
  { 'n', 'v' },
  '<leader>cJ',
  function()
    vim.cmd.RustLsp('joinLines')
  end,
  { silent = true, buffer = bufnr, desc = 'Join line'}
)
vim.keymap.set(
  'n',
  '<leader>cc',
  function()
    vim.cmd.RustLsp('flyCheck')
  end,
  { silent = true, buffer = bufnr, desc = 'Cargo check'}
)
