-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/andre/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/andre/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/andre/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/andre/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/andre/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25plugins-conf.comment\frequire\0" },
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim",
    wants = { "nvim-treesitter" }
  },
  LuaSnip = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\18snippets-conf\frequire\0" },
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip",
    wants = { "friendly-snippets", "vim-snippets" }
  },
  ["alpha-nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins-conf.alpha\frequire\0" },
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins-conf.bufferline\frequire\0" },
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["cheatsheet.nvim"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/cheatsheet.nvim",
    url = "https://github.com/sudormrfbin/cheatsheet.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-dictionary"] = {
    after_files = { "/Users/andre/.local/share/nvim/site/pack/packer/opt/cmp-dictionary/after/plugin/cmp_dictionary.vim" },
    config = { "\27LJ\2\n;\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0 plugins-conf.cmp-dictionary\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/opt/cmp-dictionary",
    url = "https://github.com/uga-rosa/cmp-dictionary"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["darkplus.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\25colorscheme darkplus\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/darkplus.nvim",
    url = "https://github.com/lunarvim/darkplus.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26plugins-conf.gitsigns\frequire\0" },
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  harpoon = {
    config = { "\27LJ\2\nB\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\25plugins-conf.harpoon\frequire\0" },
    keys = { { "", "<leader>j" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/opt/harpoon",
    url = "https://github.com/ThePrimeagen/harpoon",
    wants = { "telescope.nvim" }
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n<\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0!plugins-conf.indentblankline\frequire\0" },
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim",
    wants = { "nvim-treesitter" }
  },
  ["jupyter-vim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\29plugins-conf.jupyter-vim\frequire\0" },
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/jupyter-vim",
    url = "https://github.com/jupyter-vim/jupyter-vim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25plugins-conf.lualine\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim",
    wants = { "nvim-web-devicons" }
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason-tool-installer.nvim"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/mason-tool-installer.nvim",
    url = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neodev.nvim"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/neodev.nvim",
    url = "https://github.com/folke/neodev.nvim"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14neoscroll\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/opt/neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27plugins-conf.autopairs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs",
    wants = { "nvim-treesitter" }
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins-conf.cmp\frequire\0" },
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp",
    wants = { "LuaSnip" }
  },
  ["nvim-dap"] = {
    after = { "nvim-dap-ui" },
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins-conf.dap\frequire\0" },
    keys = { { "", "<leader>d" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\nlsp-c\frequire\0" },
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27plugins-conf.nvim-tree\frequire\0" },
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "lualine.nvim" },
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins-conf.treesitter\frequire\0" },
    loaded = true,
    only_config = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-endwise"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-endwise",
    url = "https://github.com/RRethy/nvim-treesitter-endwise",
    wants = { "nvim-treesitter" }
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-treesitter-textsubjects"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textsubjects",
    url = "https://github.com/RRethy/nvim-treesitter-textsubjects"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\fdefault\2\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["project.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25plugins-conf.project\frequire\0" },
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/project.nvim",
    url = "https://github.com/ahmedkhalf/project.nvim"
  },
  ripgrep = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/ripgrep",
    url = "https://github.com/BurntSushi/ripgrep"
  },
  ["telescope-emoji.nvim"] = {
    config = { "\27LJ\2\n<\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0!plugins-conf.telescope-emoji\frequire\0" },
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/telescope-emoji.nvim",
    url = "https://github.com/xiyaowong/telescope-emoji.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27plugins-conf.telescope\frequire\0" },
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins-conf.toggleterm\frequire\0" },
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["vim-bbye"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/vim-bbye",
    url = "https://github.com/moll/vim-bbye"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/vim-easymotion",
    url = "https://github.com/easymotion/vim-easymotion"
  },
  ["vim-illuminate"] = {
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins-conf.illuminate\frequire\0" },
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/vim-snippets",
    url = "https://github.com/honza/vim-snippets"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  },
  ["vim-visual-multi"] = {
    config = { "\27LJ\2\n=\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\"plugins-conf.vim-visual-multi\frequire\0" },
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  ["vim-zoom"] = {
    loaded = true,
    path = "/Users/andre/.local/share/nvim/site/pack/packer/start/vim-zoom",
    url = "https://github.com/dhruvasagar/vim-zoom"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^harpoon"] = "harpoon",
  ["^harpoon%.cmd%-ui"] = "harpoon",
  ["^harpoon%.mark"] = "harpoon",
  ["^harpoon%.term"] = "harpoon",
  ["^harpoon%.ui"] = "harpoon"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\nlsp-c\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\26plugins-conf.gitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\fdefault\2\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27plugins-conf.nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\18snippets-conf\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: project.nvim
time([[Config for project.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25plugins-conf.project\frequire\0", "config", "project.nvim")
time([[Config for project.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins-conf.treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25plugins-conf.comment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: telescope-emoji.nvim
time([[Config for telescope-emoji.nvim]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0!plugins-conf.telescope-emoji\frequire\0", "config", "telescope-emoji.nvim")
time([[Config for telescope-emoji.nvim]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\n<\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0!plugins-conf.indentblankline\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: alpha-nvim
time([[Config for alpha-nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23plugins-conf.alpha\frequire\0", "config", "alpha-nvim")
time([[Config for alpha-nvim]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins-conf.toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Config for: bufferline.nvim
time([[Config for bufferline.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins-conf.bufferline\frequire\0", "config", "bufferline.nvim")
time([[Config for bufferline.nvim]], false)
-- Config for: vim-visual-multi
time([[Config for vim-visual-multi]], true)
try_loadstring("\27LJ\2\n=\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\"plugins-conf.vim-visual-multi\frequire\0", "config", "vim-visual-multi")
time([[Config for vim-visual-multi]], false)
-- Config for: darkplus.nvim
time([[Config for darkplus.nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\25colorscheme darkplus\bcmd\bvim\0", "config", "darkplus.nvim")
time([[Config for darkplus.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21plugins-conf.cmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: jupyter-vim
time([[Config for jupyter-vim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\29plugins-conf.jupyter-vim\frequire\0", "config", "jupyter-vim")
time([[Config for jupyter-vim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27plugins-conf.telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: vim-illuminate
time([[Config for vim-illuminate]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28plugins-conf.illuminate\frequire\0", "config", "vim-illuminate")
time([[Config for vim-illuminate]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd lualine.nvim ]]

-- Config for: lualine.nvim
try_loadstring("\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25plugins-conf.lualine\frequire\0", "config", "lualine.nvim")

time([[Sequenced loading]], false)
-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> <leader>d <cmd>lua require("packer.load")({'nvim-dap'}, { keys = "<lt>leader>d", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>j <cmd>lua require("packer.load")({'harpoon'}, { keys = "<lt>leader>j", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType O2 ++once lua require("packer.load")({'cmp-dictionary'}, { ft = "O2" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-treesitter-endwise', 'nvim-autopairs'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'neoscroll.nvim'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
