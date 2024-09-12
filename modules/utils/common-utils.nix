{ pkgs, lib, config, ... }:

let
  inherit (lib) mkOption mkIf types;
  cfg = config.nix-utils;
in {

  options.nix-utils.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      #==<< Nix utils >>==================>
      nixd
      nil
      nixdoc
      #==<< Other >>======================>
      marksman
      #==<< Shell scripts >>==============>
      bash-language-server
      nufmt
    ];
  };
}
