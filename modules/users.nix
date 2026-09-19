{ pkgs, ... }: {
  users.users.francesco = {
    isNormalUser = true;
    description = "francesco";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

}
