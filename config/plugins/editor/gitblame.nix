_: {
  plugins.gitblame = {
    enable = true;
    settings = {
      date_format = "%d-%b-%Y";
      enabled = false;
    };
  };
  keymaps = [
    {
      mode = [ "n" ];
      key = "bt";
      action = "<CMD>GitBlameToggle<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Toggle Git blame";
      };
    }
  ];
}
