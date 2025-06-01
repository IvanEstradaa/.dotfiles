return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 400
  end,
  opts = {
    -- config comes here
    -- or leave empty to use default config
    -- refer to config section below
  },
}
