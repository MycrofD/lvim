--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]

-- vim options
require("user.options")

lvim.colorscheme = "tokyonight-night"

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = { "*.lua", "*.py", "*.json", "*.md", "*.tf", "*.toml", "*.yaml" },
  timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" }
}
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
-- lvim.colorscheme = "lunar"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- always installed on startup, useful for parsers without a strict filetype
-- e.g. for python, this will provide syntax highlighting, indentation, folding etc.
lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex", "python" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
reload("user.plugins")
-- Ruff LSP for Python
require("user.lsp.ruff_lsp")

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
--

-- set up debug adapter
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)


lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>",
  "Test Method" }
lvim.builtin.which_key.mappings["dM"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
  "Test Method DAP" }
lvim.builtin.which_key.mappings["dx"] = { "<cmd>lua require('neotest').run.stop()<cr>",
  "Stop Method" }
lvim.builtin.which_key.mappings["da"] = { "<cmd>lua require('neotest').run.attach()<cr>",
  "Attach to Method" }
lvim.builtin.which_key.mappings["df"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
lvim.builtin.which_key.mappings["dF"] = {
  "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" }
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }

-- set up spectre
lvim.builtin.which_key.mappings["ss"] = { '<cmd>lua require("spectre").toggle()<CR>', "Toggle Spectre" }
lvim.builtin.which_key.mappings["ssw"] = { '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
  "Search current word" }
lvim.builtin.which_key.mappings["ssw"] = { '<esc><cmd>lua require("spectre").open_visual()<CR>', "Search current word"
}
lvim.builtin.which_key.mappings["ssf"] = { '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
  "Search on current file"
}

-- set up trouble
lvim.builtin.which_key.mappings["x"] = {
  name = "Trouble",
  x = { "<cmd>Trouble diagnostics<cr>", "Diagnostics" },
  X = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer Diagnostics" },
  s = { "<cmd>Trouble symbols toggle focus=false<cr>", "Symbols" },
  l = { "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", "LSP Definitions / references / ..." },
  L = { "<cmd>Trouble loclist toggle", "Location List" },
  Q = { "<cmd>Trouble qflist toggle", "Quickfix List" },
}

-- config minimap and markdown
lvim.builtin.which_key.mappings["m"] = {
  -- minimap
  name = "Minimap/Markdown",
  m = { "<cmd>Minimap<cr>", "Open Minimap" },
  t = { "<cmd>MinimapToggle<cr>", "Toggle Minimap" },
  c = { "<cmd>MinimapClose<cr>", "Close Minimap" },
  r = { "<cmd>MinimapRefresh<cr>", "Refresh Minimap" },
  u = { "<cmd>MinimapUpdateHighlightcr>", "Update Highlight Minimap" },

  -- markdown with peek
  d = { "<cmd>PeekOpen<cr>", "Open Markdown" },
  x = { "<cmd>PeekClose<cr>", "Close Markdown" },
}
