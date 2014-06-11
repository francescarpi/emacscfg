;; Configuración para Emacs de Francesc Arpi
;; https://github.com/francescarpi/emacscfg

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-boring-file-regexp-list (quote ("\\.git$" "\\.hg$" "\\.svn$" "\\.CVS$" "\\._darcs$" "\\.la$" "\\.o$" "\\.pyc$" "~$" "\\.egg-info" "\\.egg-link")))
 '(helm-buffer-details-flag t)
 '(helm-buffer-max-length 20)
 '(helm-ff-skip-boring-files t)
 '(helm-truncate-lines nil)
 '(markdown-command "/usr/bin/pandoc"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Carpetas que contienen paquetes...
(add-to-list 'load-path "~/.emacs.d/paquetes/")
(add-to-list 'load-path "~/.emacs.d/paquetes/pony-mode/")
(add-to-list 'load-path "~/.emacs.d/paquetes/helm/")
(add-to-list 'load-path "~/.emacs.d/paquetes/monky/")
(add-to-list 'load-path "~/.emacs.d/paquetes/multiple-cursors.el/")
(add-to-list 'load-path "~/.emacs.d/paquetes/jabber/")
(add-to-list 'load-path "~/.emacs.d/paquetes/hamster/")

;; Cargamos thema visual
;(load-theme 'misterioso t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/paquetes/temas/")
(load-theme 'misterioso t)
;(load-theme 'naquadah t)

;; Quitamos toolbar
(tool-bar-mode -1)

;; Mostramos número de columna y número de linea
(column-number-mode t)
(global-linum-mode 1)

;; Desactivamos pantalla de inicio
(setq inhibit-startup-message t)

;; Paquete de Markdown
(autoload 'markdown-mode "markdown-mode" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;; Combinaciones de teclas adicionales
(global-set-key (kbd "C-c <right>") 'comment-region)      ; Comenta bloque de código
(global-set-key (kbd "C-c <left>") 'uncomment-region)     ; Descomenta bloque de código
(global-set-key (kbd "C-x x <right>") 'windmove-right)    ; Ir a la ventana de la derecha
(global-set-key (kbd "C-x x <down>") 'windmove-down)      ; Ir a la ventana de abajo
(global-set-key (kbd "C-x x <left>") 'windmove-left)      ; Ir a la ventana de la izquierda
(global-set-key (kbd "C-x x <up>") 'windmove-up)          ; Ir a la ventana de arriba
(global-set-key (kbd "C-<return>") 'goto-line)            ; Ir a linea

;; Activación de Emmet. Ayuda en la construcción de código Html
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)
(setq emmet-move-cursor-between-quotes t)
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; identación 2 espacios


;; Paquete para less y css
(require 'less-css-mode)

;; Paquete Pony-Mode. Son paquetes para Django. Colorido en plantillas, snippets, etc.
(require 'pony-mode)

;; Emacs For Python. Conjunto de librerías para trabajar con Python
(load-file "~/.emacs.d/paquetes/emacs-for-python/epy-init.el")

;; Multi Web Mode es un paquete que nos brinda colorida al javascript y css dentro de un html
(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags '((js-mode "<script[^>]*>\\|{% block onready %}" "</script>\\|{% endblock onready %}")
                  (css-mode "<style[^>]*>" "</style>")
))
(setq mweb-filename-extensions '("htm" "html"))
(multi-web-global-mode 1)

;; Carga de snippets mios
(setq yas/root-directory "~/.emacs.d/paquetes/mis-snippets")
(yas/load-directory yas/root-directory)
(add-hook 'js-mode-hook 'yas/minor-mode)

;; Desactivamos la creación de un fichero backup para cada fichero
;; que estamos editando
(setq make-backup-files nil)

;; Lua
(require 'lua-mode)

;; Monky. Paquete para mercurial
(require 'monky)
(setq monky-process-type 'cmdserver)
(global-set-key (kbd "M-n") 'monky-status)

;; Multiple-curosr. Permite selección múltiple
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Helm. Paquete muy extenso que brinda un montón de funcionalidades a Emcas.
;; Aquí una wiki: https://github.com/emacs-helm/helm/wiki
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "C-x C-f") 'helm-find-files) ; Substituimos el gestor de ficheros
(global-set-key (kbd "C-x C-b") 'helm-buffers-list) ; Substituimos la ventana de bufers
(global-set-key (kbd "C-c C-j") 'helm-imenu)
(setq helm-grep-default-command "grep -R -n%cH -e %p *")
(defcustom helm-boring-file-regexp-list
  '("\\.git$" "\\.hg$" "\\.svn$" "\\.CVS$" "\\._darcs$" "\\.la$" "\\.o$" "~$" "\\.pyc$")
  "The regexp list matching boring files."
  :group 'helm-files
  :type '(repeat (choice regexp)))


;; Minimap
(require 'minimap)

;; Undo tree
(require 'undo-tree)
(global-undo-tree-mode)

;; Ini filesn
(require 'any-ini-mode)

;; Añado acciones para acceder a la carpeta del sitepackages del entorno
;; seleccionado o a la carpeta raíz del entorno
(require 'virtualenv)
(defun cdsitepackages (name)
  (interactive (list (completing-read "Virtualenv: " (virtualenv-workon-complete))))
  (setq path (concat (getenv "WORKON_HOME") "/" name "/lib/python2.7/site-packages/"))
  (helm-find-files-1 path)
  )
 
(defun cdvirtualenv (name)
  (interactive (list (completing-read "Virtualenv: " (virtualenv-workon-complete))))
  (setq path (concat (getenv "WORKON_HOME") "/" name "/"))
  (helm-find-files-1 path)
  )

;; Jabber
(require 'jabber)
(setq jabber-vcard-avatars-retrieve nil)

(defun send-message-dbus (msg)
  (if *jabber-connected*
      (call-process-shell-command (format "notify-send -u critical -t 5000 -i /usr/share/icons/gnome/24x24/status/user-available.png \"Missatge de Jabber\" \"%s\"" msg))))

(defun jabber-notify-dbus(from buffer text prosed-alert)
  (send-message-dbus text))

(add-hook 'jabber-alert-message-hooks 'jabber-notify-dbus)


;; Plugin de hamster. Creación propia
(require 'hamster)
(hamster-mode 1)

