{
  lib,
  pkgs,
  ...
}:
{
  config = {
    plugins.conform-nvim = {
      enable = true;
      settings = {
        format_on_save =
          # Lua
          ''
            function(bufnr)
              -- Disable with a global or buffer-local variable
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end
              return { timeout_ms = 500, lsp_format = 'fallback' }
            end
          '';
        notify_on_error = true;
        formatters_by_ft = {
          html = [
            "prettierd"
            "prettier"
          ];
          css = [
            "prettierd"
            "prettier"
          ];
          javascript = [
            "prettierd"
            "prettier"
          ];
          typescript = [
            "prettierd"
            "prettier"
          ];
          c = [
            "clang_format"
          ];
          cpp = [
            "clang_format"
          ];
          rust = [
            "rustfmt"
          ];
          cmake = [
            "cmake_format"
          ];
          python = [
            "black"
          ];
          lua = [ "stylua" ];
          nix = [ "nixfmt" ];
          markdown = [
            "prettierd"
            "prettier"
          ];
          yaml = [
            "prettierd"
            "prettier"
          ];
          terraform = [ "terraform_fmt" ];
          bicep = [ "bicep" ];
          bash = [
            "shellcheck"
            "shellharden"
            "shfmt"
          ];
          json = [ "jq" ];
          "_" = [ "trim_whitespace" ];
        };

        formatters = {
          black = {
            command = "${lib.getExe pkgs.black}";
          };
          isort = {
            command = "${lib.getExe pkgs.isort}";
          };
          alejandra = {
            command = "${lib.getExe pkgs.alejandra}";
          };
          nixfmt = {
            command = "${lib.getExe pkgs.nixfmt-rfc-style}";
          };
          jq = {
            command = "${lib.getExe pkgs.jq}";
          };
          prettierd = {
            command = "${lib.getExe pkgs.prettierd}";
          };
          stylua = {
            command = "${lib.getExe pkgs.stylua}";
          };
          shellcheck = {
            command = "${lib.getExe pkgs.shellcheck}";
          };
          shfmt = {
            command = "${lib.getExe pkgs.shfmt}";
          };
          shellharden = {
            command = "${lib.getExe pkgs.shellharden}";
          };
          bicep = {
            command = "${lib.getExe pkgs.bicep}";
          };
          #yamlfmt = {
          #  command = "${lib.getExe pkgs.yamlfmt}";
          #};
        };
        keymaps = [
          {
            mode = "n";
            key = "<leader>uf";
            action = ":FormatToggle<CR>";
            options = {
              desc = "Toggle Format Globally";
              silent = true;
            };
          }
          {
            mode = "n";
            key = "<leader>uF";
            action = ":FormatToggle!<CR>";
            options = {
              desc = "Toggle Format Locally";
              silent = true;
            };
          }
          {
            mode = "n";
            key = "<leader>cf";
            action = "<cmd>lua require('conform').format()<cr>";
            options = {
              silent = true;
              desc = "Format Buffer";
            };
          }
          {
            mode = "v";
            key = "<leader>cF";
            action = "<cmd>lua require('conform').format()<cr>";
            options = {
              silent = true;
              desc = "Format Lines";
            };
          }
        ];
      };
    };
  };
}
