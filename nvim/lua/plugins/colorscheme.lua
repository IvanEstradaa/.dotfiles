-- https://github.com/metalelf0/black-metal-theme-neovim
return {
  "metalelf0/black-metal-theme-neovim",
  lazy = false,
  priority = 1000,
  config = function()
    require("black-metal").setup({
      -- optional configuration here
      theme = "immortal",
      -- Can be one of: 'light' | 'dark', or set via vim.o.background
      variant = "dark",
      -- If true, enable the vim terminal colors
      term_colors = true,
      -- Don't set background
      transparent = true,
   })
    require("black-metal").load()
  end,
}
