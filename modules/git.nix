{ pkgs
, patt
, ...
}:

let
  inherit (patt) gitUsername gitEmail;
in {

  #====<< Credentials >>=======================================================>
  programs.git = {
    enable = true;
    userName  = gitUsername;
    userEmail = gitEmail;
  };
  home.packages = (with pkgs; [
    gitui # Terminal UI for managing git repositories.
  ]);

}
