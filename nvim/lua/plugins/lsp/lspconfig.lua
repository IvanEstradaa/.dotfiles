return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    vim = vim

    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    -- import mason_lspconfig plugin
    local mason_lspconfig = require("mason-lspconfig")

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness

    vim.api.nvim_create_autocmd("LspAttach", {
      -- group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = false }

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>lD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "<leader>lp", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "<leader>ln", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

        -- keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        -- keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        -- keymap.set("n", "<leader>lf", vim.lsp.buf.format)
        -- keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
        -- keymap.set("n", "<leader>lr", function() vim.lsp.buf.rename() end, opts)
        -- keymap.set("n", "<leader>lk", function() vim.diagnostic.open_float() end, opts)
        -- keymap.set("n", "<leader>ln", function() vim.diagnostic.goto_next() end, opts)
        -- keymap.set("n", "<leader>lp", function() vim.diagnostic.goto_prev() end, opts)
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
		--   local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		--   for type, icon in pairs(signs) do
		-- 	local hl = "DiagnosticSign" .. type
		-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		--     -- https://github.com/AnirudhG07/dotfiles/blob/6d75616e1f059753fe27f8377a82560c6476b725/nvim/.config/nvim/lua/anirudh/plugins/lsp/lspconfig.lua#L79
		-- 	-- vim.diagnostic.config({
		-- 	-- 	signs = {
		-- 	-- 		text = icon,
		-- 	-- 		linehl = hl,
		-- 	-- 		numhl = "",
		-- 	-- 	},
		-- 	-- })
		-- end

    -- https://github.com/NvChad/ui/issues/303
    local x = vim.diagnostic.severity

    vim.diagnostic.config {
      virtual_text = { prefix = ' '},
      signs = { text = { [x.ERROR] = ' ',  [x.WARN] = ' ', [x.INFO] = '󰠠 ', [x.HINT] = ' ' } },
      underline = true,
    }

    mason_lspconfig.setup({

      handlers = {
        -- default handler for installed servers
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
        ["lua_ls"] = function()
          -- configure lua server (with special settings)
          lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                -- make the language server recognize "vim" global
                diagnostics = {
                  globals = { "vim", 'hs'},
                },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          })
        end,
      },

    })


  end,
}
