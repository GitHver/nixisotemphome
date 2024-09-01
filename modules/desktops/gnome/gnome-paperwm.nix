{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkOption mkIf types;
  name = "gnome-paperwm";
  cfg = config.${name};
  extension = (with pkgs.gnomeExtensions; [ paperwm ]);
in {

  options.${name}.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf cfg.enable {

    home.packages = extension;
    dconf.settings = {
      "org/gnome/shell".enabled-extensions = extension.extensionUuid;
      #==<< PaperWM settings >>================================================>
      "org/gnome/shell/extensions/paperwm" = {
        show-window-position-bar = false;
        window-gap = 5;
        selection-border-size = 0;
        selection-border-radius-top    = 12;
        selection-border-radius-bottom = 12;
        vertical-margin        = 5;
        vertical-margin-bottom = 5;
        horizontal-margin = 5;
      };
      "org/gnome/shell/extensions/paperwm/keybindings" = {
        #==<< Navigation >>===============>
        # Move between windows
        switch-left  = [ "<Super>h" "<Super>Left" ];
        switch-right = [ "<Super>l" "<Super>Right" ];
        switch-down  = [ "<Super>j" "<Super>Down" ];
        switch-up    = [ "<Super>k" "<Super>Up" ];
        # Rearange windows
        move-left    = [ "<Control><Super>h" "<Control><Super>Left" ];
        move-right   = [ "<Control><Super>l" "<Control><Super>Right" ];
        move-down    = [ "<Control><Super>j" "<Control><Super>Down" ];
        move-up      = [ "<Control><Super>k" "<Control><Super>Up" ];
        # Move between workspaces
        switch-down-workspace = [ "<Alt><Super>j" "<Alt><Super>Down" ];
        switch-up-workspace   = [ "<Alt><Super>k" "<Alt><Super>Up" ];
        # Move between monitors
        switch-monitor-left   = [ "<Alt><Super>h" "<Alt><Super>Left" ];
        switch-monitor-right  = [ "<Alt><Super>l" "<Alt><Super>Right" ];
        # disable swap workspaces
        swap-monitor-left  = [ "" ];
        swap-monitor-right = [ "" ];
        swap-monitor-below = [ "" ];
        swap-monitor-above = [ "" ];
        # Move window between monitors
        move-monitor-left =
          [ "<Control><Alt><Super>h" "<Control><Alt><Super>Left" ];
        move-monitor-right =
          [ "<Control><Alt><Super>l" "<Control><Alt><Super>Right" ];
        #==<< Resizing windows >>=========>
        cycle-width            = [ "<Shift><Super>l" "<Shift><Super>Right" ];
        cycle-width-backwards  = [ "<Shift><Super>h" "<Shift><Super>Left" ];
        cycle-height           = [ "<Shift><Super>k" "<Shift><Super>Up" ];
        cycle-height-backwards = [ "<Shift><Super>j" "<Shift><Super>Down" ];
        #==<< Actions >>==================>
        # Common rules
        new-window   = [ "<Super>c" ];
        close-window = [ "<Super>x" ];
        take-window  = [ "<Super>z" ];
        # Misc
        center-horizontally         = [ "<Super>b" ];
        switch-open-window-position = [ "<Super>w" ];
        switch-focus-mode           = [ "<Super>e" ];
      };
    };

  };
}
