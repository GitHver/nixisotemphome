{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkOption mkIf types;
  name = "blur-my-shell";
  cfg = config.gnome.${name};
  extension = (with pkgs.gnomeExtensions; [ blur-my-shell ]);
in {

  options.gnome.${name}.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf cfg.enable {

    home.packages = extension;
    dconf.settings = {
      "org/gnome/shell".enabled-extensions = map(f: f.extensionUuid)extension;
      #==<< Blur my shell >>===================================================>
      "org/gnome/shell/extensions/blur-my-shell/panel" = {
        blur = true;
        static-blur = false;
        sigma = 0;
        brightness = 1.0;
        override-background = true;
        style-panel = 3;
      };
      "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
        blur = true;
        style-dialogs = 0;
      };
      "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
        static-blur = false;
        sigma = 0;
        brightness = 1.0;
      };
    };

  };
}
