{ pkgs
, lib
, config
, patt
, ...
}:

let
  inherit (lib) mkOption mkIf types;
  inherit (patt) username;
  cfg = config.bundles.terminal-utils;
  enabled = {
    enable = true;
  };
  fishEnabled = {
    enable = true;
    enableFishIntegration = true;
  };
in {

  options.bundles.terminal-utils.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf cfg.enable {
    programs = {
      # A "Post modern modal text editor".
      helix = enabled;
      # Terminal file manager.
      yazi = fishEnabled;
      # User friendly terminal multiplexer.
      # zellij = fishEnabled;
      # Customisable shell prompt.
      starship = fishEnabled;
      # Smart `cd` command.
      zoxide = fishEnabled;
      # `ls`, but with more options and colours.
      eza = fishEnabled;
    };
    home.sessionVariables = {
      EDITOR = "hx";  # sets helix as your default text editor.
      STARSHIP_CONFIG = "/home/${username}/.config/starship/starship.toml";
    };
  };

}
