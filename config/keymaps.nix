{ vimLib, ... }:
{
  globals = vimLib.nixvimGlobals;

  keymaps = vimLib.nixvimKeymaps ++ [
    # ── Neovim-only: plugin keymaps not in shared registry ──────────

    # Trailblazer (Lua callback - can't be in shared registry)
    {
      mode = [ "n" ];
      key = "<leader>m";
      action.__raw = ''
        function()
            local tb = require("trailblazer")
            tb.new_trail_mark()
            tb.open_trail_mark_list()
            vim.cmd('wincmd p')
        end
      '';
      options = {
        silent = true;
        noremap = true;
        desc = "Create new mark";
      };
    }

    # Leap
    {
      mode = [ "n" ];
      key = "<leader>fl";
      action = "<Plug>(leap-forward)";
      options = {
        silent = true;
        noremap = true;
        desc = "Leap forward";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>Fl";
      action = "<Plug>(leap-backward)";
      options = {
        silent = true;
        noremap = true;
        desc = "Leap backward";
      };
    }
  ];
}
