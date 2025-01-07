{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkEnableOption mkIf mkBefore;
in {

  options = {
    programs.zsh.launchFromBash = mkEnableOption ''
      Runs ZSH everytime a BASH instance is launched
    '';
    programs.fish.launchFromBash = mkEnableOption ''
      Runs Fish everytime a BASH instance is launched
    '';
    programs.nushell.launchFromBash = mkEnableOption ''
      Runs Nushell everytime a BASH instance is launched
    '';
  };

  config = {
    programs.bash.initExtra = 
    if config.programs.zsh.launchFromBash
    then
    ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "zsh" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.zsh}/bin/zsh $LOGIN_OPTION
      fi
    ''
    else if config.programs.fish.launchFromBash
    then
    ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    ''
    else if config.programs.nushell.launchFromBash
    then
    ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "nu" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.nushell}/bin/nu $LOGIN_OPTION
      fi
    ''
    else ""
    ;
  };

}
