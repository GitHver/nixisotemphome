{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkOption mkIf types;
  cfg = config.terminal.yazi;
in {

  options.terminal.yazi.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
    };
    home.file.".config/yazi" = {
      source = ./../../dotfiles/yazi;
      recursive = true;
    };
  };

}
