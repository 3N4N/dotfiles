;   ___ _ __ ___   __ _  ___ ___
;  / _ \ '_ ` _ \ / _` |/ __/ __|
; |  __/ | | | | | (_| | (__\__ \
;  \___|_| |_| |_|\__,_|\___|___/

;;; Introduction

(setq user-full-name "Nafid Ajmain Enan")
(setq user-mail-address "3nanajmain@gmail.com")

;;; emacs package

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

;;; Interface tweaks

(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)
(fset 'yes-or-no-p 'y-or-n-p)
(menu-bar-mode 1)
(scroll-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(blink-cursor-mode 0)
(linum-mode 0)
(show-paren-mode)
(column-number-mode t)
(global-hl-line-mode 0)
(global-auto-revert-mode 1)
(electric-pair-mode t)
(winner-mode t)
;; (mouse-avoidance-mode 'banish)
(if (window-system)
    (progn
      (set-frame-size (selected-frame) 91 41)
      (set-frame-position (selected-frame) 700 0)
      (set-frame-font "Source code pro for powerline 9")))

(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)

(setq backup-directory-alist '(("." . "~/.emacs.d/backup")))

;;; Theme settings

(use-package material-theme
  :ensure t
  :config
  (load-theme 'material t))

;;; Mode line

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (setq powerline-default-separator 'slant)
  (spaceline-spacemacs-theme))

;;; Key mapping
(global-set-key (kbd "M-v") (lambda () (interactive) (scroll-down 2)))
(global-set-key (kbd "C-v") (lambda () (interactive) (scroll-up 2)))

;;; Indentation settings

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;;; Packages

;; (use-package evil
;;   :ensure t
;;   :config
;;   (evil-mode 1)
;;   (define-key evil-insert-state-map "jj" 'evil-normal-state))

(use-package diminish
  :ensure t
  :init
  (diminish 'auto-revert-mode))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'lisp-mode-hook (lambda () (rainbow-delimiters-mode)))
  (add-hook 'emacs-lisp-mode-hook (lambda () (rainbow-delimiters-mode))))

(use-package eyebrowse
  :ensure t
  :config (progn
            (define-key eyebrowse-mode-map (kbd "M-1") 'eyebrowse-switch-to-window-config-1)
            (define-key eyebrowse-mode-map (kbd "M-2") 'eyebrowse-switch-to-window-config-2)
            (define-key eyebrowse-mode-map (kbd "M-3") 'eyebrowse-switch-to-window-config-3)
            (define-key eyebrowse-mode-map (kbd "M-4") 'eyebrowse-switch-to-window-config-4)
            (eyebrowse-mode t)
            (setq eyebrowse-new-workspace t)))

(use-package ace-window
  :ensure t
  :init
  (global-set-key [remap other-window] 'ace-window)
  (custom-set-faces
   '(aw-leading-char-face
     ((t (:inherit ace-jump-face-foreground :height 2.0))))))

(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "%d/%d ")
  (setq ivy-display-style 'fancy))

(use-package counsel
  :ensure t
  :bind
  (("M-x" . counsel-M-x)
   ("M-y" . counsel-yank-pop)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line)))

(use-package swiper
  :ensure try
  :bind (("C-s" . swiper)
         ("C-r" . swiper)
         ("C-c C-r" . ivy-resume)
         ("C-x C-f". counsel-find-file))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy)
  (define-key read-expression-map (kbd "C-r") 'counsel-expression-history))

(use-package avy
  :ensure t
  :bind (("M-s" . avy-goto-word-1))
  :config
  (avy-setup-default))

(use-package company
  :ensure t
  :bind (("C-c /". company-complete))
  :config
  (global-company-mode))

(use-package magit
  :ensure t
  :init (bind-key "C-x g" 'magit-status))

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t)
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  :config
  (use-package yasnippet-snippets
    :ensure t)
  (yas-reload-all))

(use-package hungry-delete
  :ensure t
  :diminish hungry-delete-mode
  :config
  (global-hungry-delete-mode))

(use-package beacon
  :ensure t
  :disabled t
  :diminish beacon-mode
  :init
  (beacon-mode 1)
  :config
  (add-to-list 'beacon-dont-blink-major-modes 'eshell-mode))
(defvar show-paren-delay 0)
