;; Setup Melpa e use-package
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8-unix)
(setq locale-coding-system 'utf-8)

;; Custom File
(setq custom-file "~/.emacs.custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

;; General Setup
(use-package emacs
  :init

  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (scroll-bar-mode 0)
  (column-number-mode 1)
  (global-display-line-numbers-mode 1)

  (setq inhibit-startup-screen t
        tab-width 4
        indent-tabs-mode nil
        make-backup-files nil)


  ;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
  (add-to-list 'default-frame-alist '(font . "Iosevka Slab Extended-10"))

  ;; Whitespace handling
  :hook (prog-mode . (lambda ()
                       (whitespace-mode 1)
                       (add-hook 'before-save-hook
                                 'delete-trailing-whitespace nil t))))

(use-package modus-themes
  :config
  (modus-themes-load-theme 'modus-vivendi-tinted))

(use-package smex
  :bind ("M-x" . smex))

(use-package ido
  :ensure nil ;;  built-in
  :init
  (ido-mode 1)
  :custom
  (ido-everywhere t))

(use-package ido-completing-read+
  :after ido
  :config
  (ido-ubiquitous-mode 1))

(use-package company
  :hook (after-init . global-company-mode))

(use-package elcord
  :config
  (elcord-mode 1))

(use-package web-mode
  :mode "\\.html?\\'"
  :custom
  (web-mode-markup-indent-offset 4)
  (web-mode-css-indent-offset 4)
  (web-mode-code-indent-offset 4))

(use-package emmet-mode
  :hook (web-mode . emmet-mode))

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode) ;; GitHub Flavored Markdown for README
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package typescript-mode
  :mode "\\.ts\\'"
  :custom
  (typescript-indent-level 4))

(use-package php-mode
  :mode "\\.php\\'"
  :mode "\\.inc\\'")

(use-package company-php
  :after (php-mode company)
  :hook (php-mode . (lambda ()
                      (add-to-list (make-local-variable 'company-backends)
                                   'company-ac-php-backend))))
