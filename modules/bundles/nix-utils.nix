{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkOption mkIf types;
  cfg = config.bundles.nix-utils;
in {

  options.bundles.nix-utils.enable = mkOption {
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
      # marksman
      # bash-language-server
    ];
  };

}
