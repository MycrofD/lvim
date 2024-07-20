lvim.plugins = {
  -- define your keymaps, commands, and autocommands as simple as Lua tables,
  -- building a legend at the same time
  {
    "mrjones2014/legendary.nvim",
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    priority = 10000,
    lazy = false,
    -- sqlite is only needed if you want to use frecency sorting
    -- dependencies = { 'kkharji/sqlite.lua' }
  },
  -- split and resize windows better
  { "beauwilliams/focus.nvim" },
  { "mrjones2014/smart-splits.nvim" },

  -- plugins for markdown
  -- -- headlines.nvim for markdown
  {
    "lukas-reineke/headlines.nvim",
    dependencies = { "nvim-treesitter" },
    config = true, -- or `opts = { }`
  },
  -- -- markdown.nvim for markdown
  -- {
  --   'MeanderingProgrammer/markdown.nvim',
  --   name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
  --   dependencies = { 'nvim-treesitter/nvim-treesitter' },
  --   config = function()
  --     require('render-markdown').setup({})
  --   end,
  -- },
  -- markdown-preview.nvim for markdown
  -- install without yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    autocmd = { "MarkdownPreview" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  -- peek.nvim for markdown preview
  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup({
        app = 'webview',
      })
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },

  -- find the enemy and replace them with dark power
  { "nvim-pack/nvim-spectre" },

  -- dim inactive portions of the code you are editing using TreeSitter
  -- pairs well with zen-mode
  { "folke/twilight.nvim" },
  -- distraction-free coding for Neovim
  { "folke/zen-mode.nvim" },
  -- TODO: Add better colour schemes for git diff
  -- https://github.com/LunarVim/Colorschemes/tree/master/colors
  -- https://github.com/sainnhe/sonokai

  -- minimap / scrollbar for vim, powered by code-minimap written in Rust
  {
    "wfxr/minimap.vim",
    build = "cargo install --locked code-minimap",
    cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight" },
    config = function()
      vim.cmd("let g:minimap_width = 10")
      vim.cmd("let g:minimap_auto_start = 1")
      vim.cmd("let g:minimap_auto_start_win_enter = 1")
    end,
  },
  -- neovim's answer to the mouse
  {
    "ggandor/leap.nvim",
    name = "leap",
    -- config = function()
    --   require("leap").add_default_mappings()
    -- end,
  },
  -- hint when you type
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
  },
  -- extensible UI for neovim notifications and LSP progress messages
  {
    "j-hui/fidget.nvim",
    opts = {}, -- options
  },
  -- A Filetype plugin for csv files
  -- { "chrisbra/csv.vim" },
  -- Highlight columns in CSV and TSV files and run queries in SQL-like language
  { "mechatroner/rainbow_csv" },

  -- debugging
  { "mfussenegger/nvim-dap" },        -- lunarvim already has nvim-dap, nvim-dap-ui
  { "mfussenegger/nvim-dap-python" }, -- lunarvim already has nvim-dap, nvim-dap-ui
  {                                   -- mason-nvim-dap bridges mason.nvim with the nvim-dap plugin - making it easier to use both plugins together.
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "python", },
        automatic_installation = true, -- installs the debuggers automatically via mason, e.g. debugpy for python listed above
      })
    end,

  },

  -- An extensible framework for interacting with tests within NeoVim.
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-plenary",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter"
    },
    config = function()
      require("neotest").setup({
        log_level = vim.log.levels.TRACE,
        adapters = {
          require("neotest-python")({
            -- Extra arguments for nvim-dap configuration
            -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
            dap = {
              justMyCode = false,
              console = "integratedTerminal",
            },
            args = { "--log-level", "DEBUG", "--quiet" },
            runner = "pytest",
          }),
          require("nvim-dap-virtual-text").setup({}),
          require("neotest-plenary"),
        }
      })
    end
  },
  --
  { "nvim-neotest/neotest-python" },
  -- add virtual text support to nvim-dap
  { "theHamsta/nvim-dap-virtual-text" },

  -- switch env
  {
    "Acksld/swenv.nvim", -- actual env switcher
    config = function()
      require('swenv').setup({
        post_set_env = function()
          vim.cmd("LspRestart")
        end,
      })
    end
  },
  -- improve the default vim.ui interfaces
  {
    "stevearc/dressing.nvim", -- will make the UI look nicer
    opts = {},
  },
  -- linting
  {
    "mfussenegger/nvim-lint",
  },
  -- vim-fugitive
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" }
  },
  -- neogit
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = true
  },

  -- git-blame
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      vim.g.gitblame_enabled = 0
    end,
  },
  -- https://github.com/folke/trouble.nvim
  -- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
  },
  -- https://github.com/folke/todo-comments.nvim
  -- Highlight, list and search todo comments in your projects
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },
  -- https://github.com/folke/persistence.nvim
  -- Simple session management for Neovim
  -- TODO: Config relevant key bindings
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {}
  },
  -- github copilot
  -- TODO: Refer official sources (https://github.com/zbirenbaum/copilot-cmp) for udpating the config
  -- TODO: Compare with https://youtu.be/Qf9gfx7gWEY?si=t40hoZSoQyNiOrSn&t=283
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()     -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
        require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
      end, 100)
    end,
  },
  -- Seamless navigation between tmux panes and vim splits
  -- https://github.com/christoomey/vim-tmux-navigator
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  -- https://github.com/tpope/vim-surround
  -- Delete/change/add parentheses/quotes/XML-tags/much more with ease
  { "tpope/vim-surround" },
  -- TODO: Add tpope/vim-repeat
  -- TODO: Add leap.nvim
  --
  -- Nodejs extension host for vim and neovim, load extensions like VSCode and host language servers
  -- Sourcery,
  -- coc-ruff - ruff-lsp extension for coc.nvim (coc-ruff or coc-pyright or coc-jedi or coc-pylsp)
  {
    'yaegassy/coc-ruff',
    build = 'yarn install --frozen-lockfile'
  },
  -- coc-explorer,
  -- etc.
  {
    "neoclide/coc.nvim",
    branch = "release",
  },
  -- The which-key plugin
  -- Create key bindings that stick.
  -- `WhichKey` is a `lua` plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- Your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  -- The telescope plugin
  -- Live grep with `args`
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
    },
    config = function()
      local telescope = require("telescope")

      -- First setup telescope
      telescope.setup({
        -- Your config
      })

      -- Then load the extension
      telescope.load_extension("live_grep_args")
    end
  },
  -- LazyDev - Faster LuaLS setup for Neovim
  -- and other helpers as per README
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  {                                        -- optional completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
  -- MUST HAVES -- Should probably be installed via Mason
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "rust_analyzer", "ruff", "ruff_lsp", "pyright" }
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
  },
}
