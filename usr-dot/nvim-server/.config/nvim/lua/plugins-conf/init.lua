
 --[[
local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local packer_grp = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd(
  { "BufWritePost" },
  { pattern = "init.lua", command = "source <afile> | PackerCompile", group = packer_grp }
)

-- Use a protected call, so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Have packer manage itself
  use { "wbthomason/packer.nvim" }

  -- Colorschemes
  use { "lunarvim/darkplus.nvim",
    config = function ()
      vim.cmd "colorscheme darkplus"
    end,
    disable = false,
  }

  -- File tree
  use { "kyazdani42/nvim-tree.lua",
    config = function()
      require "plugins-conf.nvim-tree"
    end,
  }

  -- Word motion
  -- Easymotion
  use { "easymotion/vim-easymotion" }
  -- Alternative to check
  -- use {"justinmk/vim-sneak"}
  -- use {"ggandor/leap.nvim"}

  -- Tmux and vim window navegation
  use { "christoomey/vim-tmux-navigator",
    config = function ()
      require "plugins-conf.vim-tmux-nav"
    end,
    disable = false,
  }

  -- Multi cursor
  use { "mg979/vim-visual-multi",
    config = function()
      require "plugins-conf.vim-visual-multi"
    end,
  }

  -- Icons for filetypes and more
  -- NOTE: Make sure that https://www.nerdfonts.com/ is installed and enabled on the edditor 
  use { "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup { default = true }
    end,
  }

  -- Show open buffers
  use { "akinsho/bufferline.nvim",
    config = function()
      require "plugins-conf.bufferline"
    end,
    requires = { "nvim-web-devicons" }
  }

  -- Status bar  
  use { "nvim-lualine/lualine.nvim",
    after = "nvim-treesitter",
    config = function()
      require "plugins-conf.lualine"
    end,
    wants = "nvim-web-devicons",
  }

  -- Close buffers without clossing windows
  use { "moll/vim-bbye" }

  -- Terminal in nvim
  use { "akinsho/toggleterm.nvim",
    config = function()
      require "plugins-conf.toggleterm"
    end,
  }

  -- Customizable open window
  use { "goolord/alpha-nvim",
        config = function()
          require "plugins-conf.alpha"
        end,
  }

  -- Surround "" {} []
  use { "tpope/vim-surround" }


  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
--]]