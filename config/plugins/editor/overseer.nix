_: {
  plugins.overseer = {
    enable = true;
    settings = {
      task_list = {
        direction = "bottom";
        min_height = 15;
        max_height.__raw = "math.floor(vim.o.lines * 0.3)";
        default_detail = 2;
      };
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>Or";
      action = "<cmd>OverseerRun<CR>";
      options = {
        desc = "Overseer Run";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>Ot";
      action = "<cmd>OverseerToggle<CR>";
      options = {
        desc = "Overseer Toggle";
        silent = true;
      };
    }
  ];
}
