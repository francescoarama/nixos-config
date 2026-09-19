{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wget curl git unzip
    neovim tmux lazygit tree-sitter
    gcc gnumake cmake
    fzf ripgrep fd
    emacs fastfetch tree
  ];
}
