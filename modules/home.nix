{ lib
, patt
, ...
}:

let
  inherit (patt) username;
in { config = {

  #====<< Home manager settings >>=============================================>
  home.username = username;
  home.homeDirectory = "/home/" + username;
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  # for more home-manager options, go to:
  # https://home-manager-options.extranix.com/

  #====<< Other settings >>====================================================>
  # systemd.user.startServices = "sd-switch";

};}
