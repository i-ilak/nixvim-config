{ pkgs
, ...
}:
let
  # trailblazer = pkgs.vimUtils.buildVimPlugin
  #   {
  #     name = "trailblazer";
  #     src = pkgs.fetchFromGitHub {
  #       owner = "LeonHeidelbach";
  #       repo = "trailblazer.nvim";
  #       rev = "5c0e3ac01e227bb9afe428583f29f0ec34801408";
  #       hash = "0000000000000000000000000000000000000000";
  #     };
  #   };
in
{
  extraPlugins = with pkgs.vimPlugins;
    [
      jinja-vim
      # trailblazer
    ];
  extraConfigLua = ''
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
    
        -- Check if the autocmd has already been loaded for this buffer
        if not vim.b[buf].jinja_syntax_autocmd_loaded then
          -- Check if the jinja treesitter parser is available
          if vim.treesitter.language.get_lang('jinja') == nil then
            -- If filetype is not empty, set syntax on
            if vim.bo.filetype and vim.bo.filetype ~= "" then
              vim.bo.syntax = "on"
            end
          end
      
          -- Mark as loaded for this buffer
          vim.b[buf].jinja_syntax_autocmd_loaded = true
        end
      end,
      buffer = 0, -- Apply to current buffer
    })
  '';
}
