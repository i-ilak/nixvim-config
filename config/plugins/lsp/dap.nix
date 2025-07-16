{ config
, lib
, pkgs
, ...
}:
let
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
    args = { };
    env = { };
    terminalKind = "integrated";
  };
in
{
  extraPackages = with pkgs;
    [
      coreutils
      lldb_19
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      pkgs.gdb
      pkgs.bashdb
    ];

  plugins = {
    dap = {
      enable = true;

      adapters = {
        executables = {
          bashdb = lib.mkIf pkgs.stdenv.isLinux { command = lib.getExe pkgs.bashdb; };

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
        };

        servers = {
          codelldb = {
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
        sh = lib.optionals pkgs.stdenv.isLinux [ sh-config ];
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

    dap-lldb = {
      enable = true;
      settings.codelldb_path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
    };

    dap-ui = {
      enable = true;
      settings = {
        layouts = [
          {
            elements = [
              {
                id = "breakpoints";
                size = 0.25;
              }
              {
                id = "stacks";
                size = 0.25;
              }
              {
                id = "watches";
                size = 0.25;
              }
            ];
            position = "left";
            size = 45;
          }
          {
            elements = [
              {
                id = "scopes";
                size = 1;
              }
            ];
            position = "bottom";
            size = 20;
          }
          {
            elements = [
              {
                id = "console";
                size = 1;
              }
            ];
            position = "right";
            size = 45;
          }
        ];
      };
    };

    dap-virtual-text = {
      enable = false;
    };

    which-key.settings.spec = lib.optionals
      config.plugins.dap-ui.enable
      [
        {
          __unkeyed = "<leader>d";
          mode = "n";
          desc = "Debug";
          # icon = " ";
        }
      ];
  };

  keymaps = lib.optionals
    config.plugins.dap-ui.enable
    [
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

