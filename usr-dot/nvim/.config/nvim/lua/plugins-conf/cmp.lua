local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

--[[ Note LSP likes to talk whit cmp this interaction whas moved to lsp-conf....

The default way is this:
-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
capabilities = capabilities}
--]]

local kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
		  require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-S-n>'] = cmp.mapping.scroll_docs(-4),
		['<C-S-p>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
    -- This are the sources in display order
		{ name = "nvim_lua" },
		{ name = 'nvim_lsp' },
    	{ name = 'nvim_lsp_signature_help'},
		{ name = 'luasnip' },
    	{ name = "treesitter" },
    	{ name = "dictionary"},
	}, {
		{ name = 'buffer' },
		{ name = "path" },
	}),
	-- Display icons instead of CLASS, TEXT
	formatting = {
		format = function(entry, vim_item)
			-- Kind icons
			-- This concatonates the icons with the name of the item kind
			vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
			-- Source
			vim_item.menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
				latex_symbols = "[LaTeX]",
        dictionary = "[Dict]",
        nvim_lsp_signature_help = "[Sig]",
        treesitter = "[Tree]",
			})[entry.source.name]
			return vim_item
		end
	},
})

-- Use buffer source for `/`
-- cmp.setup.cmdline("/", {
--   sources = {
--     { name = "buffer" },
--   },
-- })

-- Use cmdline & path source for ':'
-- cmp.setup.cmdline(":", {
--   sources = cmp.config.sources({
--     { name = "path" },
--   }, {
--     { name = "cmdline" },
--   }),
-- })

