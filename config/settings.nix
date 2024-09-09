{
  config = {
    diagnostic.settings.virtual_text = false;

    extraConfigLuaPre =
      # lua
      ''
        vim.fn.sign_define("diagnosticsignerror", { text = " ", texthl = "diagnosticerror", linehl = "", numhl = "" })
        vim.fn.sign_define("diagnosticsignwarn", { text = " ", texthl = "diagnosticwarn", linehl = "", numhl = "" })
        vim.fn.sign_define("diagnosticsignhint", { text = "󰌵", texthl = "diagnostichint", linehl = "", numhl = "" })
        vim.fn.sign_define("diagnosticsigninfo", { text = " ", texthl = "diagnosticinfo", linehl = "", numhl = "" })
      '';

    clipboard = {
      register = [ "unnamed" "unnamedplus" ];
      providers.wl-copy.enable = true;
      providers.xclip.enable = true;
    };

    opts = {
      # Show line numbers
      number = true;

      # Show relative line numbers
      relativenumber = true;

      # Number of spaces that represent a <TAB>
      tabstop = 4;
      softtabstop = 4;

      # Show tabline always
      showtabline = 4;

      # Use spaces instead of tabs
      expandtab = true;

      # Enable smart indentation
      smartindent = true;

      # Number of spaces to use for each step of (auto)indent
      shiftwidth = 4;

      # Enable break indent
      breakindent = true;

      # Highlight the screen line of the cursor
      cursorline = true;

      # Minimum number of screen lines to keep above and below the cursor
      scrolloff = 8;

      # Enable mouse support
      mouse = "a";

      # Fold config
      foldcolumn = "0";
      fillchars =
        {
          eob = " ";
          fold = " ";
          foldopen = "▾";
          foldsep = " ";
          foldclose = "▸";
        };
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;

      # Wrap long lines at a character in 'breakat'
      linebreak = true;

      # Enable spell checking
      spell = true;

      # Enable swap file creation
      swapfile = true;

      # Time in milliseconds to wait for a mapped sequence to complete
      timeoutlen = 300;

      # Enable 24-bit RGB color in the TUI
      termguicolors = true;

      # Don't show mode in the command line
      showmode = false;

      # Open new split below the current window
      splitbelow = true;

      # Keep the screen when splitting
      splitkeep = "screen";

      # Open new split to the right of the current window
      splitright = true;

      # Hide command line unless needed
      cmdheight = 0;
    };
  };
}
