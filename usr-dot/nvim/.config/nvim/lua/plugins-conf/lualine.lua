local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

--[[
TODO: 
  use the function from vim-visual-multi
    call VMInfos()
    echo VMInfos()
    to display status of vim-visual-multi
    it returns:
      {'status': 'Msv', 'current': 1, 'total': 4, 'patterns': [], 'ratio': '1 / 4'}
    or
      {}
]]

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local vim_visual_multi = function()

  local vm_status_ok, VMInfos = pcall(vim.fn.VMInfos)
  -- Check if VMInfos exists, check if the return of VMInfos is {}
  if (not vm_status_ok) or (not next(VMInfos)) then
    return ""
  end

  return "V-M " .. VMInfos['status'] .. " " .. VMInfos['ratio']

end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = "", modified = "", removed = "" }, -- changes diff symbols
  cond = hide_in_width,
}

local filetype = {
  "filetype",
  icons_enabled = false,
}

local location = {
  "location",
  padding = 0,
}

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" , vim_visual_multi},
    lualine_b = {"branch"},
    lualine_c = { diagnostics },
    lualine_x = { diff, spaces, "encoding", filetype },
    lualine_y = { location },
    lualine_z = { "progress" },
  },
}
