{ pkgs, lib, config, ... }:

let
  inherit (lib) mkOption mkIf types;
  cfg = config.wbg;
in {

  options.wbg.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wbg
    ];
    programs.bash.profileExtra = ''
      wbg ~/.config/home-manager/assets/astronaut-gruvbox.jpg
    '';
  };
}
