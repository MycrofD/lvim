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
  -- headlines.nvim for markdown
  {
    "lukas-reineke/headlines.nvim",
    dependencies = { "nvim-treesitter" },
    config = true, -- or `opts = { }`
  },
  -- install without yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    autocmd = { "MarkdownPreview" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
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
    -- cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
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
    event = "BufRead",
    config = function() require "lsp_signature".on_attach() end,
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
  { "nvim-neotest/neotest" },
  { "nvim-neotest/neotest-python" },
  { "nvim-neotest/nvim-nio" },
  -- add virtual text support to nvim-dap
  { "theHamsta/nvim-dap-virtual-text" },

  -- switch env
  {
    "Acksld/swenv.nvim", -- actual env switcher
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
  -- git-blame
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      vim.g.gitblame_enabled = 0
    end,
  },
  -- diffview
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  -- https://github.com/folke/trouble.nvim
  -- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
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
  -- coc-ruff or coc-pyright or coc-jedi or coc-pylsp,
  -- coc-explorer,
  -- etc.
  {
    "neoclide/coc.nvim",
    branch = "release",
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
  -- MUST HAVES -- Should probably be installed via Mason
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
        "ruff",
        "ruff-lsp",
        "nvim-lspconfig",
        "pyright",
        "debugpy",
      }
    }
  },
  -- { "psf/black" },         -- black formatter for python
  -- { "microsoft/pyright" }, -- python language server
  -- { "LuaLS/lua-language-server" },
  -- { "astral-sh/ruff" },
  -- { "astral-sh/ruff-lsp" }, -- should gradually replace others like black
}
