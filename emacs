;; Configuración para Emacs de Francesc Arpi
;; https://github.com/francescarpi/emacscfg

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(ansi-term-color-vector [unspecified "#000000" "#d54e53" "#afd75f" "#e7c547" "#5f87d7" "#af87d7" "#5f87d7" "#dadada"])
 '(custom-enabled-themes (quote (smart-mode-line-respectful)))
 '(custom-safe-themes (quote ("78d80c985e7ef0423017b767e7024f17085bcd948c5b23fbe51d8d3ce7191bcb" "37d0cdc1e79ae56cd1ea262dd6b84939fcc15d7977e320e2c7249c140aafc032" "8a1bb0702556a9cf0b9f0f01b8d3540deb70147d99d6ab1ca4d844875cf5b65e" "efd849c804148b88536914ccdee08285fd7376e2e3334522c9afc00fd7e594da" "60c9c0826f2ec9293425bdfebac988457a2fb64cc037ef5407b55b705cb847fb" "a9b91f3865f324bc78b164282aec551cd716f8243a3eca6ee65ec634f3d717e6" "a734af876472852cbc850f61e90bab0c35391c12a713852d286fdb37c2e5f545" "8052841ca206d67ca02235dfa37657acac0ce237193dbd6f34d6554a357e29ef" "c6fbc8c65a6f572cc4b01335a2c16c8c1a8308ced515e6ca04741aee18300849" "4e59bfe2e786d199b21540994d4c444fa5e6113527c45a722f272ed3ba6b9945" "eae93d3c2cbc9fe5f5a922d718002fd82625596b42e4fb05e714a77424313eb1" "025354235e98db5e7fd9c1a74622ff53ad31b7bde537d290ff68d85665213d85" "3a727bdc09a7a141e58925258b6e873c65ccf393b2240c51553098ca93957723" default)))
 '(fci-rule-character-color "#1c1c1c")
 '(fci-rule-color "#1c1c1c")
 '(helm-boring-file-regexp-list (quote ("\\.git$" "\\.hg$" "\\.svn$" "\\.CVS$" "\\._darcs$" "\\.la$" "\\.o$" "\\.pyc$" "~$" "\\.egg-info" "\\.egg-link")))
 '(helm-buffer-details-flag t)
 '(helm-buffer-max-length 20)
 '(helm-ff-skip-boring-files t)
 '(helm-truncate-lines nil)
 '(markdown-command "/usr/bin/pandoc")
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "mail.apsl.net")
 '(smtpmail-smtp-service 25))

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
(add-to-list 'load-path "~/.emacs.d/paquetes/smart-mode-line/")
(add-to-list 'load-path "~/.emacs.d/paquetes/dash.el/")

;; Cargamos thema visual
;(load-theme 'misterioso t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/paquetes/temas/")
;(load-theme 'misterioso t)
(load-theme 'tomorrow-night-paradise t)
;(load-theme ' t)

;; Quitamos toolbar
(tool-bar-mode -1)
(menu-bar-mode -1)

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
(global-set-key (kbd "C-<right>") 'comment-region)      ; Comenta bloque de código
(global-set-key (kbd "C-<left>") 'uncomment-region)     ; Descomenta bloque de código

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

;; Multiple-curosr. Permite selección múltiple
(add-to-list 'load-path "~/.emacs.d/paquetes/multiple-cursors.el/")
(require 'multiple-cursors)
(global-set-key (kbd "C-c n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c a") 'mc/mark-all-like-this)

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


(defun send-message-dbus (msg)
  (if *jabber-connected*
      (call-process-shell-command (format "notify-send -u critical -t 5000 -i /usr/share/icons/gnome/24x24/status/user-available.png \"Missatge de Jabber\" \"%s\"" msg))))

(defun jabber-notify-dbus(from buffer text prosed-alert)
  (send-message-dbus text))

(add-hook 'jabber-alert-message-hooks 'jabber-notify-dbus)

;; Para tener emoticonos en jabber
(require 'autosmiley)
(add-hook 'jabber-chat-mode-hook 'autosmiley-mode)

;; Plugin de hamster. Creación propia
(add-to-list 'load-path "~/.emacs.d/paquetes/hamster/")
(setq hamster-bd "/home/farpi/.local/share/hamster-applet/hamster.db")
(require 'hamster)
(hamster-mode 1)

(put 'upcase-region 'disabled nil)

;; go...
(defun my-go-mode-hook () 
  (add-hook 'before-save-hook 'gofmt-before-save) 
  (setq tab-width 4 indent-tabs-mode 1)) 
(add-hook 'go-mode-hook 'my-go-mode-hook) 

(put 'dired-find-alternate-file 'disabled nil)


;; Redefino función que muestra los detalles del helm buffer para cortar
;; el path. Me gusta tener ventanas divididas horizontalmente y cuando
;; tengo más de un fichero que se llama igual, y está en un path muy largo
;; no consigo distingirlos.
(defun helm-buffer--show-details (buf-name prefix help-echo
                                  size mode dir face1 face2
                                  proc details)
  (append
   (list
    (concat prefix
            (propertize buf-name 'face face1
                        'help-echo help-echo)))
   (and details
        (list size mode
              (propertize
               (if proc
                   (format "(%s %s in `%s')"
                           (process-name proc)
                           (process-status proc) dir)
                   (format ".../%s" (mapconcat 'identity (last(split-string dir "/") 3) "/")))
                          'face face2)))))


;; Smart Mode Line
(require 'dash)
(require 'smart-mode-line)
(sml/setup)
(sml/apply-theme 'respectful)

;; Desactivamos tecla de C-z para no minimizar emacs en caso accidental.
(global-unset-key (kbd "C-z"))

;; Plugin propio para mercurial
(add-to-list 'load-path "~/.emacs.d/paquetes/simplehg/")
(require 'simplehg)
(global-set-key (kbd "M-n") 'simplehg-status-buffer)

;; Php mode...
(require 'php-mode)

;; Colorea apertura y cierre de corchetes.
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)

;; Copy and paste between Emac instances                                          
(defun yank-to-clipboard()
  (interactive)
  (if (region-active-p)
      (progn 
	(shell-command-on-region (region-beginning) (region-end) "xsel -i -b")
	(message "Yanked region to clipboard")
	(deactivate-mark))
    (message "No region active; can't yank to clipboard!")))

(global-set-key [f8] 'yank-to-clipboard)

;; Json prety print
(defun beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
     "python -mjson.tool" (current-buffer) t)))


(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; Configuración para mutt
(defun mutt-mail-mode-hook ()
  (flush-lines "^\\(> \n\\)*> -- \n\\(\n?> .*\\)*")
  (not-modified)
  (mail-text)
  (goto-line 0)
  (newline)
  (goto-line 0)
  (flyspell-mode 1)
  (setq make-backup-files nil))

(or (assoc "mutt-" auto-mode-alist)
    (setq auto-mode-alist (cons '("/tmp/mutt.*" . mail-mode) auto-mode-alist)))
(add-hook 'mail-mode-hook 'mutt-mail-mode-hook)


;; Buffer move
(require 'buffer-move)
(global-set-key (kbd "<C-s-up>")     'buf-move-up)
(global-set-key (kbd "<C-s-down>")   'buf-move-down)
(global-set-key (kbd "<C-s-left>")   'buf-move-left)
(global-set-key (kbd "<C-s-right>")  'buf-move-right)

;; Virtual Env Wrapper
(require 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) ;; if you want eshell support
(setq venv-location "~/Entornos/")
