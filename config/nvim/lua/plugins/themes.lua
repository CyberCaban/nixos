local f = require("utils.functions")
local M = {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  { "rebelot/kanagawa.nvim" },
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      vim.cmd.colorscheme("gruvbox")
    end,
  },
  {
    "xero/miasma.nvim",
  },
  {
    "xero/evangelion.nvim",
  },
  {
    "xero/sourcerer.vim",
  },
  {
    "baliestri/aura-theme",
  },
}

return M
