-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- add list of plugins to install
return packer.startup(function(use)
  -- packer can manage itself
  use("wbthomason/packer.nvim")

  -- prefered colorscheme
  use('ellisonleao/gruvbox.nvim')
 
  -- tmux & split window navigation
  use("christoomey/vim-tmux-navigator")

  -- maximizes and restores current window
  use("szw/vim-maximizer")

  -- essential plugins
  use("tpope/vim-surround")
  use("vim-scripts/ReplaceWithRegister")

  -- comment with gc
  use("numToStr/Comment.nvim")

  -- file explorer
  use({
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    tag = "nightly" -- optional, updated every week
  })

  -- fuzzy finding
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })
  use("nvim-lua/plenary.nvim")

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  })

  -- autocompletion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")

  -- snippets
  use({"L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*"})
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")

  -- The autocompletion works until these plugins below
  -- are installed. We'll see what happens after their installation.

  -- managing & installing lsp servers
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  -- configuring lsp servers
  use("neovim/nvim-lspconfig")
  use("hrsh7th/cmp-nvim-lsp")
  use({ "glepnir/lspsaga.nvim", branch = "main" })
  use("jose-elias-alvarez/typescript.nvim")
  use("onsails/lspkind.nvim")

  if packer_bootstrap then
    require("packer").sync()
  end
end)

