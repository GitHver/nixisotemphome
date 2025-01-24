{ pkgs
, lib
, config
, alib
, pAtt
, ...
}:

let
  inherit (alib.enabling) enabled disabled enableAllShells;
  inherit (lib) mkDefault;
  inherit (pAtt) username gitUsername gitEmail gitMbranch parentRepo homeManagerRepo nixosRepo;
in { config = {

  #====<< Home manager settings >>=============================================>
  # for more home-manager options, go to:
  # https://home-manager-options.extranix.com/
  programs.home-manager.enable = true;
  home = {
    username = username;
    homeDirectory = mkDefault ("/home/" + username);
    stateVersion = mkDefault "24.11";
  };

  #====<< Themes & fonts >>====================================================>
  # This allows fontconfig to detect font packages, but it does not set the as
  # your preffered font. You'll need to open [system or app] settings and apply
  # them yourself.
  fonts.fontconfig = enabled;
  home.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 30;
  };

  #====<< Shell settings >>====================================================>
  home.sessionVariables = {
    NIXOS_REPO = config.home.homeDirectory + parentRepo + nixosRepo;
    HOMEMANAGER_REPO = config.home.homeDirectory + parentRepo + homeManagerRepo;
    GITMBRANCH = gitMbranch;
    #ANY_VARIBLE = "ANY-VALUE";
  };
  home.shellAliases = {
    #==<< Nix misc aliases >>==>
    cds = "cd ~${parentRepo + nixosRepo}";
    cdh = "cd ~${parentRepo + homeManagerRepo}";
    #==<< Git aliases >>=======>
    lg = "lazygit";
  };
  # NOTE: `launchFromBash` is used as BASH is the default shell as defined the
  # NixOS config repository. So instead of changing the system files to set a
  # login shell for each user, we can instead just launch our preffered shell
  # every time a Bash shell is initialized. You can only have one shell launch
  # from bash.
  # BASH - The Default shell for most Linux Distributions.
  programs.bash = {
    # BASH must be enabled for home-manager to be able to manage bash files. it
    # needs that to be able to launch other shells, so this option should always
    # be true even if you don't use BASH as your preffered shell.blesh
    enable = true;
    # Makes sure that when you open a new shell the envvars get sourced.
    initExtra = "unset __HM_SESS_VARS_SOURCED ; . ~/.profile";
    # A pure *B*ash *L*ine *E*ditor (.sh). Gives BASH similar features to
    # base Fish and ZSH autocompletions. Can be really slow on older hardware.
    blesh.enable = true;
  };
  # Z shell. A simple and extensible with a POSIX compliant mode.
  programs.zsh = disabled // {
    # launchFromBash = true;
  };
  # The Friendly Interactive Shell. Simple and easy to use BASH alternative.
  programs.fish = disabled // {
    # launchFromBash = true;
  };
  # A shell where all data is structured. Great for writing scripts.
  programs.nushell = disabled // {
    # launchFromBash = true;
    # Since Nushell doesn't source variables and aliases itself, we need to set
    # these values to be the same as the ones set for all shells.
    environmentVariables = config.home.sessionVariables;
    shellAliases = config.home.shellAliases;
    # Nushell file sourcing.
    extraConfig = ''
      source ~/.config/nushell/mutConfig.nu
    '';
  };

  #====<< Terminal programs >>=================================================>
  programs = {
    # Git version control.
    git = enabled // {
      userName  = gitUsername;
      userEmail = gitEmail;
    };
    # A "Post-modern terminal modal editor".
    helix = enabled // { defaultEditor = true; };
    # Terminal file manager.
    yazi = enableAllShells;
    # Customisable shell prompt.
    starship = enableAllShells // { useSubDir = true; };
    # Git terminal user interface
    lazygit = enabled;
  };

  #====<< Nix settings >>====================================================>
  # Since the regular `nix.gc` doesn't collect user profiles, all user
  # packages are left on the system (like running `sudo nix-collect-garbage`).
  # This sets it to also (your) user profiles.
  nix.gc = {
    automatic = true;
    frequency = "weekly";
    options   = "--delete-older-than 7d";
  };

};}
