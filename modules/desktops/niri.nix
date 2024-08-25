{pkgs, lib, config, inputs, ... }:

let
  inherit (lib) mkOption mkIf types;
  cfg = config.niri;
in {

  imports = [ inputs.niri.homeModules.niri ];

  options.gnome-dconf.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf cfg.enable {
    programs.niri.enable = true;
    
    programs.niri.settings.binds = {
      "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"];
      "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
    };
  };
}
