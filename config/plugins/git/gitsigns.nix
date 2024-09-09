_: {
  plugins.gitsigns = {
    enable = true;
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
