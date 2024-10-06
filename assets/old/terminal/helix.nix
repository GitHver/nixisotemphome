{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkOption mkIf types;
  cfg = config.terminal.helix;
in {

  options.terminal.helix.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
    };
    home.sessionVariables = {
      EDITOR = "hx";
    };
    home.file.".config/helix" = {
      source = ./../../dotfiles/helix;
      recursive = true;
    };
  };

}
