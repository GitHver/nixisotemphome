{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fish
  ];

  programs.fish = {
    enable = true;
    shellInitLast = ''
      function fish_greeting
          echo Greetings $USER! The time is: (set_color yellow; date +%T; set_color normal)
      end
      starship init fish | source
      zoxide init fish | source
    ''; # eval (zellij setup --generate-auto-start fish | string collect)
    shellAbbrs = {
      s = "sudo";
      S = "sudo -E";
      yy = "yazi";
      Syy = "sudo -E yazi";
      el = "eza -la";
      zn = "z /etc/nixos";
      zh = "z ~/.config/home-manager";
      #==<< NixOS abbriviations >>=====>
      nrs  = "sudo nixos-rebuild switch";
      nrr  = "sudo nixos-rebuild --rollback switch";
      nrb  = "sudo nixos-rebuild build";
      nrbt = "sudo nixos-rebuild boot";
      nrt  = "sudo nixos-rebuild test";
      #==<< Home-manager abbrs >>======>
      hms  = "home-manager switch";
      hmb  = "home-manager build";
      hmg  = "home-manager generations";
      hmxg = "home-manager expire-generations 1d";
      hmrg = "home-manager remove-generations";
      #==<< Git abbriviations >>=======>
      ga = "git add .";
      gc = "git commit";
      gcp = ''
        git add .
        git commit
        git push
      '';
      Sga = "sudo -E git add .";
      Sgc = "sudo -E git commit";
      Sgcp = ''
        sudo -E git add .
        sudo -E git commit
        sudo -E git push
      '';
    };
    shellAliases = {
      #==<< SSH setup >>===============>
      ssh1 = ''
        echo '
        copy the following and replace it with your email and then run it

        ssh-keygen -t ed25519 -C "your@email.host"'
      '';
      ssh2 =''
        echo '
        copy the below and paste it into the next step
  
        Host *
          AddKeysToAgent yes
          IdentityFile ~/.ssh/id_ed25519'
      '';
      ssh3 = ''
        touch ~/.ssh/config
        $EDITOR ~/.ssh/config
      '';
      ssh4 = ''
        ssh-add ~/.ssh/id_ed25519
        cat ~/.ssh/id_ed25519.pub
      '';
      ssh-perms = ''
        chmod 644 ~/.ssh/config
        chmod 644 ~/.ssh/known_hosts.old
        chmod 644 ~/.ssh/id_ed25519.pub
        chmod 600 ~/.ssh/know_hosts
        chmod 600 ~/.ssh/id_ed25519
      '';
    };
  };

  # programs.zoxide.enableFishIntegration = true;
  # programs.zellij.enableFishIntegration = true;
  # programs.starship.enableFishIntegration = true;
  # programs.fzf.enableFishIntegration = true;
  # programs.eza.enableFishIntegration = true;
  # programs.yazi.enableFishIntegration = true;
  
}
