{ pkgs, ... }:

{

  home.packages = with pkgs; [
   #==<< Rust tools >>================>
    rustc
    cargo
    rust-analyzer 
    clippy
    rustfmt
    #rustcli
  ];

}
