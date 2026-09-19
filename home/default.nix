{ ... }: {
  imports = [
  ./packages.nix 
  ./gtk.nix
  ./zsh.nix
  ./starship.nix
  ./foot.nix
  ];

  home.username = "francesco";
  home.homeDirectory = "/home/francesco";
  home.stateVersion = "26.05";
}
