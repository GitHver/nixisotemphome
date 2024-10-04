{ pkgs, patt, lib, ... }:

let
  inherit (patt) username;
  enabled = { enable = true; };
in { config = {

  #====<< Utils & package bundles >>===========================================>
  # niri.enable = true;
  gnome.core-apps.enable = true;
  nix-utils.enable = true;
  rust.enable = true;
  terminal = {
    zoxide.enable = true;
    yazi.enable = true;
    wezterm.enable = true;  # Rust made terminal emulator configured in lua
    helix.enable = true;    # No nonsense terminal modal text editor.
    starship.enable = true;
  };

  #====<< User Packages >>=====================================================>
  nixpkgs.config.allowUnfree = true;
  # Below is where your user packages are installed.
  # Go to https://search.nixos.org/packages to search for packages & programs.
  home.packages = with pkgs; [
    #==<< Internet >>==================>
    firefox         # Fiwefwox! or
    # librewolf       # Pre hardened Firefox.
    # tor-browser     # Anonymous web browser.
    thunderbird     # FOSS email client.
    # qbittorrent     # BitTorrent client.
    # signal-desktop  # Private messages.
    webcord         # webclient discord.
    #==<< Creativity >>================>
    libreoffice     # FOSS office suite.
    obsidian        # Markdown file editor.
    # krita           # Digital illustration program.
    # obs-studio      # Recording software.
    # davinci-resolve # Exeptional video editing software
    # blender         # 3D modeling software.
    #==<< Media >>=====================>
    mpv             # multi media player
    yt-dlp          # Tool to download media. supports many websites
    # spotify         # Music streaming service
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
    #ANY_VARIBLE = "VALUE";
  };

  #====<< Manage home files >>=================================================>
  home.file = {
    # This recursively imports all files in the dotfiles directory into
    # the .config directory. With this you can move all of your dotfiles
    # into dotfiles/ with no need to translate it into nix code.
    # ".config" = {
    #   # source = config.lib.file.mkOutOfStoreSymlink "$HOME/Nixhome/dotfiles";
    #   source = ./dotfiles;
    #   recursive = true;
    # };
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

};}





  # gtk.cursorTheme = {
  #   package = pkgs.capitaine-cursors;
  #   name = "capitaine-cursors";
  #   size = 30;
  # };
  #   defaults.enable = true;
  #   paperwm.enable = true;
  #   dash-to-dock.enable = true;
  #   blur-my-shell.enable = true;
