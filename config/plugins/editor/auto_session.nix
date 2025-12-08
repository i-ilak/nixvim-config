_: {
  plugins.auto-session = {
    enable = true;
    settings = {
      auto_save = true;
      auto_restore = true;
      auto_create = true;
      allowed_dirs = [ "~/prg" ];

      session_lens = {
        load_on_setup = true;
        picker = "telescope";
        picker_opts = null;
      };
    };
  };
  opts.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions";
}
