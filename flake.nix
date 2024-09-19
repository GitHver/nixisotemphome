{

  description =''
    This user's flake!
  '';

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url  = "github:nixos/nixpkgs/nixos-24.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }: let
    lib = nixpkgs.lib // home-manager.lib;
    inherit (lib) homeManagerConfiguration;
    inherit (lib.filesystem) listFilesRecursive;
    patt = {
      username = "your-username";
      email    = "your@email.provider";
    };
    system = "x86_64-linux";
  in {

    homeConfigurations = { #==<< User home manager >>==========================>
      "${patt.username}" = homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };
        modules = [ ./home.nix ] ++ listFilesRecursive ./modules;
        extraSpecialArgs = { inherit inputs patt; };
      };
    };
 
  };

}
