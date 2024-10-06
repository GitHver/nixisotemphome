{ pkgs
, lib
, config
, ...
}:

let
  inherit (lib) mkOption mkIf types;
  cfg = config.terminal.zoxide;
in {

  options.terminal.zoxide.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };

}
