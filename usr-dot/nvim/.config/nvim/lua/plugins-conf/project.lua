local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
	return
end
project.setup({

	-- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
	detection_methods = { "pattern" },

	-- patterns used to detect root dir, when **"pattern"** is in detection_methods
	patterns = { ".git", "Makefile", "package.json" },
})

local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then
	return
end

telescope.load_extension('projects')

function _ADD_CURR_DIR_TO_PROJECTS()
  local historyfile = require("project_nvim.utils.path").historyfile
  local curr_directory = vim.fn.expand("%:p:h")
  vim.cmd("!echo " .. curr_directory .. " >> " .. historyfile)
  print(curr_directory .. " added to: " .. historyfile )
end

vim.cmd("command! ProjectAddMuanually lua _ADD_CURR_DIR_TO_PROJECTS()")
