{ ... }: {
  imports = [
  ./packages.nix 
  ./gtk.nix
  ./zsh.nix
  ./starship.nix
  ./foot.nix
  ./obs.nix
  ];

  home.username = "francesco";
  home.homeDirectory = "/home/francesco";
  home.stateVersion = "26.05";
}
