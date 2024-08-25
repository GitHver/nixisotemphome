{ pkgs, ... }:

{
 #====<< Credentials >>========================================================>
  programs.git = {
    enable = true;
    userName  = "Your username";
    userEmail = "your@email.provider";
  };
}
