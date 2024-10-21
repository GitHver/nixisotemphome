{ pkgs, patt, lib, ... }:

let
  inherit (patt) username;
  enabled  = { enable = true; };
  disabled = { enable = false; };
  enableBash = { enable = true; enableBashIntegration = true; };
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
    tor-browser     # Anonymous web browser.
    thunderbird     # FOSS email client.
    # signal-desktop  # Private messages.
    webcord         # webclient discord.
    # qbittorrent     # BitTorrent client.
    # yt-dlp          # Tool to download media from the web.
    #==<< Creativity >>================>
    libreoffice     # FOSS office suite.
    obsidian        # Markdown file editor.
    # krita           # Digital illustration program.
    # obs-studio      # Video capture software.
    # kdenlive        # Exeptional video editing software.
    # tenacity        # Mutli track audio editor/recorder.
    # blender         # 3D modeling software.
    #==<< Media >>=====================>
    mpv             # multi media player
    amberol         # Simple and elegant music player.
    #==<< Misc >>======================>
    # wineWowPackages.stable  # Windows executable (.exe) translator
    prismlauncher           # Open source Minecraft launcher.
    #==<< Programming >>===============>
    nil
    bash-language-server
    rustup
  ]);

  #====<< Themes & fonts >>====================================================>
  # This allows fontconfig to detect font packages, but it does not set the as
  # your preffered font. You'll need to open [system or app] settings and apply
  # them yourself.
  fonts.fontconfig.enable = true;
  home.font = {
    packages = (with pkgs; [
      maple-mono-NF
    ]);
    nerdFonts = [
      "FiraCode"
    ];
  };
  home.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 30;
  };

  #====<< Shell settings >>====================================================>
  programs.bash = {
    enable = true;
    blesh.enable = true;
    shellAliases = {
      #==<< Nix misc abbr >>===========>
      cds = "cd ~/Nix/nixos-system";
      cdh = "cd ~/Nix/home-manager";
      #==<< Git abbriviations >>=======>
      lg = "lazygit";
      ga = "git add .";
      gc = "git add . && git commit";
      gp = "git add . && git commit && git push";
    };
  };
  home.sessionVariables = {
    #ANY_VARIBLE = "ANY-VALUE";
  };

  #====<< Manage home files >>=================================================>
  home.file = {
    # This recursively imports all files in the dotfiles directory into
    # the .config directory. With this you can move all of your dotfiles
    # into dotfiles/ with no need to translate it into Nix code.
    ".config" = {
      # source = config.lib.file.mkOutOfStoreSymlink "$HOME/Nix/home-manager/dotfiles";
      source = ./../assets/dotfiles;
      recursive = true;
    };
    ".mozilla/firefox/${username}" = {
      source = ./../assets/firefox;
      recursive = true;
    };
    ".local/bin" = {
      source = ./../assets/bash;
      recursive = true;
    };
  };

};}
