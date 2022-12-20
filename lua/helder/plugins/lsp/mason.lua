local mason_status, mason = pcall(require, "mason")
if not mason_status then
	print("mason not found")
	return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	print("mason-lspconfig not found")
	return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	print("mason-null-ls not found")
	return
end

mason.setup()

mason_lspconfig.setup({
	ensure_installed = {
		"tsserver",
		"html",
		"cssls",
		"jdtls",
		"angularls",
		"hls",
		"sumneko_lua",
		"emmet_ls",
	},

	-- auto install configured servers (with lpsconfig)
	-- automatic_installation = true,  not the same as ensure_installed
})

mason_null_ls.setup({
	ensure_installed = {
		"prettier",
		"stylua",
		"eslint_d",
		"google_java_format",
	},
	automatic_installation = true,
})
