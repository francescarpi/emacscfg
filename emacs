;; Configuración para Emacs de Francesc Arpi
;; https://github.com/francescarpi/emacscfg

(custom-set-variables
)

(custom-set-faces
)

;; Carpetas que contienen paquetes...
(add-to-list 'load-path "~/.emacs.d/paquetes/")
(add-to-list 'load-path "~/.emacs.d/paquetes/pony-mode/")
(add-to-list 'load-path "~/.emacs.d/paquetes/helm/")

;; Cargamos thema visual
(load-theme 'deeper-blue t)

;; Quitamos toolbar
(tool-bar-mode -1)

;; Mostramos número de columna y número de linea
(column-number-mode t)
(global-linum-mode 1)

;; Paquete de Markdown
(autoload 'markdown-mode "markdown-mode" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Combinaciones de teclas adicionales
(global-set-key (kbd "C-c <right>") 'comment-region)      ; Comenta bloque de código
(global-set-key (kbd "C-c <left>") 'uncomment-region)     ; Descomenta bloque de código
(global-set-key (kbd "C-x x <right>") 'windmove-right)    ; Ir a la ventana de la derecha
(global-set-key (kbd "C-x x <down>") 'windmove-down)      ; Ir a la ventana de abajo
(global-set-key (kbd "C-x x <left>") 'windmove-left)      ; Ir a la ventana de la izquierda
(global-set-key (kbd "C-x x <up>") 'windmove-up)          ; Ir a la ventana de arriba

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
(setq mweb-tags '((js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
                  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq mweb-filename-extensions '("htm" "html"))
(multi-web-global-mode 1)

;; Carga de snippets mios
(setq yas/root-directory "~/.emacs.d/paquetes/mis-snippets")
(yas/load-directory yas/root-directory)

;; Dired+. Damos más funcionalidades al Dired Mode
(require 'dired+)

;; Helm. Paquete muy extenso que brinda un montón de funcionalidades a Emcas.
;; Aquí una wiki: https://github.com/emacs-helm/helm/wiki
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; Desactivamos la creación de un fichero backup para cada fichero
;; que estamos editando
(setq make-backup-file nil)





