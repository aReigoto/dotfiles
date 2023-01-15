require "native-conf.options"
require "native-conf.keymaps"
require "plugins-conf"

-- require "plugins-conf.nvim-surround"
-- require "plugins-conf.grammarous"

require "plugins-conf.autocommands"
require "native-conf.commands"
require "dev.dev"
require "dev.spell"
require "dev.tools"

-- This will load a file that is ignored by git ;)
local status_ok, npairs = pcall(require, "local-conf.options")
if status_ok then
  require "local-conf.options"
end

