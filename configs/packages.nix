{ pkgs
, ...
}:

{ config = {

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
    # vesktop         # Linux Discord client.
    # qbittorrent     # BitTorrent client.
    # yt-dlp          # Tool to download media from the web.
    # spotdl          # Finds spotify songs and downloads them of YouTube.
    #==<< Creativity >>================>
    # libreoffice     # FOSS office suite.
    # obsidian        # Markdown file editor.
    # gimp            # GNU image manipulator
    # krita           # Digital illustration program.
    # obs-studio      # Video capture software.
    # kdenlive        # Exeptional video editing software.
    # tenacity        # Mutli track audio editor/recorder.
    # blender         # 3D modeling software.
    #==<< Media >>=====================>
    # mpv             # Multi media player.
    # lollypop        # GTK Music player.
    # shortwave       # Radio station hub.
    # spotify
    #==<< Misc >>======================>
    # wineWowPackages.stable  # Windows executable (.exe) translator.
    # prismlauncher           # Open source Minecraft launcher.
    #==<< Terminal utils >>============>
    ripgrep
    fzf
    #==<< Programming >>===============>
    # rustup
    # gcc
    #==<< LSPs >>======================>
    nil # nix lsp
    bash-language-server
  ])
  ++ # Nerdfonts
  (with pkgs.nerd-fonts; [
    fira-code
  ]);  

};}
