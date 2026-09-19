{ ... }: {
  imports = [ ./packages.nix ./gtk.nix ];

  home.username = "francesco";
  home.homeDirectory = "/home/francesco";
  home.stateVersion = "26.05";
}
