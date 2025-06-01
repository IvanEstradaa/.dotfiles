return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')
    local header = require('config.mine')

    -- Set header
    -- dashboard.section.header = header
    dashboard.section.header.val = header.val
    dashboard.section.header.opts.hl = header.opts.hl

    -- Set menu
    dashboard.section.buttons.val = {
      -- dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("y", "  > Browse files", ":Yazi<CR>"),
      dashboard.button("z", "  > Browse Directories", ":Telescope zoxide list<CR>"),
      dashboard.button("f", "󰈞  > Find file", ":Telescope find_files<CR>"),
      dashboard.button("w", "  > Find Word", ":Telescope live_grep<CR>"),
      dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
      dashboard.button("q", "󰅘  > Quit NVIM", ":qa<CR>"),
    }
    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    vim.keymap.set('n', '<leader>ga', ':Alpha<cr>', { desc = 'Prompt Alpha Greeter' })

  end,
}
