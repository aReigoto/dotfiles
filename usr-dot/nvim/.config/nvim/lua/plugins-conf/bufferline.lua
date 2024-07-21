local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end


bufferline.setup {
  options = {
    close_command = "Bdelete! %d",       -- can be a string | function, | false see "Mouse actions"
    right_mouse_command = "Bdelete! %d", -- can be a string | function | false, see "Mouse actions"
    left_mouse_command = "buffer %d",    -- can be a string | function, | false see "Mouse actions"
    middle_mouse_command = nil,          -- can be a string | function, | false see "Mouse actions"
    indicator = {
        icon = '▎', -- this should be omitted if indicator style is not 'icon'
        style = 'icon',
    },
    buffer_close_icon = '󰅖',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    -- separator_style = "slant", -- "slant" | "thick" | "thin" | { 'any', 'any' },
    numbers = function(opts)
        return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
      end,
    diagnostics = "nvim_lsp", -- false | "coc"
    update_in_insert = true,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
  },
}

