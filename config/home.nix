{ pkgs
, alib
, ...
}:

let
  inherit (alib.enabling) enabled disabled enableBash;
in { config = {

  #====<< Utils & package bundles >>===========================================>
  programs = {
    # A "Post-modern terminal modal editor".
    helix = enabled // { defaultEditor = true; };
    # Terminal file manager.
    yazi = enableBash;
    # Customisable shell prompt.
    starship = enableBash // { useSubDir = true; };
    # Git terminal user interface
    lazygit = enabled;
    # A great shell for writing scripts
    nushell = enabled;
  };

  #====<< User Packages >>=====================================================>
  # If you want install software with non free licenses, set this to true. If
  # you only want one or two programs, try adding them in `modules/unfree.nix`.
  nixpkgs.config.allowUnfree = false;
  # Below is where your user packages are installed.
  # Go to https://search.nixos.org/packages to search for packages & programs.
  home.packages = (with pkgs; [
    #==<< Internet >>==================>
    firefox         # Fiwefwox!
    # tor-browser     # Anonymous web browser.
    # thunderbird     # FOSS email client.
    # signal-desktop  # Private messages.
    # webcord         # webclient discord.
    # qbittorrent     # BitTorrent client.
    #==<< Creativity >>================>
    libreoffice     # FOSS office suite.
    # obsidian        # Markdown file editor.
    # krita           # Digital illustration program.
    # obs-studio      # Video capture software.
    # kdenlive        # Video editing software.
    # tenacity        # Mutli track audio editor/recorder.
    # blender         # 3D modeling software.
    #==<< Media >>=====================>
    mpv             # Multi media player.
    # lollypop        # GTK Music player.
    # shortwave       # Radio station hub.
    # spotify
    #==<< Misc >>======================>
    # wineWowPackages.stable  # Windows executable (.exe) translator.
  ]);

  #====<< Themes & fonts >>====================================================>
  # This allows fontconfig to detect font packages, but it does not set the as
  # your preffered font. You'll need to open [system or app] settings and apply
  # them yourself.
  fonts = {
    fontconfig = enabled;
    packages = (with pkgs; [ maple-mono-NF ]);
    nerdfonts = [ "FiraCode" ];
  };
  home.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 30;
  };

  #====<< Shell settings >>====================================================>
  programs.bash = enabled // {
    blesh = enabled; # Pure bash line editor.
    shellAliases = {
      #==<< Nix misc abbr >>===========>
      cds = "cd ~/Nix/nixos-system";
      cdh = "cd ~/Nix/home-manager";
      #==<< Git abbriviations >>=======>
      lg = "lazygit";
      ga = "git add .";
      gc = "git add . && git commit";
      gp = "git add . && git commit && git push";
      gu = "git add . && git commit -m 'update' && git push";
    };
  };
  home.sessionVariables = {
    #ANY_VARIBLE = "ANY-VALUE";
  };

};}
