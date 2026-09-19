{ pkgs, ... }: {
  home.packages = with pkgs; [
    # apps
    firefox thunderbird vesktop gimp
    onlyoffice-desktopeditors bitwarden-desktop syncthingtray
    kitty foot

    # replacements for the KDE apps
    loupe          # images (was Gwenview)
    papers         # PDFs (was Okular)
    celluloid      # video, mpv frontend (was Haruna)
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
