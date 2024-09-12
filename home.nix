{ config, pkgs, patt, alib, ... }:

let
  inherit (patt) username;
in { config = {

  #====<< Home manager settings >>=============================================>
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  # for more home-manager options, go to:
  # https://home-manager-options.extranix.com/

  #====<< Other settings >>====================================================>
  fonts.fontconfig.enable = true;
  systemd.user.startServices = "sd-switch";

  #====<< Gnome options >>=====================================================>
  niri.enable = true;
  gnome = {
    core-apps.enable = true;
    # defaults.enable = true;
    # paperwm.enable = true;
    # dash-to-dock.enable = true;
    # blur-my-shell.enable = true;
  };

  #====<< Utils & package bundles >>===========================================>
  nix-utils.enable = true;
  rust.enable = true;

  #====<< User Packages >>=====================================================>
  nixpkgs.config.allowUnfree = true;
  # Below is where your user packages are installed.
  # Go to https://search.nixos.org/packages to search for packages & programs.
  home.packages = with pkgs; [
    #==<< Internet >>==================>
    firefox         # Fiwefwox! or
    # librewolf       # Pre hardened Firefox or
    # floorp          # A beautiful Firefox Fork
    # tor-browser     # Anonymous web browser.
    thunderbird     # FOSS email client.
    # qbittorrent     # BitTorrent client
    # signal-desktop  # Private messages.
    # webcord         # Less telemetry discord.
    #==<< Creativity >>================>
    # obsidian        # Markdown file editor, or
    # logseq          # A FOSS alternative.
    # obs-studio      # Recording software.
    # davinci-resolve # Exeptional video editing software
    # blender         # 3D rendering software.
    libreoffice     # FOSS office suite.
    #==<< Media >>=====================>
    vlc             # Multi media player
    # spotify         # Music streaming service
    #==<< Terminal utils >>============>
    helix           # No nonsense terminal modal text editor.
    eza             # `ls`, but with more options and colours.
    bat             # Better cat. Print out files in the terminal.
    gitui           # Terminal UI for managing git repositories.
    #==<< Fonts >>=====================>
    (nerdfonts.override { fonts = [
      "FiraCode"
      # "CascadiaCode"
    ]; })
    # maple-mono-NF
    #==<< Misc >>======================>
    wezterm         # Rust made terminal emulator configured in lua, or
    # alacritty       # Tried and tested terminal emulator.
    wineWowPackages.stable  # Windows executable (.exe) translator
    #minecraft              # Minecraft
  ];

  #====<< Set user variables >>================================================>
  home.sessionVariables = {
    EDITOR  = "hx"; # change to nvim or equivalent
    STARSHIP_CONFIG = "/home/${username}/.config/starship/starship.toml";
    #ANY_VARIBLE = "VALUE";
  };

  #====<< Manage home files >>=================================================>
  home.file = {
    # This recursively imports all files in the dotfiles directory into
    # the .config directory. With this you can move all of your dotfiles
    # into dotfiles/ with no need to translate it into nix code.
    ".config" = {
      # source = config.lib.file.mkOutOfStoreSymlink "$HOME/Nixhome/dotfiles";
      source = ./dotfiles;
      recursive = true;
    };
    ".mozilla/firefox/${username}" = {
      # source = config.lib.file.mkOutOfStoreSymlink "$HOME/Nixhome/dotfiles";
      source = ./assets/firefox;
      recursive = true;
    };
  };
  home.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 30;
  };
  gtk.cursorTheme = {
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 30;
  };

};}
