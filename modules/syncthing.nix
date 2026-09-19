{ ... }: {
  services.syncthing = {
    enable = true;
    user = "francesco";
    dataDir = "/home/francesco";
    configDir = "/home/francesco/.config/syncthing";
    guiAddress = "127.0.0.1:8384";
  };
}
