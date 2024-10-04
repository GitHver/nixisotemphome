{ pkgs
, lib
, config
, patt
, ...
}:

let
  inherit (patt) username;
  inherit (lib) mkOption mkIf types;
  cfg = config.terminal.starship;
in {

  options.terminal.starship.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };
    home.sessionVariables = {
      STARSHIP_CONFIG = "/home/${username}/.config/starship/starship.toml";
    };
    home.file.".config/starship" = {
      source = ./../../dotfiles/starship;
      recursive = true;
    };
  };

}
