;; Configuración para Emacs de Francesc Arpi
;; TODO: Falta añadir url de GitHub
(custom-set-variables
)

(custom-set-faces
)

;; Carpetas que contienen paquetes...
(add-to-list 'load-path "~/.emacs.d/paquetes/")

;; Cargamos thema visual
(load-theme 'deeper-blue t)

;; Mostramos número de columna
(column-number-mode t)

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

;; Paquete para less y css
(require 'less-css-mode)

;; Paquete Pony-Mode. Son paquetes para Django. Colorido en plantillas, snippets, etc.
(add-to-list 'load-path "~/.emacs.d/paquetes/pony-mode/")
(require 'pony-mode)

;; Emacs For Python. Conjunto de librerías para trabajar con Python
(load-file "~/.emacs.d/paquetes/emacs-for-python/epy-init.el")


