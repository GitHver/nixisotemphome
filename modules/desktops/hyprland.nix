{ pkgs, lib, config, ... }:

let
  inherit (lib) mkOption mkIf types;
  inherit (builtins) attrValues;
  cfg = config.hyprland;
in {

  options.hyprland.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf cfg.enable {

    home.packages = (with pkgs; [
      hyprls
      hyprpaper
      hyprpicker
      # hyprlock
      # hypridle
      hyprlang
      hyprkeys
      hyprutils
      hyprshade
      hyprcursor
      xdg-desktop-portal-hyprland
      #hyprland-workspaces
      #hyprland-activewindow
    ]) ++ (with pkgs.hyprlandPlugins; [
      #hycov
      #hyprwinwrap
      #hyprscroller
      #hyprspace
      #hyprexpo
    ]);

    wayland.windowManager.hyprland = {
      enable = true;
      # plugins = with pkgs.hyprlandPlugins; [
      #   hyprscroller
      # ];
    };

  };
}
