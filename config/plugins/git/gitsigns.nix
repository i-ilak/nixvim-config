_: {
  plugins.gitsigns = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        event = "CursorHold";
      };
    };
    settings = {
      signs = {
        add = {
          text = "┃";
        };
        change = {
          text = "┃";
        };
        delete = {
          text = "_";
        };
        untracked = {
          text = "┆";
        };
        topdelete = {
          text = "‾";
        };
        changedelete = {
          text = "~";
        };
      };
    };
  };
}
