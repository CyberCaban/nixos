 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#131314',
    base01 = '#1f2020',
    base02 = '#292a2a',
    base03 = '#8c9293',
    base04 = '#c2c7c9',
    base05 = '#e4e2e2',
    base06 = '#e4e2e2',
    base07 = '#e4e2e2',
    base08 = '#ffb4ab',
    base09 = '#cdc2d6',
    base0A = '#c0c8c9',
    base0B = '#b6cacf',
    base0C = '#cdc2d6',
    base0D = '#b6cacf',
    base0E = '#c0c8c9',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e4e2e2',          bg = '#131314' })
  hi('TelescopeBorder',         { fg = '#8c9293',             bg = '#131314' })
  hi('TelescopePromptNormal',   { fg = '#e4e2e2',          bg = '#131314' })
  hi('TelescopePromptBorder',   { fg = '#8c9293',             bg = '#131314' })
  hi('TelescopePromptPrefix',   { fg = '#b6cacf',             bg = '#131314' })
  hi('TelescopePromptCounter',  { fg = '#c2c7c9',  bg = '#131314' })
  hi('TelescopePromptTitle',    { fg = '#131314',             bg = '#b6cacf' })
  hi('TelescopePreviewTitle',   { fg = '#131314',             bg = '#c0c8c9' })
  hi('TelescopeResultsTitle',   { fg = '#131314',             bg = '#cdc2d6' })
  hi('TelescopeSelection',      { fg = '#e4e2e2',          bg = '#292a2a' })
  hi('TelescopeSelectionCaret', { fg = '#b6cacf',             bg = '#292a2a' })
  hi('TelescopeMatching',       { fg = '#b6cacf',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
