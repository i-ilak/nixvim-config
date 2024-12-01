{
  globals.mapleader = "\\";

  keymaps = [
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options = {
        desc = "Go to Left Window";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
      options = {
        desc = "Go to Lower Window";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
      options = {
        desc = "Go to Upper Window";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options = {
        desc = "Go to Right Window";
        remap = true;
      };
    }
    {
      mode = [ "i" "x" "n" "s" ];
      key = "<C-s>";
      action = "<cmd>w<cr><esc>";
      options = { desc = "Save File"; };
    }
    {
      mode = "n";
      key = "<leader>`";
      action = "vim.diagnostic.open_float";
      options = { desc = "Line Diagnostics"; };
    }
    {
      mode = "n";
      key = "]d";
      action = "diagnostic_goto(true)";
      options = { desc = "Next Diagnostic"; };
    }
    {
      mode = "n";
      key = "[d";
      action = "diagnostic_goto(false)";
      options = { desc = "Prev Diagnostic"; };
    }
    {
      mode = "n";
      key = "]e";
      action = "diagnostic_goto(true 'ERROR')";
      options = { desc = "Next Error"; };
    }
    {
      mode = "n";
      key = "[e";
      action = "diagnostic_goto(false 'ERROR')";
      options = { desc = "Prev Error"; };
    }
    {
      mode = "n";
      key = "]w";
      action = "diagnostic_goto(true 'WARN')";
      options = { desc = "Next Warning"; };
    }
    {
      mode = "n";
      key = "[w";
      action = "diagnostic_goto(false 'WARN')";
      options = { desc = "Prev Warning"; };
    }
    {
      mode = "t";
      key = "<C-h>";
      action = "<cmd>wincmd h<cr>";
      options = { desc = "Go to Left Window"; };
    }
    {
      mode = "t";
      key = "<C-j>";
      action = "<cmd>wincmd j<cr>";
      options = { desc = "Go to Lower Window"; };
    }
    {
      mode = "t";
      key = "<C-k>";
      action = "<cmd>wincmd k<cr>";
      options = { desc = "Go to Upper Window"; };
    }
    {
      mode = "t";
      key = "<C-l>";
      action = "<cmd>wincmd l<cr>";
      options = { desc = "Go to Right Window"; };
    }
    {
      mode = "t";
      key = "<C-/>";
      action = "<cmd>close<cr>";
      options = { desc = "Hide Terminal"; };
    }
    {
      mode = "n";
      key = "<leader>ww";
      action = "<C-W>p";
      options = {
        desc = "Other Window";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<leader>wd";
      action = "<C-W>c";
      options = {
        desc = "Delete Window";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<leader>w-";
      action = "<C-W>s";
      options = {
        desc = "Split Window Below";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<leader>wr";
      action = "<C-W>v";
      options = {
        desc = "Split Window Right";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<leader>wb";
      action = "<C-W>s";
      options = {
        desc = "Split Window Below";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<leader>|";
      action = "<C-W>v";
      options = {
        desc = "Split Window Right";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "ä";
      action = "za";
      options = { desc = "Fold/Unfold at current line"; };
    }
    {
      mode = "n";
      key = "Ä";
      action = "zR";
      options = { desc = "Fold/Unfold file"; };
    }

    # General movements
    {
      mode = [ "" ];
      key = "Y";
      action = "y$";
      options = {
        silent = true;
        noremap = true;
        desc = "Yank to the end of the line";
      };
    }
    {
      mode = [ "" ];
      key = "ä";
      action = "za";
      options = {
        silent = true;
        noremap = true;
        desc = "Toggle fold under cursor";
      };
    }
    {
      mode = [ "" ];
      key = "Ä";
      action = "zR";
      options = {
        silent = true;
        noremap = true;
        desc = "Open all folds";
      };
    }

    # Delete/change up to next )
    {
      mode = [ "n" ];
      key = "d)";
      action = "d])";
      options = {
        silent = true;
        noremap = true;
        desc = "Delete up to next parenthesis";
      };
    }
    {
      mode = [ "n" ];
      key = "c)";
      action = "c])";
      options = {
        silent = true;
        noremap = true;
        desc = "Change up to next parenthesis";
      };
    }

    # Visual Mode Keymaps (Move lines, Indent)
    {
      mode = [ "v" ];
      key = "J";
      action = ":m '>+1<CR>gv=gv";
      options = {
        silent = true;
        noremap = true;
        desc = "Move selected line down";
      };
    }
    {
      mode = [ "v" ];
      key = "K";
      action = ":m '<-2<CR>gv=gv";
      options = {
        silent = true;
        noremap = true;
        desc = "Move selected line up";
      };
    }
    {
      mode = [ "v" ];
      key = "<";
      action = "<gv";
      options = {
        silent = true;
        noremap = true;
        desc = "Indent selected line left";
      };
    }
    {
      mode = [ "v" ];
      key = ">";
      action = ">gv";
      options = {
        silent = true;
        noremap = true;
        desc = "Indent selected line right";
      };
    }

    # Spell checking
    {
      mode = [ "n" ];
      key = "ns";
      action = "]s";
      options = {
        silent = true;
        noremap = true;
        desc = "Jump to next spelling error";
      };
    }
    {
      mode = [ "n" ];
      key = "ps";
      action = "[s";
      options = {
        silent = true;
        noremap = true;
        desc = "Jump to previous spelling error";
      };
    }

    # Save and quit
    {
      mode = [ "n" ];
      key = "s";
      action = ":w<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Save current file";
      };
    }
    {
      mode = [ "n" ];
      key = "Q";
      action = ":qa<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Quit all windows";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>x";
      action = ":bd<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Close buffer";
      };
    }

    # Telescope
    {
      mode = [ "n" ];
      key = "<leader>fg";
      action = ":Telescope live_grep<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Live search in files";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>ff";
      action = ":Telescope find_files<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Find files";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>fb";
      action = ":Telescope buffers<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "List buffers";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>fh";
      action = ":Telescope help_tags<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Search help tags";
      };
    }

    # Leap
    {
      mode = [ "n" ];
      key = "f";
      action = "<Plug>(leap-forward)";
      options = {
        silent = true;
        noremap = true;
        desc = "Leap forward";
      };
    }
    {
      mode = [ "n" ];
      key = "F";
      action = "<Plug>(leap-backward)";
      options = {
        silent = true;
        noremap = true;
        desc = "Leap backward";
      };
    }

    # Comment
    {
      mode = [ "n" ];
      key = "<leader>c";
      action = "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Toggle comment for current line";
      };
    }
    {
      mode = [ "v" ];
      key = "<leader>c";
      action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Toggle comment for selected lines";
      };
    }

    # Diagnostic
    {
      mode = [ "n" ];
      key = "ko";
      action = ":ClangdSwitchSourceHeader<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Switch between source and header file";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>`";
      action = ":lua vim.diagnostic.open_float()<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Open diagnostic in floating window";
      };
    }

    # BlameToggle
    {
      mode = [ "n" ];
      key = "bt";
      action = ":BlameToggle<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Toggle Git blame";
      };
    }

    # Trailblazer
    {
      mode = [ "n" ];
      key = "m";
      action = ":lua require('plugins.trailblazer').new_mark()<CR>";
      options = {
        silent = true;
        noremap = true;
        desc = "Create new mark";
      };
    }
  ];
}
