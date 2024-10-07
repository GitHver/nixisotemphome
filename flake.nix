{ ############################ Initial scope ###################################

  # This is not needed if you don't plan on making this flake public.
  description =''
    My personal Home manager flake!
  '';

  inputs = {
    #====<< Core Nixpkgs >>====================================================>
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #====<< Home manager >>====================================================>
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    #====<< Extension utils >>=================================================>
    nixisoextras.url = "github:GitHver/nixisoextras";
    nixisoextras.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }: let
    #====<< Required variables >>======>
    lib = nixpkgs.lib // inputs.nixisoextras.lib;
    #====<< Used functions >>==========>
    inherit (lib) genAttrs attrsFromList;
    inherit (lib.lists) flatten forEach foldl;
    inherit (lib.filesystem) listFilesRecursive;
    inherit (builtins) readDir attrNames;
    inherit (home-manager.lib) homeManagerConfiguration;
    #====<< Personal Attributes >>=====>
    patt = rec {
      username = "your-username";
      email    = "your@email.domain";
      gitUsername = username;
      gitEmail    = email;
    };
    #====<< Other >>===================>
    hostAttrs = attrNames (readDir ./hosts);
    hosts = forEach hostAttrs (host: import ./hosts/${host});
    genForAllSystems = (funct: genAttrs supportedSystems funct);
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
  in {

    #====<< Home manager configurations >>=====================================>
    homeConfigurations = attrsFromList (forEach hosts (host: {
      "${patt.username}@${host.name}" = homeManagerConfiguration {
        pkgs = import nixpkgs { system = host.system; };
        extraSpecialArgs = { inherit inputs patt; };
        modules = [
          self.homeModules.default
          ./home.nix
        ];
      };
    }));

    #====<< Home manager modules >>============================================>
    homeModules.default = { imports = listFilesRecursive ./modules; };

    #====<< Nix Code Formatter >>==============================================>
    # This defines the formatter that is used when you run `nix fmt`. Since this
    # calls the formatters package, you'll need to define which architecture
    # package is used so different computers can fetch the right package.
    formatter = genForAllSystems (system:
      let pkgs = import nixpkgs { inherit system; };
      in pkgs.nixpkgs-fmt
      or pkgs.nixfmt-rfc-style
      or pkgs.alejandra
    );

  };

}
