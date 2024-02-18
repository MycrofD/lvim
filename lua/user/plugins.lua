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
  -- sourcery
  {
    "neoclide/coc.nvim",
    branch = "release",
  },
  -- MUST HAVES
  { "psf/black" },         -- black formatter for python
  { "microsoft/pyright" }, -- python language server
  { "LuaLS/lua-language-server" },
  { "astral-sh/ruff" },
  { "astral-sh/ruff-lsp" }, -- should gradually replace others like black
}
