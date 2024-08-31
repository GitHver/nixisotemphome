{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkOption mkIf types;
  name = "gnome-apps";
  cfg = config.${name};
in {

  options.${name}.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf cfg.enable {
    home.packages = (with pkgs; [
      #==<< Gnome core >>======================================================>
      gnome-console             # (console) gnome's terminal emulator
      nautilus                  # (files) file manager
      gnome-text-editor         # (text editor) a basic text editor
      gnome-system-monitor      # (system monitor) resource monitor
      gnome-disk-utility        # (disks) disk formatter
      gnome-tweaks              # (tweaks) extra gnome settings
      #==<< Gnome extra >>=====================================================>
      file-roller               # (archive manager) file extractor
      baobab                    # (disk usage analyzer) storege space viewer
      simple-scan               # (document scaner) printer interfacer
      evince                    # (document viewer) yeah.
      gnome.gnome-clocks        # (clocks) clock and timer util
      gnome.gnome-characters    # (characters) special characters and emojis
      gnome-font-viewer         # (fonts) font picker
      gnome-connections         # (connections) remote desktop connections
      gnome.gnome-logs          # (logs) system logs
      gnome-calculator          # (calculator) a... calculator
      dconf-editor              # (dconf editor) GUI for dconf
      #==<< Gnome media >>=====================================================>
      loupe                     # (image viewer) photo booth
      gnome.gnome-music         # (music) music player
      totem                     # (videos) video player  
    ]);
  };

}