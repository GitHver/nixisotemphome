{pkgs, lib, config, ... }:

let
  inherit (lib) mkOption mkIf types;
  name = "defaults";
  cfg = config.gnome.${name};
in {

  options.gnome.${name}.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = let
    gnomeExtensionsList = with pkgs.gnomeExtensions; [
      vitals
      unblank
    ];
  in mkIf cfg.enable {

    # downloads all extensions and applications
    home.packages = gnomeExtensionsList;

    #====<< Icon Themes >>=====================================================>
    gtk.enable = true;
    gtk.iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    dconf.settings = {
      #==<< Activating all extensions >>=======================================>
      "org/gnome/shell".enabled-extensions =
        (map (extension: extension.extensionUuid) gnomeExtensionsList) ++ [
          # "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
          # "places-menu@gnome-shell-extensions.gcampax.github.com"
          # "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
          "apps-menu@gnome-shell-extensions.gcampax.github.com"
          "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
          # "user-theme@gnome-shell-extensions.gcampax.github.com"
          # "system-monitor@gnome-shell-extensions.gcampax.github.com"
        ];

      #==<< Common settings ===================================================>
      "org/gnome/desktop/interface" = {
        #==<< General >>=================>
        color-scheme = "prefer-dark" ;
        enable-hot-corners = false;
        clock-show-weekday = true;
        clock-show-date = true;
        #==<< Fonts >>===================>
        monospace-font-name = "FiraCode Nerd Font Mono Regular";
        font-antialiasing = "rgba";
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "appmenu:minimize,close";
      };

      "org/gnome/shell/keybindings" = {
        show-screenshot-ui = [ "<Shift><Super>s" ];
      };

    };

  };

}
