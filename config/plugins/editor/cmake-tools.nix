_: {
  plugins.cmake-tools = {
    enable = true;
    lazyLoad = {
      enable = true;
      settings = {
        cmd = [
          "CMake"
          "CMakeGenerate"
          "CMakeBuild"
          "CMakeBuildCurrentFile"
        ];
      };
    };
    settings = {
      cmake_soft_link_compile_commands = true;
      cmake_use_preset = true;
      cmake_generate_options = {
        "-DCMAKE_EXPORT_COMPILE_COMMANDS" = 1;
      };
      cmake_executor = {
        name = "overseer";
        default_opts = {
          overseer = {
            new_task_opts = {
              strategy = {
                __unkeyed-1 = "jobstart";
                direction = "horizontal";
                auto_scroll = true;
                quit_on_exit = "success";
              };
            };
            on_new_task.__raw = ''
              function(task)
                require("overseer").open({ enter = false, direction = "bottom" })
              end
            '';
          };
        };
      };
      cmake_runner = {
        name = "overseer";
        default_opts = {
          overseer = {
            new_task_opts = {
              strategy = {
                __unkeyed-1 = "jobstart";
                direction = "horizontal";
                auto_scroll = true;
                quit_on_exit = "success";
              };
            };
          };
        };
      };
      cmake_notifications = {
        runner = {
          enabled = true;
        };
        executor = {
          enabled = true;
        };
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
      key = "<F31>"; # Somehow is mapped to by pressing Ctrl + F7, <C-F7> does not work
      action = "<cmd>CMakeBuildCurrentFile<CR>";
      options = {
        silent = true;
        desc = "CMake build current file";
      };
    }
  ];
}
