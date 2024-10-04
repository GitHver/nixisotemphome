{ pkgs, patt, ... }:

let
  inherit (patt) gitUsername gitEmail;
in {

  #====<< Credentials >>=======================================================>
  programs.git = {
    enable = true;
    userName  = gitUsername;
    userEmail = gitEmail;
  };

}
