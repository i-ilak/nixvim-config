{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  plugins = {
    lsp-format = {
      enable = true;
    };
    helm = {
      enable = true;
    };
    lsp = {
      enable = true;
      inlayHints = false;
      servers = {
        html = {
          enable = true;
        };
        lua_ls = {
          enable = true;
        };
        nixd = {
          enable = true;
          package = pkgs-unstable.nixd;
          settings = {
            nixpkgs.expr = "import <nixpkgs> { }";
          };
        };
        marksman = {
          enable = true;
        };
        pyright = {
          enable = true;
        };
        clangd = {
          enable = true;
          package = pkgs.llvmPackages_18.clang-tools;
          cmd = [
            "clangd"
            "--offset-encoding=utf-16"
            "--background-index"
            "-j"
            "20"
            "--clang-tidy"
          ];
        };
        cmake = {
          enable = true;
        };
        jsonls = {
          enable = true;
        };
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        yamlls = {
          enable = true;
          extraOptions = {
            settings = {
              yaml = {
                schemas = {
                  kubernetes = "'*.yaml";
                  "http://json.schemastore.org/github-workflow" = ".github/workflows/*";
                  "http://json.schemastore.org/github-action" = ".github/action.{yml,yaml}";
                  "http://json.schemastore.org/kustomization" = "kustomization.{yml,yaml}";
                  "http://json.schemastore.org/chart" = "Chart.{yml,yaml}";
                  "https://json.schemastore.org/dependabot-v2" = ".github/dependabot.{yml,yaml}";
                  "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" =
                    "*docker-compose*.{yml,yaml}";
                  "https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json" =
                    "*flow*.{yml,yaml}";
                };
              };
            };
          };
        };
      };

      keymaps = {
        silent = true;
        lspBuf = {
          "<leader>gd" = {
            action = "definition";
            desc = "Goto Definition";
          };
          "<leader>gD" = {
            action = "declaration";
            desc = "Goto Declaration";
          };
          "<leader>gi" = {
            action = "implementation";
            desc = "Goto Implementation";
          };
          "<leader>gT" = {
            action = "type_definition";
            desc = "Type Definition";
          };
          K = {
            action = "hover";
            desc = "Hover";
          };
          "<leader>cw" = {
            action = "workspace_symbol";
            desc = "Workspace Symbol";
          };
          "<leader>rr" = {
            action = "rename";
            desc = "Rename";
          };
        };
        # [d, ]d, diagnostics come from shared vim keybindings
      };
    };
  };
  extraPlugins = with pkgs.vimPlugins; [
  ];

  extraConfigLua = ''
    local _border = "rounded"

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = _border
      }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, {
        border = _border
      }
    )

    vim.diagnostic.config{
      float={border=_border}
    };

    require('lspconfig.ui.windows').default_options = {
      border = _border
    }

    function my_references()
      require("telescope.builtin").lsp_references {
        layout_strategy = "horizontal",
        layout_config = {
          width = 0.8,
          height = 0.9,
          prompt_position = "bottom",
        },
        sorting_strategy = "descending",
        ignore_filename = false,
      }
    end

    vim.keymap.set("n", "<leader>gr", function() my_references() end, opts) -- Find references/usage
  '';
}
