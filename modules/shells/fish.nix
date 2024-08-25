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
      ez = "eza -la";
      zn = "z /etc/nixos";

      ga = "git add .";
      gc = "git commit";
      Sga = "sudo -E git add .";
      Sgc = "sudo -E git commit";
    };
  };

  # programs.zoxide.enableFishIntegration = true;
  # programs.zellij.enableFishIntegration = true;
  # programs.starship.enableFishIntegration = true;
  # programs.fzf.enableFishIntegration = true;
  # programs.eza.enableFishIntegration = true;
  # programs.yazi.enableFishIntegration = true;
  
}
