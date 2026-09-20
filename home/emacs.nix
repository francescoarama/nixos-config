{ config, pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;

    extraPackages = epkgs: with epkgs; [
      # vim layer
      evil evil-collection evil-surround evil-commentary evil-org
      general which-key

      # looks
      doom-themes doom-modeline nerd-icons org-modern olivetti

      # completion (the modern stack, replaces Telescope/cmp)
      vertico orderless marginalia consult corfu

      # tools
      magit vterm pdf-tools nix-mode org-roam
      treesit-grammars.with-all-grammars
    ];
  };

  # init.el stays in your repo and is symlinked to its real location,
  # so edits apply without a rebuild (unlike a normal read-only HM file)
  xdg.configFile."emacs/init.el".source =
    config.lib.file.mkOutOfStoreSymlink
      "${config.home.homeDirectory}/nixos/home/emacs/init.el";

  home.packages = with pkgs; [
    # language servers and tools used by Emacs
    pyright jdt-language-server jdk nil
    (aspellWithDicts (d: with d; [ en it ]))   # spell check, English + Italian
  ];
}
