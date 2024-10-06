{ pkgs
, patt
, lib
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
  fonts.fontconfig.enable = true;
  systemd.user.startServices = "sd-switch";

  #====<< Shell aliases >>=====================================================>
  home.shellAliases = {
    #==<< SSH setup >>===============>
    ssh-setup = ''
      echo '
      copy the following and replace it with your email and then run it
        ssh-keygen -t ed25519 -C "your@email.domain"

      then copy the below into your clipboard
        Host *
          AddKeysToAgent yes
          IdentityFile ~/.ssh/id_ed25519

      Then execute these commands and paste the above into the created file and save the file
        touch ~/.ssh/config
        $EDITOR ~/.ssh/config

      Finally, execute the following command to print out your public key
        ssh-add ~/.ssh/id_ed25519
        cat ~/.ssh/id_ed25519.pub'
    '';
    ssh-perms = ''
      chmod 644 ~/.ssh/config
      chmod 644 ~/.ssh/known_hosts.old
      chmod 644 ~/.ssh/id_ed25519.pub
      chmod 600 ~/.ssh/known_hosts
      chmod 600 ~/.ssh/id_ed25519
    '';
  };

};}
