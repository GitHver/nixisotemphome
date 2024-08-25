{ pkgs, lib, config, ... }:

let
  inherit (lib) mkOption mkIf types;
  cfg = config.wbg;
in {

  options.wbg.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      wbg
    ];
    programs.bash.profileExtra = ''
      wbg ~/Home/assets/Miku-piku.jpg
    '';
  };
}
