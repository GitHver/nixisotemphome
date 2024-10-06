{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkOption mkIf types;
  cfg = config.terminal.wezterm;
in {

  options.terminal.wezterm.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
    };
    home.file.".config/wezterm" = {
      source = ./../../dotfiles/wezterm;
      recursive = true;
    };
  };

}
