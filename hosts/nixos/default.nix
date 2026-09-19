{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nvidia.nix
    ../../modules/desktop.nix
    ../../modules/audio.nix
    ../../modules/networking.nix
    ../../modules/locale.nix
    ../../modules/users.nix
    ../../modules/keyboard.nix
    ../../modules/syncthing.nix
    ../../modules/packages.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";
}
