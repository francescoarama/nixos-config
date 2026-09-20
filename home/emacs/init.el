;;; init.el --- personal config -*- lexical-binding: t; -*-

;; ---------- Basics ----------
(setq inhibit-startup-screen t
      ring-bell-function #'ignore
      use-short-answers t
      make-backup-files nil          ; git is the backup
      create-lockfiles nil           ; avoids clutter with Syncthing
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
      custom-file (locate-user-emacs-file "custom.el")
      scroll-margin 5)
(load custom-file 'noerror)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font-11"))

(setq-default indent-tabs-mode nil
              display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(global-auto-revert-mode 1)
(recentf-mode 1)
(savehist-mode 1)
(save-place-mode 1)
(electric-pair-mode 1)
(pixel-scroll-precision-mode 1)

;; ---------- Theme ----------
(use-package doom-themes
  :config
  (load-theme 'doom-one t)           ; try doom-tokyo-night, doom-gruvbox, doom-nord
  (doom-themes-org-config))
(use-package nerd-icons)
(use-package doom-modeline :init (doom-modeline-mode 1))

;; ---------- Evil (vim bindings) ----------
(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil     ; required by evil-collection
        evil-want-C-u-scroll t
        evil-want-C-i-jump nil
        evil-undo-system 'undo-redo
        evil-split-window-below t
        evil-vsplit-window-right t)
  :config (evil-mode 1))
(use-package evil-collection :after evil :config (evil-collection-init))
(use-package evil-surround :after evil :config (global-evil-surround-mode 1))
(use-package evil-commentary :after evil :config (evil-commentary-mode 1)) ; gcc

(use-package which-key
  :custom (which-key-idle-delay 0.4)
  :init (which-key-mode 1))

;; ---------- Leader key (SPC), like your nvim leader ----------
(use-package general
  :after evil
  :config
  (general-create-definer my/leader
    :states '(normal visual motion)
    :keymaps 'override
    :prefix "SPC")
  (my/leader
    "SPC" '(execute-extended-command :which-key "M-x")
    "."   '(find-file :which-key "open file")
    ","   '(consult-buffer :which-key "switch buffer")
    "/"   '(consult-ripgrep :which-key "grep project")

    "b"  '(:ignore t :which-key "buffer")
    "bb" '(consult-buffer :which-key "switch")
    "bk" '(kill-current-buffer :which-key "kill")

    "f"  '(:ignore t :which-key "file")
    "ff" '(find-file :which-key "find")
    "fr" '(consult-recent-file :which-key "recent")
    "fs" '(save-buffer :which-key "save")
    "fd" '(dired-jump :which-key "dired here")

    "p"  '(:ignore t :which-key "project")
    "pp" '(project-switch-project :which-key "switch")
    "pf" '(project-find-file :which-key "find file")

    "g"  '(:ignore t :which-key "git")
    "gg" '(magit-status :which-key "magit")

    "c"  '(:ignore t :which-key "code")
    "ca" '(eglot-code-actions :which-key "actions")
    "cr" '(eglot-rename :which-key "rename")
    "cf" '(eglot-format :which-key "format")
    "cd" '(flymake-show-buffer-diagnostics :which-key "diagnostics")

    "o"  '(:ignore t :which-key "org")
    "oa" '(org-agenda :which-key "agenda")
    "oc" '(org-capture :which-key "capture")

    "n"  '(:ignore t :which-key "notes")
    "nf" '(org-roam-node-find :which-key "find note")
    "ni" '(org-roam-node-insert :which-key "insert link")

    "t"  '(:ignore t :which-key "toggle")
    "tt" '(vterm :which-key "terminal")
    "tz" '(olivetti-mode :which-key "focus mode")
    "ts" '(flyspell-mode :which-key "spellcheck")

    "w" evil-window-map                 ; SPC w v / s / h / j / k / l / c
    "h" '(help-command :which-key "help")))

;; ---------- Completion ----------
(use-package vertico
  :bind (:map vertico-map ("C-j" . vertico-next) ("C-k" . vertico-previous))
  :init (vertico-mode 1))
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))
(use-package marginalia :init (marginalia-mode 1))
(use-package consult)
(use-package corfu
  :custom (corfu-auto t) (corfu-auto-delay 0.2) (corfu-auto-prefix 2)
  :bind (:map corfu-map ("C-j" . corfu-next) ("C-k" . corfu-previous))
  :init (global-corfu-mode 1))

;; ---------- Programming: tree-sitter + LSP (both built in) ----------
(setq major-mode-remap-alist
      '((python-mode . python-ts-mode)
        (java-mode . java-ts-mode)
        (c-mode . c-ts-mode)
        (c++-mode . c++-ts-mode)))
(add-hook 'python-ts-mode-hook #'eglot-ensure)
(add-hook 'java-ts-mode-hook #'eglot-ensure)
(add-hook 'nix-mode-hook #'eglot-ensure)
(add-hook 'prog-mode-hook #'flyspell-prog-mode)   ; spellcheck comments only

;; ---------- Git ----------
(use-package magit :defer t)

;; ---------- Org: notes, todos, homework ----------
(use-package org
  :custom
  (org-directory "~/org")
  (org-agenda-files '("~/org/"))
  (org-todo-keywords '((sequence "TODO(t)" "DOING(d)" "|" "DONE(x)")))
  (org-log-done 'time)
  (org-startup-indented t)
  (org-hide-emphasis-markers t)
  (org-capture-templates
   '(("t" "Task" entry (file+headline "~/org/inbox.org" "Tasks")
      "* TODO %?\n  %U")
     ("h" "Homework" entry (file+headline "~/org/school.org" "Homework")
      "* TODO %? :homework:\n  DEADLINE: %^t")
     ("n" "Quick note" entry (file "~/org/inbox.org")
      "* %?\n  %U")))
  :hook (org-mode . visual-line-mode)
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t) (shell . t) (emacs-lisp . t))))

(use-package evil-org
  :after org
  :hook (org-mode . evil-org-mode)
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package org-modern
  :hook ((org-mode . org-modern-mode)
         (org-agenda-finalize . org-modern-agenda)))

(use-package org-roam
  :custom (org-roam-directory "~/org/roam")
  :config (org-roam-db-autosync-mode 1))

;; ---------- Study tools ----------
(use-package olivetti :custom (olivetti-body-width 90))
(use-package pdf-tools :config (pdf-loader-install))   ; read PDFs inside Emacs
(use-package vterm :commands vterm)
(add-hook 'text-mode-hook #'flyspell-mode)
(setq ispell-program-name "aspell"
      ispell-dictionary "en_US")   ; switch with M-x ispell-change-dictionary (it)
