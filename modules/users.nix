{ pkgs, ... }: {
  users.users.francesco = {
    isNormalUser = true;
    description = "francesco";
    extraGroups = [ "networkmanager" "wheel" "librepods" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

}
