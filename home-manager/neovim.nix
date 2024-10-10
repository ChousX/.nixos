{outputs, pkgs, ...}:
{
  nixpkgs.overlays = [
    outputs.overlays.nvimPlugins
  ];
 
  programs.neovim = 
  let 
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;
    extraLuaConfig = ''
      local o = vim.o
      local wo = vim.wo
      local bo = vim.bo
      local opt = vim.opt
      o.completeopt = "menuone,noinsert,noselect"
      o.background = 'dark'
      o.dir = '/tmp'
      o.smartcase = true
      o.laststatus = 2
      o.hlsearch = true
      o.incsearch = true
      o.ignorecase = true
      o.scrolloff = 12
      wo.number = true
      wo.wrap = false
      bo.filetype = 'lua'

      opt.shortmess = opt.shortmess + "c"
      opt.autoindent = true
      opt.cursorline = true
      opt.tabstop = 2
      opt.shiftwidth = 2
      opt.softtabstop = 2
      opt.expandtab = true

      local function on_attach(client, buffer)
        -- This callback is called when the LSP is atttached/enabled for this buffer
        -- we could set keymaps related to LSP, etc here.
	local keymap_opts = { buffer = buffer }
        -- Code navigation and shortcuts
        vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, keymap_opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.implementation, keymap_opts)
        vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, keymap_opts)
        vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, keymap_opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
        vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, keymap_opts)
        vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
	vim.keymap.set("n", "ga", vim.lsp.buf.code_action, keymap_opts)
      end
      local opts = {
        server = {
          on_attach = on_attach,
	  settings = {
	    ["rust-analyzer"] = {
	      checkOnSave = {
	        command = "clippy",
	      },
	    },
	  },
	},
	tools = {
          runnables = {
            use_telescope = true,
          },
          inlay_hints = {
            auto = true,
            show_parameter_hints = true;
            -- parameter_hints_prefix = "",
            -- other_hints_prefix = "",
          },
        },
      }
      vim.opt.updatetime = 100
      -- Show diagnostic popup on cursor hover
      local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
         vim.diagnostic.open_float(nil, { focusable = false })
        end,
        group = diag_float_grp,
      })

      -- Goto previous/next diagnostic warning/error
      vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, keymap_opts)
      vim.keymap.set("n", "g]", vim.diagnostic.goto_next, keymap_opts)
      -- have a fixed column for the diagnostics to appear in
      -- this removes the jitter when warnings/errors flow in
      vim.wo.signcolumn = "yes"
      local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.rs",
        callback = function()
          vim.lsp.buf.format({ timeout_ms = 200 })
        end,
        group = format_sync_grp,
      })
      '';

    plugins = with pkgs.vimPlugins; [
      mason-nvim
      mason-lspconfig-nvim
      nvim-lspconfig
      cmp-nvim-lsp
      cmp-vsnip
      cmp-path
      cmp-buffer
      vim-vsnip
      {
        plugin = rust-tools-nvim;
	config = toLua ''
	  require("rust-tools").setup(opts)
	'';
      }

      {
        plugin = nvim-cmp;
	config = toLua ''
	  local cmp = require("cmp")
	  cmp.setup({
	    preselect = cmp.PreselectMode.None;
	    snippet = {
	      expand = function(args)
	        vim.fn["vsnip#anonymous"](args.body)
	      end,
	    },
	    mapping = {
	      ["<C-p>"] = cmp.mapping.select_prev_item(),
              ["<C-n>"] = cmp.mapping.select_next_item(),
              -- Add tab support
              ["<S-Tab>"] = cmp.mapping.select_prev_item(),
              ["<Tab>"] = cmp.mapping.select_next_item(),
              ["<C-d>"] = cmp.mapping.scroll_docs(-4),
              ["<C-f>"] = cmp.mapping.scroll_docs(4),
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<C-e>"] = cmp.mapping.close(),
              ["<CR>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
              }),
	        },
	        sources = {
	          {name = "nvim_lsp" },
	          {name = "vsnip" },
	          {name = "path" },
	          {name = "buffer" },
	        },
	      })
	    '';
      }

      {
        plugin = fidget-nvim;
        config = toLua ''
          require("fidget").setup{}
        '';
      }
      popup-nvim
      plenary-nvim
      telescope-nvim
      lspsaga-nvim
      nvim-dap
      nvim-dap-ui
      nvim-treesitter.withAllGrammars
      {
        plugin = kanagawa-theme;
	config = "colorscheme kanagawa";
      }
    ];

    extraPackages = with pkgs; [
      xclip
      wl-clipboard
      graphviz
      rust-analyzer
      cargo
      lldb
      macdylibbundler
    ];
  };
}
