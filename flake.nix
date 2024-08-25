{

description =''
  This user's flake!
'';

inputs = {

  nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  stable.url  = "github:nixos/nixpkgs/nixos-24.05";

  home-manager.url = "github:nix-community/home-manager";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";

  nypkgs.url = "github:yunfachi/nypkgs";
  nypkgs.inputs.nixpkgs.follows = "nixpkgs";
};

outputs = { self, nixpkgs, home-manager, ... }@inputs: 

let
  alib = nixpkgs.lib // home-manager.lib // inputs.nypkgs.lib."x86_64-linux";
  patt = {
    username = "YOUR_USERNAME";
    email = "your@email.provider";
  };
in {

  homeConfigurations = { #==<< User home manager >>==========================>
    "${patt.username}" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [ ./home.nix ];
      extraSpecialArgs = { inherit inputs patt alib; };
    };
  };
 
};

}
