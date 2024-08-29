{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fish
  ];

  programs.fish = {
    enable = true;
    shellInitLast = ''
      function fish_greeting
          echo Greetings $USER! The time is: (set_color yellow; date +%T; set_color normal)
      end
      starship init fish | source
      zoxide init fish | source
    ''; # eval (zellij setup --generate-auto-start fish | string collect)
    shellAbbrs = {
      s = "sudo";
      S = "sudo -E";
      yy = "yazi";
      Syy = "sudo -E yazi";
      ez = "eza -la";
      zn = "z /etc/nixos";

      ga = "git add .";
      gc = "git commit";
      Sga = "sudo -E git add .";
      Sgc = "sudo -E git commit";
    };
    shellAliases = {
      ssh1 = ''
        echo '
        copy the following and replace it with your email and then run it

        ssh-keygen -t ed25519 -C "your@email.host"'
      '';
      ssh2 =''
        echo '
        copy the below and pasrte it into the next step
  
        Host *
          AddKeysToAgent yes
          IdentityFile ~/.ssh/id_ed25519'
      '';
      ssh3 = ''
        touch ~/.ssh/config
        $EDITOR ~/.ssh/config
      '';
      ssh4 = ''
        ssh-add ~/.ssh/id_ed25519
        cat ~/.ssh/id_ed25519.pub
      '';
    };
  };

  # programs.zoxide.enableFishIntegration = true;
  # programs.zellij.enableFishIntegration = true;
  # programs.starship.enableFishIntegration = true;
  # programs.fzf.enableFishIntegration = true;
  # programs.eza.enableFishIntegration = true;
  # programs.yazi.enableFishIntegration = true;
  
}
