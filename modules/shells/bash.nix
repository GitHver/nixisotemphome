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
    };
  };
}
