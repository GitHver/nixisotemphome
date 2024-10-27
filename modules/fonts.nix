{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkOption;
  cfg = config.fonts;
in {

  options.fonts = {
    packages = mkOption {
      default = [];
    };
    nerdfonts = mkOption {
      default = [];
    };
  };

  config.home.packages =
    cfg.packages
    ++ [
      (pkgs.nerdfonts.override { 
        fonts = cfg.nerdfonts;
      })
    ]
  ;
}
