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
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
      # . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      # unset __HM_SESS_VARS_SOURCED ; . .profile
    shellAliases = {
      re = "unset __HM_SESS_VARS_SOURCED ; . .profile";
      yy = "yazi";
      Syy = "sudo -E yazi";
    };
  };
}
