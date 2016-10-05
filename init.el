;;; init.el -- My Emacs configuration
;-*-Emacs-Lisp-*-

;; Personal data
(setq user-full-name "Francesc Arpi")
(setq user-mail-address "francesc.arpi@gmail.com")

;; Environment
(setenv "PATH" (concat "/usr/local/bin:/opt/local/bin:/usr/bin:/bin" (getenv "PATH")))
(require 'cl)

;; Package system
(load "package")
(package-initialize)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("elpy" . "https://jorgenschaefer.github.io/packages/"))

(setq package-archive-enable-alist '(("melpa" deft magit)))

(defvar farpi/packages '(ac-slime
                auto-complete
                autopair
                deft
                feature-mode
                flycheck
                htmlize
                magit
                markdown-mode
                marmalade
                nodejs-repl
                org
                paredit
		powerline
                restclient
                smex
                web-mode
                writegood-mode
                yaml-mode)
  "Default packages")

(defun farpi/packages-installed-p ()
  (loop for pkg in farpi/packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

(unless (farpi/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg farpi/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;; Splash screen
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

;; Theme
(load-theme 'wombat t)

;; Scroll bar, tool bar, menu bar
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Marking text
(delete-selection-mode t)
(transient-mark-mode t)
(setq x-select-enable-clipboard t)

;; Powerline
(powerline-default-theme)

;; Added by emacsus
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yaml-mode writegood-mode web-mode solarized-theme smex restclient paredit nodejs-repl marmalade markdown-mode magit htmlize flycheck feature-mode deft autopair ac-slime))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
