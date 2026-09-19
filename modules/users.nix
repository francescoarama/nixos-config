{ pkgs, ... }: {
  users.users.francesco = {
    isNormalUser = true;
    description = "francesco";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos#nixos";
    };

    shellInit = ''
      export EDITOR="nvim"
      export VISUAL="$EDITOR"
      export PATH="$HOME/.local/bin:$PATH"

      HISTSIZE=10000
      SAVEHIST=10000
      setopt HIST_IGNORE_DUPS
      setopt SHARE_HISTORY

      mkcd() {
        mkdir -p "$1" && cd "$1"
      }
    '';

    interactiveShellInit = ''
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      source ${pkgs.fzf}/share/fzf/completion.zsh
    '';
  };
}
