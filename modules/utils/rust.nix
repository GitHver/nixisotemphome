{ pkgs, lib, config, ... }:

let
  inherit (lib) mkOption mkIf types;
  cfg = config.rust;
in {

  options.rust.enable = mkOption {
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
    ];
  };
}
