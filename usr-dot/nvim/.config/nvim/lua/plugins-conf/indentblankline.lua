local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
  return
end

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)


ibl.setup { indent = { highlight = highlight } }

-- local status_ok, indent_blankline = pcall(require, "indent_blankline")
-- if not status_ok then
--   return
-- end
--
-- indent_blankline.setup {
--   char = "▏",
--   show_trailing_blankline_indent = false,
--   show_first_indent_level = true,
--   use_treesitter = true,
--   show_current_context = true,
--   buftype_exclude = { "terminal", "nofile" },
--   filetype_exclude = {
--     "help",
--     "packer",
--     "NvimTree",
--   },

-- https://github.com/lukas-reineke/indent-blankline.nvim/wiki/Migrate-to-version-3
