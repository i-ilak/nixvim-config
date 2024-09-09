_: {
  plugins.lualine = {
    enable = true;
    settings = {
      theme = "catppuccin";
      globalstatus = true;
      options = {
        component_separators = {
          left = "";
          right = "";
        };
        section_separators = {
          left = "";
          right = "";
        };
        disabled_filetypes = {
          statusline = [ "startup" "alpha" ];
        };
      };
      extensions = [
        "fzf"
        "neo-tree"
      ];
      sections = {
        lualine_a = [
          {
            __unkeyed = "mode";
            icon.__unkeyed = " ";
          }
        ];
        lualine_b = [
          {
            __unkeyed = "branch";
            icon.__unkeyed = "";
          }
          {
            __unkeyed = "diff";
            symbols = {
              added = " ";
              modified = " ";
              removed = " ";
            };
          }
        ];
        lualine_c = [
          {
            __unkeyed = "diagnostics";
            sources = [ "nvim_lsp" ];
            symbols = {
              error = " ";
              warn = " ";
              info = " ";
              hint = "󰝶 ";
            };
          }
          {
            __unkeyed = "navic";
          }
        ];
        lualine_x = [
          {
            __unkeyed = "filetype";
            icon_only = true;
            separator = "";
            padding = {
              left = 1;
              right = 0;
            };
          }
          {
            __unkeyed = "filename";
            path = 1;
          }
        ];
        lualine_y = [
          "overseer"
          "progress"
        ];
        lualine_z = [
          "location"
        ];
      };
    };
  };
}
