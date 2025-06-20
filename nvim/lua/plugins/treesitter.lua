return { 
  "nvim-treesitter/nvim-treesitter",
  event = { 'BufReadPre', 'BufNewFile' }, 
  build = { ":TSUpdate" },
  dependencies = {
    'windwp/nvim-ts-autotag',
  },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require('nvim-treesitter.configs')

    -- configure treesitter
    treesitter.setup({
      highlight = {
        enable = true,
      },
      
      -- enable indentation
      indent = {enable = true},

      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = { enable = true },

      -- ensure these laguage parsers are installed
      ensure_installed = {
        'json',
        'yaml',
        'bash',
        'lua',
        'vim',
        'dockerfile',
        'markdown',
        'gitignore',
        'python',
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },

    })
  end,
}
