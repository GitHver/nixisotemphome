{ pkgs, ... }:

{
  home.packages = (with pkgs; [
    # Here you can place packages that you only want on this host.
    # ...
    # prismlauncher # A mincraft launcher.
    # wineWowPackages.unstable
  ]);  
}
