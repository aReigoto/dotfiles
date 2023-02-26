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

  use { "AlessandroYorba/Despacio",
    config = function ()
      vim.cmd "let g:despacio_Midnight = 1"
      vim.cmd "colorscheme despacio"
    end,
    disable = true,
  }

  use { "AlessandroYorba/Alduin",
    config = function ()
      vim.cmd "colorscheme alduin"
      vim.cmd "hi Normal guibg=NONE"
      vim.cmd "hi String guibg=NONE"
      vim.cmd "hi SignColumn guibg=NONE"
      vim.cmd "hi LineNr guibg=NONE"
      vim.cmd "hi VertSplit guifg=101 guibg=NONE"
      vim.cmd "hi FloatBorder guibg=NONE"
      vim.cmd "hi NvimTreeNormal guibg=NONE"
      vim.cmd "hi StatusLine guibg=#282d3f"
    end,
    disable = true,
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

  -- Show indentation, this can use treesitter check configs
  use { "lukas-reineke/indent-blankline.nvim",
    -- event = "BufReadPre",
    config = function()
      require "plugins-conf.indentblankline"
    end,
    wants = "nvim-treesitter",
  }

  -- Treesitter, a language parser for beterr sintax highlighting and more
  use { "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require "plugins-conf.treesitter"
    end,
    requires = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "windwp/nvim-ts-autotag" },
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      { "p00f/nvim-ts-rainbow" },
      { "RRethy/nvim-treesitter-textsubjects" },
      { "nvim-treesitter/playground"},
      -- { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPre" },
      -- { "yioneko/nvim-yati", event = "BufReadPre" },
    },
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

  -- Telescope fuzzy finder
  use { "nvim-telescope/telescope.nvim",
    config = function()
      require "plugins-conf.telescope"
    end,
    requires = {
      -- All the lua functions I don't want to write twice.
      "nvim-lua/plenary.nvim",
      -- To enable live_grep and grep_string in telescope
      "BurntSushi/ripgrep",
      -- Cheatsheet integrated in telescope
      "sudormrfbin/cheatsheet.nvim",
      -- Emoji search
      { "xiyaowong/telescope-emoji.nvim",
        config = function()
          require "plugins-conf.telescope-emoji"
        end,
      },
      -- Go to projects
      { "ahmedkhalf/project.nvim",
        config = function()
          require "plugins-conf.project"
        end,
      },
    },
  }

  -- Close buffers without clossing windows
  use { "moll/vim-bbye" }

  -- Terminal in nvim
  use { "akinsho/toggleterm.nvim",
    config = function()
      require "plugins-conf.toggleterm"
    end,
  }
  -- cmp autocompleat
  -- The completion plugin
  use { "hrsh7th/nvim-cmp",
    -- event = "InsertEnter",
    wants = { "LuaSnip" },
    config = function()
      require "plugins-conf.cmp"
    end,
    requires = {
      -- buffer completions
      "hrsh7th/cmp-buffer",
      -- path completions
      "hrsh7th/cmp-path",
      -- Nvim lua, a nice to have for nvim configs
      "hrsh7th/cmp-nvim-lua",
      -- Enable lsp completions
      "hrsh7th/cmp-nvim-lsp",
      -- Lsp function arguments
      "hrsh7th/cmp-nvim-lsp-signature-help",
      -- cmp for cmdline
      "hrsh7th/cmp-cmdline",
      -- Source for getting completions from cmpline
      "dmitmel/cmp-cmdline-history",
      -- snippet completions
      "saadparwaiz1/cmp_luasnip",
      -- Dictionary completion
      { "uga-rosa/cmp-dictionary",
        ft = { "O2" },
        config = function()
          require "plugins-conf.cmp-dictionary"
        end,
      },
      -- Snippets
      { "L3MON4D3/LuaSnip",
        wants = { "friendly-snippets", "vim-snippets" },
        config = function()
          require("snippets-conf").setup()
        end,
      },
      "rafamadriz/friendly-snippets",
      "honza/vim-snippets",
    },
  }

  use { "neovim/nvim-lspconfig",
    config = function()
      -- require("lsp-c").setup()
      require("lsp-conf")
    end,
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      -- "folke/lua-dev.nvim",
      "folke/neodev.nvim",
      -- Automatically highlighting instances current word under the cursor using LSP
      { "RRethy/vim-illuminate",
        config = function ()
          require "plugins-conf.illuminate"
        end
      },
      "jose-elias-alvarez/null-ls.nvim",
    }
  }

  -- Jupyter interaction
  use { "jupyter-vim/jupyter-vim",
    config = function()
      require "plugins-conf.jupyter-vim"
    end,
  }
  -- Customizable open window
  use { "goolord/alpha-nvim",
        config = function()
          require "plugins-conf.alpha"
        end,
  }

  -- Comments
  use { "numToStr/Comment.nvim",
        wants = "nvim-treesitter",
        config = function()
          require "plugins-conf.comment"
        end,
  }

  -- Surround "" {} []
  use { "tpope/vim-surround" }

  -- Autopairs, integrates with both cmp and treesitter
  use { "windwp/nvim-autopairs",
        opt = true,
        event = "InsertEnter",
        wants = "nvim-treesitter",
        config = function()
          require "plugins-conf.autopairs"
        end,
  }

  -- End wise
  use { "RRethy/nvim-treesitter-endwise",
        opt = true,
        wants = "nvim-treesitter",
        event = "InsertEnter",
        disable = false,
  }

  -- DAP debug application protocol
  use { "mfussenegger/nvim-dap",
    opt = true,
    keys = { [[<leader>d]] },
    config = function()
      require("plugins-conf.dap")
    end,
    requires = { "rcarriga/nvim-dap-ui",
      -- "mfussenegger/nvim-dap-python",
    }
  }

  -- Git
  use { "lewis6991/gitsigns.nvim",
   config = function()
     require "plugins-conf.gitsigns"
    end
  }

  use {
    "karb94/neoscroll.nvim",
    event = "BufReadPre",
    config = function()
      require("neoscroll").setup()
    end,
    disable = false,
  }

  -- Harpoon
  use {
    "ThePrimeagen/harpoon",
    keys = { [[<leader>j]] },
    module = { "harpoon", "harpoon.cmd-ui", "harpoon.mark", "harpoon.ui", "harpoon.term" },
    wants = { "telescope.nvim" },
    config = function()
      require("plugins-conf.harpoon").setup()
    end,
  }

  -- Zoom a buffer
  use { "dhruvasagar/vim-zoom" }

  use { "nyngwang/NeoZoom.lua",
    config = function ()
      require("plugins-conf.neo-zoom")
    end,
    disable = true,
  }

--[[

  -- Icons for cmd
  -- use { "onsails/lspkind" }

  --  Speling and grammar check
  use { "rhysd/vim-grammarous" }

  -- Auto tag
   use { "windwp/nvim-ts-autotag",
    -- opt = true,
--    wants = "nvim-treesitter",
      event = "InsertEnter",
      config = function() 
        require("nvim-ts-autotag").setup{ enable = true }
      end,
    }

  -- Unicode Test
  use { "chrisbra/unicode.vim" }

  A list o plugings for nvim
  https://nvimluau.dev/

  MarkDown
  https://github.com/nvim-neorg/neorg

  Vim game
  https://github.com/ThePrimeagen/vim-be-good

  -- Speed up neovim loading time
  use { "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" }

  --]]
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
