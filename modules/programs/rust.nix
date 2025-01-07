{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.programs.rust;
in {

  options.programs.rust = {
    enable = mkEnableOption "all essential rust utils";
  };

  config = mkIf cfg.enable  {
    home.packages = (with pkgs; [
      cargo
      rustc
      rust-analyzer
      rustfmt
      gcc
    ]);
  };

}
