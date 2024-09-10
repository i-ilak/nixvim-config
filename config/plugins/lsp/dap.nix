{
  config,
  lib,
  pkgs,
  ...
}: let
  codelldb-config = {
    name = "Launch (CodeLLDB)";
    type = "codelldb";
    request = "launch";
    program.__raw = ''
      function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', "file")
      end
    '';
    cwd = ''''${workspaceFolder}'';
    stopOnEntry = false;
  };

  gdb-config = {
    name = "Launch (GDB)";
    type = "gdb";
    request = "launch";
    program.__raw = ''
      function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', "file")
      end'';
    cwd = ''''${workspaceFolder}'';
    stopOnEntry = false;
  };

  lldb-config = {
    name = "Launch (LLDB)";
    type = "lldb";
    request = "launch";
    program.__raw = ''
      function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', "file")
      end'';
    cwd = ''''${workspaceFolder}'';
    stopOnEntry = false;
  };

  sh-config = lib.mkIf pkgs.stdenv.isLinux {
    type = "bashdb";
    request = "launch";
    name = "Launch (BashDB)";
    showDebugOutput = true;
    pathBashdb = "${lib.getExe pkgs.bashdb}";
    pathBashdbLib = "${pkgs.bashdb}/share/basdhb/lib/";
    trace = true;
    file = ''''${file}'';
    program = ''''${file}'';
    cwd = ''''${workspaceFolder}'';
    pathCat = "cat";
    pathBash = "${lib.getExe pkgs.bash}";
    pathMkfifo = "mkfifo";
    pathPkill = "pkill";
    args = {};
    env = {};
    terminalKind = "integrated";
  };
in {
  extraPackages = with pkgs;
    [
      coreutils
      lldb
      netcoredbg
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      pkgs.gdb
      pkgs.bashdb
    ];

  #   extraPlugins = with pkgs.vimPlugins; [ nvim-gdb ];

  plugins = {
    dap = {
      enable = true;

      adapters = {
        executables = {
          bashdb = lib.mkIf pkgs.stdenv.isLinux {command = lib.getExe pkgs.bashdb;};

          cppdbg = {
            command = "gdb";
            args = [
              "-i"
              "dap"
            ];
          };

          gdb = {
            command = "gdb";
            args = [
              "-i"
              "dap"
            ];
          };

          lldb = {
            command = lib.getExe' pkgs.lldb "lldb-dap";
          };

          coreclr = {
            command = lib.getExe pkgs.netcoredbg;
            args = ["--interpreter=vscode"];
          };

          netcoredbg = {
            command = lib.getExe pkgs.netcoredbg;
            args = ["--interpreter=vscode"];
          };
        };

        servers = {
          codelldb = lib.mkIf pkgs.stdenv.isLinux {
            port = 13000;
            executable = {
              command = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
              args = [
                "--port"
                "13000"
              ];
            };
          };
        };
      };

      configurations = {
        c = [lldb-config] ++ lib.optionals pkgs.stdenv.isLinux [gdb-config];

        cpp =
          [lldb-config]
          ++ lib.optionals pkgs.stdenv.isLinux [
            gdb-config
            codelldb-config
          ];

        rust =
          [lldb-config]
          ++ lib.optionals pkgs.stdenv.isLinux [
            gdb-config
            codelldb-config
          ];

        sh = lib.optionals pkgs.stdenv.isLinux [sh-config];
      };

      extensions = {
        dap-ui = {
          enable = true;
        };

        dap-virtual-text = {
          enable = true;
        };
      };

      signs = {
        dapBreakpoint = {
          text = "";
          texthl = "DapBreakpoint";
        };
        dapBreakpointCondition = {
          text = "";
          texthl = "dapBreakpointCondition";
        };
        dapBreakpointRejected = {
          text = "";
          texthl = "DapBreakpointRejected";
        };
        dapLogPoint = {
          text = "";
          texthl = "DapLogPoint";
        };
        dapStopped = {
          text = "";
          texthl = "DapStopped";
        };
      };
    };

    which-key.settings.spec = lib.optionals config.plugins.dap.extensions.dap-ui.enable [
      {
        __unkeyed = "<leader>d";
        mode = "n";
        desc = "Debug";
        # icon = " ";
      }
    ];
  };

  keymaps = lib.optionals config.plugins.dap.extensions.dap-ui.enable [
    {
      mode = "v";
      key = "<leader>e";
      action.__raw = ''
        function() require("dapui").eval() end
      '';
      options = {
        desc = "Evaluate Input";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>dh";
      action.__raw = ''
        function() require("dap.ui.widgets").hover() end
      '';
      options = {
        desc = "Debugger Hover";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>d";
      action.__raw = ''
        function()
          require("dapui").toggle( { reset = true; } )
        end
      '';
      options = {
        desc = "Toggle Debugger UI";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<F5>";
      action.__raw = ''
        function()
            local launch_json_path = vim.fn.getcwd() .. "/.vscode/launch.json"

            if vim.fn.filereadable(launch_json_path) == 1 then
                require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp" } })
            end
            require("dap").continue()
        end
      '';
      options = {
        desc = "Continue Debugging (Start)";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<F9>";
      action.__raw = ''
        function()
          require("dap").toggle_breakpoint()
        end
      '';
      options = {
        desc = "Breakpoint toggle";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<F10>";
      action.__raw = ''
        function()
          require("dap").step_over()
        end
      '';
      options = {
        desc = "Step Over";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<F11>";
      action.__raw = ''
        function()
          require("dap").step_into()
        end
      '';
      options = {
        desc = "Step Into";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<F12>";
      action.__raw = ''
        function()
          require("dap").step_out()
        end
      '';
      options = {
        desc = "Step Out";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>q";
      action.__raw = ''
        function() require("dap").terminate() end
      '';
      options = {
        desc = "Terminate Debugging";
        silent = true;
      };
    }
  ];
}
