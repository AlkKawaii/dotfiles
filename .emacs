(setq custom-file "~/.emacs.custom.el")

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(font . "Iosevka Slab Extended-10"))

;; General Setup
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(global-display-line-numbers-mode 1)

(setq-default inhibit-startup-screen t
              tab-width 4
              indent-tabs-mode nil
              make-backup-files nil)

;; Set Encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

(setq-default buffer-file-coding-system 'utf-8-unix)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)

;; Processos externos (git, shell, etc)
(setq locale-coding-system 'utf-8)

;; Elcord Setup
(require 'elcord)
(elcord-mode 1)

;; Auto Complete Setup
(require 'ido-completing-read+)
(require 'smex)

(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

(global-company-mode 1)

(global-set-key (kbd "M-x") 'smex)

;; Theme Setup
(require-theme 'modus-themes)
(modus-themes-load-theme 'modus-vivendi-tinted)

;; Whitespace handling
(defun handle-whitespace ()
  (interactive)
  (whitespace-mode 1)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))

(add-hook 'prog-mode-hook 'handle-whitespace)

(load-file custom-file)

;; Web Setup

(require 'web-mode)
(require 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
