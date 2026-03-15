{ config, lib, ... }:
{
  plugins = {
    cmake-tools = {
      enable = true;
      lazyLoad = {
        enable = true;
        settings = {
          cmd = [
            "CMake"
            "CMakeGenerate"
            "CMakeBuild"
            "CMakeBuildCurrentFile"
            "CMakeRun"
            "CMakeDebug"
            "CMakeSelectConfigurePreset"
            "CMakeSelectBuildPreset"
            "CMakeSelectBuildTarget"
            "CMakeSelectBuildType"
            "CMakeSelectLaunchTarget"
          ];
        };
      };
      settings = {
        cmake_soft_link_compile_commands = true;
        cmake_use_preset = true;
        cmake_generate_options = {
          "-DCMAKE_EXPORT_COMPILE_COMMANDS" = 1;
        };
        cmake_dap_configuration = {
          name = "cpp";
          type = "lldb";
          request = "launch";
          runInTerminal = false;
          console = "internalConsole";
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
              on_new_task.__raw = ''
                function(task)
                  require("overseer").open({ enter = false, direction = "bottom" })
                end
              '';
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

    which-key.settings.spec = lib.optionals config.plugins.cmake-tools.enable [
      {
        __unkeyed = "<leader>C";
        mode = "n";
        desc = "CMake";
      }
    ];
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
      action.__raw = ''
        function()
          -- Selecting a build preset auto-updates the associated configure
          -- preset and the default callback auto-generates.
          require("lz.n").trigger_load("cmake-tools.nvim")
          vim.cmd("CMakeSelectBuildPreset")
        end
      '';
      options = {
        silent = true;
        desc = "CMake select presets + generate";
      };
    }
    {
      mode = "n";
      key = "<F18>"; # Shift+F6
      action = "<cmd>CMakeSelectBuildTarget<CR>";
      options = {
        silent = true;
        desc = "CMake select build target";
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
    {
      mode = "n";
      key = "<leader>Ct";
      action = "<cmd>CMakeSelectBuildType<CR>";
      options = {
        silent = true;
        desc = "Select build type";
      };
    }
    {
      mode = "n";
      key = "<leader>Cl";
      action = "<cmd>CMakeSelectLaunchTarget<CR>";
      options = {
        silent = true;
        desc = "Select launch target";
      };
    }
    {
      mode = "n";
      key = "<leader>Cg";
      action = "<cmd>CMakeGenerate<CR>";
      options = {
        silent = true;
        desc = "CMake generate";
      };
    }
  ];
}
