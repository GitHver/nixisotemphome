{ pkgs, lib, config, ... }:

let
  inherit (lib) mkOption mkIf types;
  name = "wbg";
  cfg = config.${name};
in {

  options.${name}.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      wbg
    ];

    # programs.bash.profileExtra = ''
    #   wbg ~/Home/assets/image.jpg 
    # '';

  };
}
