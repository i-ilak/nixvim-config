{
  opts.completeopt = [
    "menu"
    "menuone"
    "noselect"
  ];
  plugins = {
    cmp-emoji.enable = true;
    cmp = {
      enable = true;
      settings = {
        autoEnableSources = true;
        experimental = {
          ghost_text = false;
        };
        performance = {
          debounce = 60;
          fetchingTimeout = 200;
          maxViewEntries = 30;
        };
        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        formatting.fields = [
          "kind"
          "abbr"
          "menu"
        ];
        sources = [
          {
            name = "nvim_lsp";
            priority = 11;
          }
          {
            name = "nvim_lsp_signature_help";
            priority = 11;
          }
          {
            name = "buffer";
            priority = 10;
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            keywordLength = 3;
          }
          {
            name = "path";
            priority = 9;
            keywordLength = 3;
          }
          {
            name = "luasnip";
            keywordLength = 3;
          }
          {
            name = "nvim_lua";
          }
        ];

        window = {
          completion = {
            border = "solid";
          };
          documentation = {
            border = "solid";
          };
        };

        mapping = {
          "<Tab>" = "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
          "<esc>" = "cmp.mapping.abort()";
          "<C-Space>" = "cmp.mapping.complete()";
          "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })";
        };

        preselect = "cmp.PreselectMode.None";
      };
    };
    cmp-nvim-lsp.enable = true; # lsp
    cmp-buffer.enable = true;
    cmp-path.enable = true; # file system paths
    cmp_luasnip.enable = true; # snippets
    cmp-cmdline.enable = false; # autocomplete for cmdline
  };
  extraConfigLua = ''
        luasnip = require("luasnip")
        kind_icons = {
          Text = "󰊄",
          Method = " ",
          Function = "󰡱 ",
          Constructor = " ",
          Field = " ",
          Variable = "󱀍 ",
          Class = " ",
          Interface = " ",
          Module = "󰕳 ",
          Property = " ",
          Unit = " ",
          Value = " ",
          Enum = " ",
          Keyword = " ",
          Snippet = " ",
          Color = " ",
          File = "",
          Reference = " ",
          Folder = " ",
          EnumMember = " ",
          Constant = " ",
          Struct = " ",
          Event = " ",
          Operator = " ",
          TypeParameter = " ",
        } 

         local cmp = require'cmp'

     -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
     cmp.setup.cmdline({'/', "?" }, {
       sources = {
         { name = 'buffer' }
       }
     })

    -- Set configuration for specific filetype.
     cmp.setup.filetype('gitcommit', {
       sources = cmp.config.sources({
         { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
       }, {
         { name = 'buffer' },
       })
     })

     -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
     cmp.setup.cmdline(':', {
       sources = cmp.config.sources({
         { name = 'path' }
       }, {
         { name = 'cmdline' }
       }),
     })  '';
}
