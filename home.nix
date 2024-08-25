{ config, pkgs, patt, alib, ... }:

let
  inherit (alib) umport;
  inherit (patt) username;
in

{ ################## Variable scope ############################################

  imports = umport { path = ./modules; recursive = true; };

 #====<< Home manager settings >>==============================================>
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  # for more home-manager options, go to:
  # https://home-manager-options.extranix.com/

 #====<< Other settings >>=====================================================>
  fonts.fontconfig.enable = true;
  systemd.user.startServices = "sd-switch";

 #====<< User Packages >>======================================================>
  nixpkgs.config.allowUnfree = true;
  # Below is where your user packages are installed.
  # Go to https://search.nixos.org/packages to search for programs.
  home.packages = with pkgs; [

    pavucontrol
    fuzzel
  
   #==<< Internet >>===================>
    firefox         # Fiwefwox! or
    #librewolf       # Pre hardened Firefox or
    #floorp          # A beautiful Firefox Fork
    tor-browser     # Anonymous web browser.
    thunderbird     # FOSS email client.
    #qbittorrent     # BitTorrent client
    #signal-desktop  # Private messages.
    webcord         # No telemetry discord  .

   #==<< Creativity >>=================>
    obsidian        # Markdown file editor, or
    #logseq          # A FOSS alternative.
    obs-studio      # Recording software.
    #davinci-resolve # Exeptional video editing software
    #blender         # 3D rendering software.
    libreoffice    # FOSS office suite.

   #==<< Media >>======================>
    vlc             # Multi media player
    spotify         # Music streaming service

   #==<< Terminal utils >>=============>
    # fish            # Thw Friendly Interactive SHell.
    wezterm         # Rust made terminal emulator configured in lua, or
    #alacritty       # Tried and tested terminal emulator.
    zellij          # User friendly terminal multiplexer, or
    #tmux            # A More known alternative,
    helix           # No nonsense terminal modal text editor, or
    #neovim          # A bigger ecosystem with plugins.
    yazi            # batterise included terminal file manager, or
    #lf              # Minimal and simple alternative.
    zoxide    # A better cd command that learns your habbits.
    eza       # LS but with more options ad customization.
    bat       # Better cat. Print out files in the terminal.
    starship  # Shell promt customization tool.

   #==<< Fonts >>======================>
    (nerdfonts.override { fonts = [
      "CascadiaCode"
    ]; })
    
   #==<< Misc >>=======================>
    wineWowPackages.stable  # Windows executable (.exe) translator
    #minecraft              # Minecraft
  ];


 #====<< Set user variables >>=================================================>
  home.sessionVariables = {
    #SHELL   = "fish";
    EDITOR  = "hx"; # change to nvim or equivalent
    #ANY_VARIBLE = "VALUE";
  };

 #====<< Manage home files >>==================================================>
  #xdg.configFile = {
  home.file = {
    # This recursively imports all files in the dotfiles directory into
    # the .config directory. With this you can move all of your dotfiles
    # into dotfiles/ with no need to translate it into nix code.
    ".config" = {
      # source = config.lib.file.mkOutOfStoreSymlink "/home/hver/GNix/Hvernix/dotfiles";
      source = ./dotfiles;
      recursive = true;
    };

    # ".mozilla/firefox/${profile}" = {
    #   source = ./other/firefox;
    #   recursive = true;
    # };

    ".config/niri/config.kdl" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/${username}/Home/other/config.kdl";
      recursive = true;
    }; 
  
  };

} ################## End of variable scope #####################################
