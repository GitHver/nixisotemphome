{ lib
, patt
, ...
}:

let
  inherit (lib) mkDefault;
  inherit (patt) username;
in {
  
  config = {
    #====<< Home manager settings >>=============================================>
    # for more home-manager options, go to:
    # https://home-manager-options.extranix.com/
    programs.home-manager.enable = true;
    home = {
      username = username;
      homeDirectory = mkDefault ("/home/" + username);
      stateVersion = mkDefault "24.11";
    };
    nix.gc = {
      automatic = true;
      frequency = "weekly";
      options = "--delete-older-than 7d";
    };
  };

}
