{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      eval "$(zoxide init bash)"
      eval "$(starship init bash)"
      # eval "$(zellij setup --generate-auto-start bash)"
    '';
    initExtra = ''
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      unset __HM_SESS_VARS_SOURCED ; . .profile
      
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
    shellAliases = {
      re = "unset __HM_SESS_VARS_SOURCED ; . .profile";
      homeswitch = ''
        home-manager switch --flake ~/Home#admin
        unset __HM_SESS_VARS_SOURCED ; . ~/.profile
      '';
      yy = "yazi";
      syy = "sudo -E yazi";
      ssh1 = ''
        echo '
        copy the following and replace it with your email and then run it

        ssh-keygen -t ed25519 -C "your@email.host"'
      '';
      ssh2 =''
        echo '
        copy the below and pasrte it into the next step
    
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
    };
  };
}
