{ pkgs, ... }:

{
  imports = [
    ./../../configs/home.nix
    ./../../configs/packages.nix
    ./../../configs/symlinking.nix
  ];

  home.packages = (with pkgs; [
    tor-browser
  ]);
}
