_: {
  plugins.cmake-tools = {
    enable = true;
    settings = {
      cmake_soft_link_compile_commands = true;
      cmake_use_preset = true;
      cmake_generate_options = {
        "-DCMAKE_EXPORT_COMPILE_COMMANDS" = 1;
      };
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<F7>";
      action = "<cmd>CMakeBuild<CR>";
      options = {
        silent = true;
        desc = "CMake build target";
      };
    }
    {
      mode = "n";
      key = "<F6>";
      action = "<cmd>CMakeGenerate<CR>";
      options = {
        silent = true;
        desc = "CMake generate";
      };
    }
    {
      mode = "n";
      key = "<F19>"; # Somehow is mapped to by pressing Shift + F7
      action = "<cmd>CMakeBuildCurrentFile<CR>";
      options = {
        silent = true;
        desc = "CMake build current file";
      };
    }
  ];
}
