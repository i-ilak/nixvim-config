{ pkgs, lib, ... }:
{
  extraPackages = [ pkgs.hledger ];

  plugins.ledger = {
    enable = true;
    settings = {
      bin = lib.getExe pkgs.hledger;
      is_hledger = true;
      date_format = "%Y-%m-%d";
      align_at = 60;
      detailed_first = true;
      fold_blanks = 1;
      maxwidth = 80;
      accounts_cmd = "${lib.getExe pkgs.hledger} accounts";
      descriptions_cmd = "${lib.getExe pkgs.hledger} descriptions";
    };
  };

  # Detect .hledger files as ledger filetype
  # (.journal and .ledger are already handled by vim-ledger)
  files."ftdetect/hledger.lua".autoCmd = [
    {
      event = [
        "BufRead"
        "BufNewFile"
      ];
      pattern = [ "*.hledger" ];
      command = "set ft=ledger";
    }
  ];

  # Ledger filetype keymaps and auto-align on save
  autoCmd = [
    {
      event = [ "FileType" ];
      pattern = [ "ledger" ];
      callback = {
        __raw = ''
          function()
            local opts = { buffer = true, silent = true }
            vim.keymap.set('i', '<C-l>', '<C-x><C-o>', vim.tbl_extend('force', opts, { desc = "Complete account/description" }))
            vim.keymap.set('n', '<C-t>', '<cmd>call ledger#transaction_state_toggle(line("."), " *!")<CR>', vim.tbl_extend('force', opts, { desc = "Toggle transaction state" }))
            vim.keymap.set('n', '<C-a>', '<cmd>LedgerAlign<CR>', vim.tbl_extend('force', opts, { desc = "Align amounts" }))
            vim.keymap.set('v', '<C-a>', ':LedgerAlign<CR>', vim.tbl_extend('force', opts, { desc = "Align amounts" }))
          end
        '';
      };
    }
    {
      event = [ "BufWritePre" ];
      pattern = [
        "*.journal"
        "*.ledger"
        "*.hledger"
      ];
      command = "LedgerAlignBuffer";
    }
  ];
}
