{ pkgs
, pAtt
, ...
}:

let
  inherit (pAtt) gitUsername gitEmail;
in {

  #====<< Credentials >>=======================================================>
  programs.git = {
    enable = true;
    userName  = gitUsername;
    userEmail = gitEmail;
  };

}
