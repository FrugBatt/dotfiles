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

-- Use a protected call so we don't error out on first use
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

return packer.startup(function(use)
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  use({
    "lewis6991/impatient.nvim",
    config = function()
      require("impatient")
    end,
	})

  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim

  use({ "norcalli/nvim-base16.lua" }) -- Custom theme
  
  use("kyazdani42/nvim-web-devicons") -- Required
  -- Custom status bar 
	use({
    "nvim-lualine/lualine.nvim",
    after = "nvim-web-devicons",
    event = "BufRead",
    config = function()
      require("plugins.configs.lualine")
    end,
	})
  -- Custom buffer bar
	use({
    "akinsho/bufferline.nvim",
    after = "nvim-web-devicons",
    tag = "*",
    event = "BufRead",
    config = function()
      require("plugins.configs.bufferline")
    end,
	})

  -- Indent markers
  use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("plugins.configs.indentline")
    end,
	})

  -- Nvim color
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("plugins.configs.colorizer")
    end,
	})

  -- Treesitter syntax
	use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("plugins.configs.treesitter")
    end,
	})
	use({ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" })

  -- Git improvements 
	use({
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		config = function()
			require("plugins.configs.gitsigns")
		end,
	})

  -- Highlight args
	use({
		"m-demare/hlargs.nvim",
		event = "BufRead",
		config = function()
			require("hlargs").setup()
		end,
	})
  
  -- Close buffers
	use({ "moll/vim-bbye", event = "BufRead" })

  -- Terminal
	use({
    "akinsho/toggleterm.nvim",
    keys = { "<C-\\>" },
    config = function()
      require("toggleterm").setup({
        size = 70,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 3,
        start_in_insert = true,
        insert_mappings = false,
        persist_size = false,
        direction = "vertical",
        close_on_exit = true,
        shell = vim.o.shell,
      })
    end,
	})

  -- Fix
  use({ "antoinemadec/FixCursorHold.nvim", event = "BufEnter" })
  
  -- Autosave
  use({
    "Pocco81/AutoSave.nvim",
    event = "BufEnter",
    config = function()
      require("plugins.configs.autosave")
    end,
	})

  -- Notifications
	use({
    "rcarriga/nvim-notify",
    config = function()
      require("plugins.configs.notify")
    end,
	})

  -- Fix jk escape 
	use({
    "max397574/better-escape.nvim",
    event = "BufRead",
    config = function()
      require("plugins.configs.better-escape")
    end,
	})

  -- UI
  use({
    "Pocco81/TrueZen.nvim",
    event = "BufRead",
    config = function()
      require("plugins.configs.truezen")
    end,
	})

  -- New comment types
  use({ "folke/trouble.nvim" })
	use({
		"folke/todo-comments.nvim",
		event = "BufEnter",
		config = function()
			require("plugins.configs.todo-comments")
		end,
	})

	use({
		"nacro90/numb.nvim",
		event = "BufEnter",
		config = function()
			require("numb").setup({
				show_numbers = true,
				show_cursorline = true,
				number_only = false,
				centered_peeking = true,
			})
		end,
	})

  -- Underline focused word
	use({ "xiyaowong/nvim-cursorword", keys = { "h", "j", "k", "l" } })

  -- Right info panel
	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("plugins.configs.symbols-outline")
		end,
	})

	use({
		"mizlan/iswap.nvim",
		event = "BufRead",
		config = function()
			require("iswap").setup({
				keys = "qwertyuiop",
				grey = "disable",
				hl_snipe = "ErrorMsg",
				hl_selection = "WarningMsg",
				hl_grey = "LineNr",
				autoswap = true,
				debug = nil,
				hl_grey_priority = "1000",
			})
		end,
	})

  -- Smooth scroll
	use({
		"karb94/neoscroll.nvim",
		keys = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
		config = function()
			require("plugins.configs.neoscroll")
		end,
	})

  -- Better window manager
	use({
		"sindrets/winshift.nvim",
		event = "BufRead",
		config = function()
			require("plugins.configs.winshift")
		end,
	})

	use({ "monaqa/dial.nvim" })

	use({ "rmagatti/alternate-toggler", event = "BufRead" })

	use({ "danymat/neogen" })

	use({ "winston0410/cmd-parser.nvim" })

	use({
		"ggandor/leap.nvim",
		keys = { "s", "S" },
		config = function()
			require("leap").set_default_keymaps()
		end,
	})

	use({
		"windwp/nvim-ts-autotag",
		ft = "html",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})

	use({
		"kevinhwang91/nvim-hlslens",
		keys = { "/" },
		config = function()
			require("hlslens").setup({
				calm_down = true,
				nearest_only = true,
				nearest_float_when = "auto",
			})
		end,
	})

	use({
		"beauwilliams/focus.nvim",
		config = function()
			require("focus").setup({
				excluded_filetypes = {
					"toggleterm",
					"Trouble",
					"neo-tree",
					"Outline",
				},
			})
		end,
	})

	use({
		"ellisonleao/glow.nvim",
		branch = "main",
		ft = "markdown",
		config = function()
			require("plugins.configs.glow")
		end,
	})

	use({
		"s1n7ax/nvim-window-picker",
		tag = "v1.*",
		event = "BufRead",
		config = function()
			require("window-picker").setup()
		end,
	})

	use({
		"michaelb/sniprun",
		event = "BufRead",
		run = "bash install.sh",
	})

	use({
		"rmagatti/goto-preview",
		event = "BufRead",
		config = function()
			require("goto-preview").setup({})
		end,
	})

	use({
		"rafamadriz/friendly-snippets",
	})

	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("plugins.configs.cmp")
		end,
	})

	use({
		"L3MON4D3/LuaSnip",
	})

	use({
		"saadparwaiz1/cmp_luasnip",
	})

	use({
		"hrsh7th/cmp-nvim-lua",
	})

	use({
		"hrsh7th/cmp-buffer",
	})

	use({
		"hrsh7th/cmp-path",
	})

	use({
		"dmitmel/cmp-cmdline-history",
	})

	use({
		"hrsh7th/cmp-cmdline",
	})

	use({
		"hrsh7th/cmp-nvim-lsp",
	})

	use({
		"hrsh7th/cmp-emoji",
	})

	use({
		"hrsh7th/cmp-calc",
	})

	use({
		"hrsh7th/cmp-nvim-lsp-signature-help",
	})

	use({
		"williamboman/nvim-lsp-installer",
		config = function()
			require("plugins.lsp.lsp")
		end,
	})

	use({ "neovim/nvim-lspconfig" })
	use({ "tamago324/nlsp-settings.nvim" })
	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({ "onsails/lspkind.nvim" })

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.configs.autopairs")
		end,
	})

	use({
		"goolord/alpha-nvim",
		config = function()
			require("plugins.configs.alpha")
		end,
	})

	use({
		"numToStr/Comment.nvim",
		module = "Comment",
		event = "BufEnter",
		config = function()
			require("plugins.configs.comment")
		end,
	})

	use({
		"nvim-neo-tree/neo-tree.nvim",
		after = "alpha-nvim",
		branch = "v2.x",
		requires = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("plugins.configs.neotree")
		end,
	})

	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("plugins.configs.telescope")
		end,
	})

	use({
		"ahmedkhalf/project.nvim",
		after = "telescope.nvim",
		config = function()
			require("plugins.configs.project")
		end,
	})

	use({
		"Shatur/neovim-session-manager",
		after = "project.nvim",
		config = function()
			require("plugins.configs.session-manager")
		end,
	})

	use({
		"SmiteshP/nvim-gps",
		requires = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.configs.gps")
		end,
	})

	use({
		"filipdutescu/renamer.nvim",
		branch = "master",
		requires = { { "nvim-lua/plenary.nvim" } },
		event = "BufRead",
		config = function()
			require("plugins.configs.renamer")
		end,
	})
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

