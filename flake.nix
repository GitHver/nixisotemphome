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
    alib = lib;
    #====<< Used functions >>==========>
    inherit (lib) genAttrs attrsFromList namesOfDirsIn;
    inherit (lib.lists) flatten forEach;
    inherit (lib.filesystem) listFilesRecursive;
    inherit (home-manager.lib) homeManagerConfiguration;
    #====<< Personal Attributes >>=====>
    pAtt = rec {
      flakeRepo   = "/Nix/home-manager";
      username    = "your-username";
      email       = "your@email.domain";
      gitUsername = username;
      gitEmail    = email;
    };
    #====<< Other >>===================>
    hostnames = namesOfDirsIn ./hosts;
    hosts = forEach hostnames (host: import ./hosts/${host}/info.nix);
    # This is only for the formatter, as it is not tied to an already active system.
    genForAllSystems = (funct: genAttrs supportedSystems funct);
    supportedSystems = [
      "x86_64-linux"
      # "aarch64-linux"
    ];
  in {

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

    #====<< Home manager configurations >>=====================================>
    homeConfigurations = attrsFromList (forEach hosts (host: {
      "${pAtt.username}@${host.name}" = homeManagerConfiguration {
        pkgs = import nixpkgs { inherit (host) system; };
        extraSpecialArgs = { inherit alib inputs pAtt self; };
        modules = flatten [
          ./hosts/${host.name}
          self.homeModules.default
        ];
      };
    }));

    #====<< Home manager modules >>============================================>
    homeModules = rec {
      personal = { imports = listFilesRecursive ./modules; };
      default = [ personal ] ++ input-modules;
      input-modules = [
      ];
    };

  };

}
