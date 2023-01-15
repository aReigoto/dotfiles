local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	 -- one of "all" or a list of languages
	ensure_installed = {"lua", "python", "cpp"},
  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing
	ignore_install = { "" },
  highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
	},

  autopairs = {
		enable = true,
	},

  rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },

  indent = { enable = true, disable = { "python", "java", "rust", "lua" } },

  -- vim-matchup
  matchup = {
    enable = true,
  },

  -- nvim-treesitter-textsubjects
  textsubjects = {
    enable = true,
    prev_selection = ",", -- (Optional) keymap to select the previous selection
    keymaps = {
      ["."] = "textsubjects-smart",
      [";"] = "textsubjects-container-outer",
      ["i;"] = "textsubjects-container-inner",
    },
  },

  -- nvim-treesitter-textobjects
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
      },
      selection_modes = {
        ["@parameter.outer"] = "v", -- charwise
        ["@function.outer"] = "V", -- linewise
        ["@class.outer"] = "<c-v>", -- blockwise
      },
    },

    swap = {
      enable = true,
      swap_next = {
        ["<leader>cx"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>cX"] = "@parameter.inner",
      },
    },

    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },

    -- lsp_interop = {
    --   enable = true,
    --   border = "none",
    --   peek_definition_code = {
    --     ["<leader>cf"] = "@function.outer",
    --     ["<leader>cF"] = "@class.outer",
    --   },
    -- },
  },

  -- endwise
  endwise = {
    enable = true,
  },

  -- autotag
--  autotag = {
--    enable = true,
--  },

  -- context_commentstring
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },

  -- indent
  -- yati = { enable = true },

  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
  },

  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },

})
