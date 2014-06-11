;; Autor: Francesc Arpi

; TODO: Path del script...

(defun hamster-muestra-tarea-actual()
  (setq global-mode-string (propertize (shell-command-to-string 
					"~/Aplicaciones/emacscfg/paquetes/hamster/hamster_utils.py") 
				       'face '(:foreground "deep sky blue"))))

(define-minor-mode hamster-mode
  "Modo Hamster. Gestor de Tareas"
  nil nil nil nil
  (run-at-time "0 sec" 10 'hamster-muestra-tarea-actual)
)

(defun hamster-fixes()
  (interactive)
  (insert (shell-command-to-string 
	    "~/Aplicaciones/emacscfg/paquetes/hamster/hamster_utils.py --fixes")))

(defun hamster-refs()
  (interactive)
  (insert (shell-command-to-string 
	    "~/Aplicaciones/emacscfg/paquetes/hamster/hamster_utils.py --refs")))

(defun hamster-parar-tarea-actual()
  (interactive)
  (shell-command-to-string "~/Aplicaciones/emacscfg/paquetes/hamster/hamster_utils.py --parar")
  (hamster-muestra-tarea-actual))

(defun hamster-nueva-tarea(desc)
  (interactive "MNueva tarea: ")
  (shell-command-to-string (format "~/Aplicaciones/emacscfg/paquetes/hamster/hamster_utils.py --nueva \"%s\"" desc))
  (hamster-muestra-tarea-actual))


(defun hamster-nueva-tarea-antigua(desc)
  (interactive "MNueva tarea: ")
  (shell-command-to-string (format "~/Aplicaciones/emacscfg/paquetes/hamster/hamster_utils.py --nuevaantigua \"%s\"" desc))
  (hamster-muestra-tarea-actual))


(provide 'hamster)
