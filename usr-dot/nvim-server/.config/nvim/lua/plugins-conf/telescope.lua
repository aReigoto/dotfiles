local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local telescopeConfig = require("telescope.config")
local actions = require "telescope.actions"

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules" },
    -- `hidden = true` is not supported in text grep commands.
    vimgrep_arguments = vimgrep_arguments,

    -- See all mapings in ~/.local/share/nvim/site/pack/packer/start/telescope.nvim/lua/telescope/mappings.lua
    mappings = {
      i = {
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-w>"] = actions.send_to_qflist + actions.open_qflist,
      },
    },
  },
	pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
	},
}
