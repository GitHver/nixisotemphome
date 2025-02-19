{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkEnableOption mkIf mkBefore;
  cfg = config.programs.bash.blesh;
in {

  options = {
    programs.bash.blesh.enable = mkEnableOption ''
      blesh, a full-featured line editor written in pure Bash
    '';
  };

  config = {
    programs.bash.initExtra = mkIf cfg.enable (mkBefore ''
      source ${pkgs.blesh}/share/blesh/ble.sh
    '');
  };

}
