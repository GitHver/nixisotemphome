{ pkgs, ... }:

{
  
  home.packages = with pkgs; [
   #==<< Nix utils >>==================>
    nixd
    nil
    nixdoc
   #==<< Other >>======================>
    marksman
   #==<< Shell scripts >>==============>
    bash-language-server
    nufmt
  ];

}
