{pkgs, lib, config, inputs, ... }:

let
  inherit (lib) mkOption mkIf types;
  cfg = config.niri;
in {

  imports = [ inputs.niri.homeModules.niri ];

  options.niri.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      waybar
      wbg
      fuzzel
      pavucontrol
    ];
    programs.niri.enable = true;
    programs.niri.settings = {
      spawn-at-startup = [
        {command = ["alacritty"];}
        {command = ["waybar"];}
        {command = ["wbg" "/home/your-username/.config/home-manager/assets/astronaut-gruvbox.jpg"];}
      ];
      input = {
        keyboard.xkb = {
          layout  = "is";
          model   = "";
          variant = "";
          options = "caps:escape";
          rules   = "";
        };
      };
      # outputs = {
      #   "eDP-1" = {
          
      #   };
      # };
      cursor = {
        size = 30;
        theme = "default";
      };
      # layout.border = {
        
      # };
      # layout.focus-ring = {
        
      # };
      # layout = {
        
      # };
      # animations = {
        
      # };
      # window-rules = {
        
      # };
      binds = with config.lib.niri.actions; {
        # Audio
        "XF86AudioRaiseVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" ];
        "XF86AudioLowerVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-" ];
        "XF86AudioMute".action.spawn        = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
        "XF86AudioMicMute".action.spawn     = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
        # Brightness
        "XF86MonBrightnessUp".action.spawn   = [ "sh" "-c" "brightnessctl set 10%+" ];
        "XF86MonBrightnessDown".action.spawn = [ "sh" "-c" "brightnessctl set 10%-" ];
        # Programs
        "Mod+D".action.spawn = "fuzzel";
        "Mod+T".action.spawn = "alacritty";
        # Window navigation
        "Mod+H".action = focus-column-left-or-last;
        "Mod+J".action = focus-window-or-workspace-down;
        "Mod+K".action = focus-window-or-workspace-up;
        "Mod+L".action = focus-column-right-or-first;
        # Window moving
        "Mod+Ctrl+H".action = move-column-left;
        "Mod+Ctrl+J".action = move-window-down-or-to-workspace-down;
        "Mod+Ctrl+K".action = move-window-up-or-to-workspace-up;
        "Mod+Ctrl+L".action = move-column-right;
        # Column forming
        "Mod+Y".action = consume-or-expel-window-left;
        "Mod+O".action = consume-or-expel-window-right;
        # Window resizing
        "Mod+U".action = switch-preset-column-width;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        # "Mod+Shift+H".action = 
        # "Mod+Shift+J".action =
        # "Mod+Shift+K".action =
        # "Mod+Shift+L".action =
        # Other
        "Mod+Shift+E".action.quit.skip-confirmation = true;
        "Mod+Q".action = close-window;
      };
    };
  };
}
