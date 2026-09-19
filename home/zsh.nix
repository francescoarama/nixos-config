
{ ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;      # note: singular here
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos#nixos";
    };

    history = {
      size = 10000;
      save = 10000;
      ignoreDups = true;
      share = true;
    };

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    initContent = ''
      mkcd() {
        mkdir -p "$1" && cd "$1"
      }
    '';
  };

  home.sessionPath = [ "$HOME/.local/bin" ];

  # replaces the two `source ...fzf...` lines
  programs.fzf.enable = true;
}
