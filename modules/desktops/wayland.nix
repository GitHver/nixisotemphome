{ pkgs, lib, config, ... }:

let
  cfg = config.wayland-core;
in with lib; {

  options.wayland-core.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      # wl-clipboard
      # wayland-utils
      # cage

      waybar
      fuzzel
      pavucontrol
    ];

  };
}
