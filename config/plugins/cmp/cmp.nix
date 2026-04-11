{
  plugins = {
    blink-cmp = {
      enable = true;
      settings = {
        completion = {
          ghost_text.enabled = false;
          accept.auto_brackets.enabled = true;
          menu.max_height = 30;
          menu.border = "solid";
          documentation = {
            auto_show = true;
            window.border = "solid";
          };
        };

        snippets.preset = "luasnip";

        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
          providers = {
            buffer = {
              min_keyword_length = 3;
              score_offset = -3;
            };
            path = {
              min_keyword_length = 3;
            };
            snippets = {
              min_keyword_length = 3;
              max_items = 8;
            };
          };
        };

        keymap = {
          preset = "none";
          "<Tab>" = [
            "select_next"
            "fallback"
          ];
          "<S-Tab>" = [
            "select_prev"
            "fallback"
          ];
          "<CR>" = [
            "accept"
            "fallback"
          ];
          "<C-Space>" = [
            "show"
          ];
          "<Esc>" = [
            "cancel"
            "fallback"
          ];
        };

        appearance = {
          use_nvim_cmp_as_default = false;
          nerd_font_variant = "mono";
          kind_icons = {
            Text = "󰊄 ";
            Method = "󰊕 ";
            Function = "󰡱 ";
            Constructor = "󰊕 ";
            Field = "󰜢 ";
            Variable = "󱀍 ";
            Class = "󰠱 ";
            Interface = "󰜰 ";
            Module = "󰕳 ";
            Property = "󰜢 ";
            Unit = "󰑭 ";
            Value = "󰎠 ";
            Enum = "󰕘 ";
            Keyword = "󰌋 ";
            Snippet = "󰩫 ";
            Color = "󰏘 ";
            File = "󰈙 ";
            Reference = "󰈇 ";
            Folder = "󰉋 ";
            EnumMember = "󰕘 ";
            Constant = "󰏿 ";
            Struct = "󰠱 ";
            Event = "󰉁 ";
            Operator = "󰆕 ";
            TypeParameter = "󰊄 ";
          };
        };
      };
    };
  };
}
