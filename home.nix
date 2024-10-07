{ pkgs, patt, lib, ... }:

let
  inherit (patt) username;
  enabled = { enable = true; };
  fishEnabled = {
    enable = true;
    enableFishIntegration = true;
  };
in { config = {

  #====<< Utils & package bundles >>===========================================>
  bundles = {
    rust = enabled;
    nix-utils = enabled;
  };
  programs = {
    helix = enabled;
    zoxide = fishEnabled;
    yazi = fishEnabled;
    starship = fishEnabled;
  };

  #====<< User Packages >>=====================================================>
  nixpkgs.config.allowUnfree = true;
  # Below is where your user packages are installed.
  # Go to https://search.nixos.org/packages to search for packages & programs.
  home.packages = with pkgs; [
    #==<< Internet >>==================>
    firefox         # Fiwefwox!
    tor-browser     # Anonymous web browser.
    thunderbird     # FOSS email client.
    qbittorrent     # qBitTorrent client.
    signal-desktop  # Private messages.
    webcord         # webclient discord.
    #==<< Creativity >>================>
    libreoffice     # FOSS office suite.
    obsidian        # Markdown file editor.
    krita           # Digital illustration program.
    obs-studio      # Video capture software.
    kdenlive        # Exeptional video editing software.
    blender         # 3D modeling software.
    #==<< Media >>=====================>
    mpv             # multi media player
    yt-dlp          # Tool to download media. supports many websites.
    amberol         # Simple and elegant music player.
    #==<< Terminal utils >>============>
    zellij          # Terminal multiplexer.
    eza             # `ls`, but with more options and colours.
    bat             # Better cat. Print out files in the terminal.
    gitui           # Terminal UI for managing git repositories.
    #==<< Fonts >>=====================>
    # maple-mono-NF
    (nerdfonts.override { fonts = [
      "FiraCode"
      # "CascadiaCode"
    ]; })
    #==<< Misc >>======================>
    wineWowPackages.stable  # Windows executable (.exe) translator
    prismlauncher           # Open source Minecraft launcher.
  ];

  #====<< Set user variables >>================================================>
  home.sessionVariables = {
    EDITOR = "hx";
    STARSHIP_CONFIG = "/home/${username}/.config/starship/starship.toml";
    #ANY_VARIBLE = "ANY-VALUE";
  };

  #====<< Manage home files >>=================================================>
  home.file = {
    # This recursively imports all files in the dotfiles directory into
    # the .config directory. With this you can move all of your dotfiles
    # into dotfiles/ with no need to translate it into Nix code.
    ".config" = {
      # source = config.lib.file.mkOutOfStoreSymlink "$HOME/Nixhome/dotfiles";
      source = ./dotfiles;
      recursive = true;
    };
    ".mozilla/firefox/${username}" = {
      source = ./assets/firefox;
      recursive = true;
    };
  };

  home.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 30;
  };

};}
