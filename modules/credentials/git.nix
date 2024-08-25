{ pkgs, patt, ... }:

let
  inherit (patt) username email;
in {

  #====<< Credentials >>=======================================================>
  programs.git = {
    enable = true;
    userName  = username;
    userEmail = email;
  };

}
