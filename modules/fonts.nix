{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkOption;
  cfg = config.home.font;
in {

  options.home.font = {
    packages = mkOption {
      default = [];
    };
    nerdFonts = mkOption {
      default = [];
    };
  };

  config = {
    home.packages = cfg.packages
    ++ [
      (pkgs.nerdfonts.override { 
        fonts = cfg.nerdFonts;
      })
    ];
  };
}
