_: {
  plugins.nvim-ufo = {
    enable = true;
    settings = {
      fold_virt_text_handler =
        # lua
        ''
          function(virtText, lnum, endLnum, width, truncate)
            local alignLimitByTextWidth = true -- limit the alignment of the fold text by:
            -- true: the textwidth value, false: the width of the current window
            local alignLimiter = alignLimitByTextWidth and vim.opt.textwidth["_value"]
              or vim.api.nvim_win_get_width(0)
            local newVirtText = {}
            local totalLines = vim.api.nvim_buf_line_count(0)
            local foldedLines = endLnum - lnum
            local suffix = (" 󰁂 %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
              local chunkText = chunk[1]
              local chunkWidth = vim.fn.strdisplaywidth(chunkText)
              if targetWidth > curWidth + chunkWidth then
                table.insert(newVirtText, chunk)
              else
                chunkText = truncate(chunkText, targetWidth - curWidth)
                local hlGroup = chunk[2]
                table.insert(newVirtText, { chunkText, hlGroup })
                chunkWidth = vim.fn.strdisplaywidth(chunkText)
                -- str width returned from truncate() may less than 2nd argument, need padding
                if curWidth + chunkWidth < targetWidth then
                  suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
                end
                break
              end
              curWidth = curWidth + chunkWidth
            end
            local rAlignAppndx = math.max(math.min(alignLimiter, width - 1) - curWidth - sufWidth, 0)
            suffix = (" "):rep(rAlignAppndx) .. suffix
            table.insert(newVirtText, { suffix, "MoreMsg" })
            return newVirtText
          end
        '';
      provider_selector =
        #lua
        ''
          function (bufnr, filetype, buftype)
              return {'treesitter', 'indent'}
          end
        '';
    };
  };
}
