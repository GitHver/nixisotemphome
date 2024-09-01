{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkOption mkIf types;
  name = "dash-to-dock";
  cfg = config.gnome.${name};
  extension = (with pkgs.gnomeExtensions; [ dash-to-dock ]);
in {

  options.gnome.${name}.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf cfg.enable {

    home.packages = extension;
    dconf.settings = {
      "org/gnome/shell".enabled-extensions = map(f: f.extensionUuid)extension;
      #==<< Dash to Dock >>====================================================>
      "org/gnome/shell/extensions/dash-to-dock" = {
        #==<< Transparency >>==========>
        transparency-mode = "FIXED";
        background-opacity = 0.0;
        #==<< Dash action =============>
        click-action  = "launch";
        scroll-action = "cycle-windows";
        #==<< Other >>=================>
        dock-position = "RIGHT";
        dock-fixed = true;
        extend-height = true;
        dash-max-icon-size = 38;
        show-trash = false;
        custom-theme-shrink = true;
      };
    };

  };
}
