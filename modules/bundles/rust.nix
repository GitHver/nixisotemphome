{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkOption mkIf types;
  cfg = config.bundles.rust;
in {

  options.bundles.rust.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      #==<< Rust tools >>================>
      rustc
      cargo
      rust-analyzer 
      clippy
      rustfmt
      #rustcli
      gcc
    ];
  };

}
