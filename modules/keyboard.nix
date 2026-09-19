{ pkgs, ... }: {
  services.udev.packages = [ pkgs.vial ];
  hardware.keyboard.qmk.enable = true;
  environment.systemPackages = with pkgs; [ vial qmk ];
}
