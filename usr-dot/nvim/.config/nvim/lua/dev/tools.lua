--[[
To reload a package:
  package.loaded is a table that contains all poackeges like a global namesapce
:lua package.loaded["PACKAGE_NAME"] = nil
:lua require("PACKAGE_NAME")


NOTES:
:Telescope help_tags

From help files is a funtion starts with nvim_FUNC_NAME
in lua this maps to vim.api.nvim_FUNC_NAME

]]

P = function (v)
  -- Print a entire table, vim.inspect return the table as a string
  -- retrun v is just to help in development 
  -- To see all packages content run
  --  :lua P(package.loaded) 
  print(vim.inspect(v))
  return v
end

RP = function (p)
  -- Reload a package
  package.loaded[p]=nil
  require(p)
end
