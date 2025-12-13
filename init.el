;;; General Emacs Settings
(use-package emacs
  :config
  (load-theme 'modus-vivendi)
  (set-frame-font "Monospace 12" nil t)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (tooltip-mode -1)
  (display-time)
  (display-battery-mode)
  (defun my/indent-buffer ()
    "Indent the contents of a buffer."
    (interactive)
    (indent-region (point-min) (point-max)))
  :custom
  (custom-file (expand-file-name "custom.el" user-emacs-directory))
  (display-time-format "%H:%M %a %d/%m")
  (display-time-default-load-average 'nil)
  (inhibit-startup-screen t)
  (use-short-answers t)
  (auto-save-visited-mode t)
  (disabled-command-function nil)
  (completion-styles '(initials flex partial-completion))
  (package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
  (use-package-enable-imenu-support t)
  :bind
  ("M-i" . my/indent-buffer)
  ("C-;" . comment-line)
  ("C-z" . zap-up-to-char))

;;; Outline
(use-package outline
  :custom
  (outline-minor-mode-cycle t)
  :hook
  (emacs-lisp-mode . outline-minor-mode))

;;; Icomplete
(use-package icomplete
  :custom
  (fido-vertical-mode t)
  (icomplete-compute-delay 0)
  :bind (:map icomplete-fido-mode-map
	      ("<tab>" . icomplete-forward-completions)
	      ("<backtab>" . icomplete-backward-completions)
	      ("M-j" . exit-minibuffer)))

;;; Line Numbers
(use-package display-line-numbers
  :config
  (setq display-line-numbers 'relative)
  :hook
  (prog-mode . display-line-numbers-mode)
  (sh-script-mode . display-line-numbers-mode))

;;; Org
(use-package org
  :custom
  (org-use-speed-commands t))

;;; Dired
(use-package dired
  :custom
  (delete-by-moving-to-trash t)
  :config
  (defun my/dired-up-directory ()
    (interactive)
    (find-alternate-file ".."))
  :bind (:map dired-mode-map
	      ("b" . my/dired-up-directory)
	      ("f" . 'dired-find-alternate-file)))

;;; Recentf
(use-package recentf
  :bind
  ("C-c r" . recentf))

;;; Which Key
(use-package which-key
  :config (which-key-mode))

;;; Nix Mode
(use-package nix-mode :ensure)

;;; Whitespace
(use-package whitepace
  :hook
  (before-save . whitespace-cleanup))

;;; Code Completion
;;;; Eglot
(use-package eglot
  :hook
  (prog-mode . eglot-ensure))

;;;; Corfu
(use-package corfu :ensure
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  :hook
  (prog-mode . corfu-mode))

;;; Git
;;;; Magit
(use-package magit :ensure
  :bind*
  ("C-x g" . magit-status))
;;;; Timemachine
(use-package git-timemachine :ensure)
