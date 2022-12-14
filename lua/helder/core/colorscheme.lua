local status, _ = pcall(vim.cmd, "colorscheme gruvbox")
if not status then
	print("Colorscheme not found!")
	return
end

function SetTranparentBackground(color)
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

SetTranparentBackground()
