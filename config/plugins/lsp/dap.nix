_: {
  plugins.dap = {
    enable = true;
    adapters = {
      codelldb.enable = true;
    };
    configurations = {
      python = [
        {
          type = "python";
          request = "launch";
          name = "Launch file";
          program = "$\{file}";
        }
      ];
    };
  };
}
