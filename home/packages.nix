{ pkgs, ... }: {
  home.packages = with pkgs; [
    # apps
    firefox thunderbird vesktop gimp
    onlyoffice-desktopeditors bitwarden-desktop syncthingtray
    kitty gnome-pomodoro

    loupe          # images
    papers         # PDFs
    celluloid      # video
    ffmpegthumbnailer
    nautilus

    # sway ecosystem
    swaylock swayidle swaybg wofi mako grim slurp
    wl-clipboard cliphist pamixer playerctl libnotify
    pavucontrol bluetui

    # misc
    tealdeer xdg-user-dirs
  ];
}
