{
  config,
  lib,
  pkgs,
  ...
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
    file = "\${file}";
    program = "\${file}";
    cwd = "\${workspaceFolder}";
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
  extraPackages =
    with pkgs;
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

          cppdbg = lib.mkIf pkgs.stdenv.isLinux {
            command = "gdb";
            args = [
              "-i"
              "dap"
            ];
          };

          gdb = lib.mkIf pkgs.stdenv.isLinux {
            command = "gdb";
            args = [
              "-i"
              "dap"
            ];
          };

          lldb = {
            # On macOS, use Apple's lldb-dap which knows where debugserver is.
            # On Linux, use the nix-provided lldb_19.
            command =
              if pkgs.stdenv.isDarwin then
                "/Library/Developer/CommandLineTools/usr/bin/lldb-dap"
              else
                lib.getExe' pkgs.lldb_19 "lldb-dap";
          };
        };

        # FIXME: Something is wrong with the node version here...
        # servers = {
        #   codelldb = {
        #     port = 13000;
        #     executable = {
        #       command = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
        #       args = [
        #         "--port"
        #         "13000"
        #       ];
        #     };
        #   };
        # };
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

    # FIXME: Again node version is off..
    # dap-lldb = {
    #   enable = true;
    #   settings.codelldb_path = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
    # };

    dap-ui = {
      enable = true;
      lazyLoad = {
        # enable = true;
        # settings = {
        #   # We need to access nvim-dap in the after function.
        #   before.__raw = ''
        #     function()
        #       require('dap.ext.vscode').load_launchjs(nil, {})
        #       require('lz.n').trigger_load('nvim-dap')
        #     end
        #   '';
        #   keys = [
        #     {
        #       __unkeyed-1 = "<leader>d";
        #       __unkeyed-2.__raw = ''
        #         function()
        #           require("dap-ui").toggle({ reset = true; })
        #         end
        #       '';
        #       desc = "Toggle Debugger UI";
        #     }
        #   ];
        # };
      };
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
                id = "repl";
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

    which-key.settings.spec = lib.optionals config.plugins.dap-ui.enable [
      {
        __unkeyed = "<leader>d";
        mode = "n";
        desc = "Debug";
        # icon = " ";
      }
    ];
  };

  keymaps = lib.optionals config.plugins.dap-ui.enable [
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
      # Dont forget to change it for the lazy loading as well!
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
          local dap = require("dap")

          -- If already in a debug session, just continue
          if dap.session() then
            dap.continue()
            return
          end

          -- Load .vscode/launch.json via load_launchjs
          -- nvim-dap's expand_config_variables handles ''${workspaceFolder}
          local cwd = vim.fn.getcwd()
          local launch_json_path = cwd .. "/.vscode/launch.json"
          if vim.fn.filereadable(launch_json_path) == 1 then
            dap.configurations.c = {}
            dap.configurations.cpp = {}
            dap.configurations.rust = {}

            local ok, vscode = pcall(require, "dap.ext.vscode")
            if ok then
              vscode.load_launchjs(launch_json_path, {
                lldb = { "c", "cpp", "rust" },
                cppdbg = { "c", "cpp" },
                gdb = { "c", "cpp" },
              })
            end

            local ft = vim.bo.filetype
            local configs = dap.configurations[ft] or {}

            if #configs == 1 then
              dap.run(configs[1])
              return
            elseif #configs > 1 then
              vim.ui.select(configs, {
                prompt = "Select debug configuration:",
                format_item = function(c) return c.name end,
              }, function(selected)
                if selected then
                  dap.run(selected)
                end
              end)
              return
            end
          end

          -- No launch.json or no matching configs: fall back to dap.continue()
          dap.continue()
        end
      '';
      options = {
        desc = "Debug: Start / Continue";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<F29>"; # Ctrl+F5
      action = "<cmd>OverseerRun<CR>";
      options = {
        desc = "Run without debugger";
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
