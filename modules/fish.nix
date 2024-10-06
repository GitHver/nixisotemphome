{ pkgs
, ...
}:

{
  #====<< Bash setup >>========================================================>
  programs.bash.enable = true;
  # This makes it so that Fish is started in shell initialization.
  programs.bash.initExtra = ''
    unset __HM_SESS_VARS_SOURCED ; . .profile
    if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    fi
  '';
  programs.fish = {
    enable = true;
    #====<< Shell abbriviations >>=============================================>
    shellAbbrs = {
      s = "sudo";
      S = "sudo -E";
      yz = "yazi";
      el = "eza -l";
      ela = "eza -la";
      elas = "eza -las type";
      elt = "eza -lTs type";
      elat = "eza -laTs type";
      zn = "z ~/Nix/nixos-system";
      zh = "z ~/Nix/home-manager";
      zp = "z ~/Nix/packages";
      #==<< NixOS abbriviations >>=====>
      no   = "nix os";
      nos  = "nix os switch";
      nor  = "nix os rollback";
      nob  = "nix os build";
      nobt = "nix os boot";
      not  = "nix os test";
      # nix flake update system
      nfus = "nix flake update /etc/nixos";
      nou  = "nix os upgrade";
      #==<< Home-manager abbrs >>======>
      nh   = "nix home";
      nhs  = "nix home switch";
      nhb  = "nix home build";
      nhg  = "nix home generations";
      nhxg = "nix home expire-generations 1d";
      nhrg = "nix home remove-generations";
      # nix flake update home
      nfuh = "nix flake update ~/.config/home-manager";
      nhu  = "nix home upgrade";
      #==<< Nix misc abbr >>===========>
      nfu  = "nix flake update";
      nsh  = "nix shell nixpkgs#";
      ncg  = "nix-collect-garbage -d";
      ncgo = "sudo nix-collect-garbage --delete-older-than";
      nsgc = "nix store gc";
      nso  = "nix store optimise";
      #==<< Git abbriviations >>=======>
      gu  = "gitui";
      ga = "git add .";
      gc = ''
        git add .
        git commit
      '';
      gp = ''
        git add .
        git commit
        git push
      '';
    };
    #====<< Shell functions >>=================================================>
    interactiveShellInit = /*fish*/''
      ${pkgs.nix-your-shell}/bin/nix-your-shell fish | source
      function fish_greeting
          echo Greetings $USER! The time is: (set_color yellow; date +%T; set_color normal)
      end

      # makes nixos-rebuild and home-manager available in the nix command
      function nix
          if [ "$argv[1]" = "os" ]
              if [ "$argv[2]" = "rollback" ]
                  command sudo nixos-rebuild --rollback switch
              else if [ "$argv[2]" = "upgrade" ]
                  command sudo nix flake update /etc/nixos
                  command sudo nixos-rebuild switch
              else
                  command sudo nixos-rebuild $argv[2..-1] #&| nom
              end
          else if [ "$argv[1]" = "home" ]
              if [ "$argv[2]" = "upgrade" ]
                  command nix flake update ~/.config/home-manager
                  command home-manager switch
              else
                  command home-manager $argv[2..-1] #&| nom
              end
          else
              command nix $argv
          end
      end

      # completions for nix command to include 'os' & 'home'
      function __fish_nix_needs_command
        set cmd (commandline -opc)
        if [ (count $cmd) -eq 1 -a $cmd[1] = 'nix' ]
          return 0
        end
        return 1
      end

      function __fish_nix_using_command
        set cmd (commandline -opc)
        if [ (count $cmd) -gt 1 ]
          if [ $argv[1] = $cmd[2] ]
            return 0
          end
        end
        return 1
      end

      complete -f -c nix -n '__fish_nix_needs_command' -a home
      complete -f -c nix -n '__fish_nix_using_command home' -a '
          build expire-generations generations help instantiate news option
          packages remove-generations upgrade'

      complete -f -c nix -n '__fish_nix_needs_command' -a os
      complete -f -c nix -n '__fish_nix_using_command os' -a '
          boot build build-vm build-vm-with-bootloader dry-activate dry-build
          list-generations repl rollback switch test upgrade'
    '';
  };
}
