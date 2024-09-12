{ pkgs, ... }:

{
  programs.bash.enable = true;
  programs.bash.initExtra = /*bash*/''
    unset __HM_SESS_VARS_SOURCED ; . .profile
    if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    fi
  '';
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      ${pkgs.nix-your-shell}/bin/nix-your-shell fish | source
      function fish_greeting
          echo Greetings $USER! The time is: (set_color yellow; date +%T; set_color normal)
      end
    '';
    shellAbbrs = {
      s = "sudo";
      S = "sudo -E";
      yz = "yazi";
      el = "eza -l";
      ela = "eza -la";
      elt = "eza -lTs tyoe";
      elat = "eza -laTs type";
      zn = "z /etc/nixos";
      zh = "z ~/.config/home-manager";
      #==<< NixOS abbriviations >>=====>
      nrs  = "sudo nixos-rebuild switch";
      nrr  = "sudo nixos-rebuild --rollback switch";
      nrb  = "sudo nixos-rebuild build";
      nrbt = "sudo nixos-rebuild boot";
      nrt  = "sudo nixos-rebuild test";
      # nix flake update system
      nfus = "nix flake update /etc/nixos";
      # nixos-rebuild update
      nru  = ''
        nix flake update /etc/nixos
        sudo nixos-rebuild switch
      '';
      #==<< Home-manager abbrs >>======>
      hms  = "home-manager switch";
      hmb  = "home-manager build";
      hmg  = "home-manager generations";
      hmxg = "home-manager expire-generations 1d";
      hmrg = "home-manager remove-generations";
      # nix flake update home
      nfuh = "nix flake update ~/.config/home-manager";
      # home-manager update
      hmu  = ''
        nix flake update ~/.config/home-manager
        home-manager switch
      '';
      #==<< Nix misc abbr >>===========>
      nsh  = "nix shell nixpkgs#";
      ncg  = "sudo nix-collect-garbage --delete-older-than";
      nsgc = "nix store gc";
      nso  = "nix store optimise";
      #==<< Git abbriviations >>=======>
      gu = "gitui";
      ga = "git add .";
      gc = ''
        git add .
        git commit
      '';
      gp = ''
        git add .
        git commit
        git push
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
        chmod 600 ~/.ssh/known_hosts
        chmod 600 ~/.ssh/id_ed25519
      '';
      nix-perms = ''
        sudo chown -R $USER /etc/nixos
        chmod -R 777 /etc/nixos
        cd /etc/nixos
        git init
        git add .
        git commit -m 'initial commit'
      '';
    };
  };

  programs.zoxide.enable = true;
  programs.zoxide.enableFishIntegration = true;

  programs.starship.enable = true;
  programs.starship.enableFishIntegration = true;
  # programs.starship.enableTransience = true;
  # programs.fzf.enableFishIntegration = true;
  # programs.eza.enableFishIntegration = true;
  programs.yazi.enable = true;
  programs.yazi.enableFishIntegration = true;
  
}
