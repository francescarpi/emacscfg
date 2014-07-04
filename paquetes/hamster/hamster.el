;; Autor: Francesc Arpi
;; Versión 0.1
;; Plugin para gestionar tareas de hamster
;;
;; El plugin está muy enfocado a trabajar con redime.Le pongo un id de tarea, ejemplo
;; #12345 y la puedo ver en la barra de estado, junto con el tiempo transcurrido.
;;
;; Es necesario definir la variable hamster-bd en .emacs. Esta indica donde se encuentra
;; la base de datos sqlite de hasmter. Ejemplo:
;;
;; (setq hamster-bd "/home/<usuario>/.local/share/hamster-applet/hamster.db")

(setq query-tarea-activa "SELECT strftime('%s', 'now', 'localtime') - strftime('%s', facts.start_time), activities.name, facts.id FROM facts JOIN activities ON facts.activity_id = activities.id WHERE facts.end_time IS NULL ORDER BY facts.id desc LIMIT 1;")

(setq command-tarea-activa (concat "sqlite3 " hamster-bd " \"" query-tarea-activa "\""))

;; Ejecuta el comando sqlite lanzando la consulta que devuelve la tarea
;; actual
(defun hamster-rs-comando-query()
  (shell-command-to-string command-tarea-activa))

;; Devuelve el texto de sin tarea
(defun hamster-sin-tarea()
  " Sin tarea ")

;; Devuelve el texto de la trea activa
(defun hamster-texto-tarea()
  (setq rs-tarea-activa (substring (hamster-rs-comando-query) 0 -1))
  
  (setq rs-tarea-activa-split (split-string rs-tarea-activa "|"))
  
  (setq rs-tiempo-transcurrido (string-to-number (nth 0 rs-tarea-activa-split)))
  (setq rs-descripcion (nth 1 rs-tarea-activa-split))

  ;; El tiempo se imprime con el formato compatible con redmine
  (if (< rs-tiempo-transcurrido 3600)
      (format " %s @%dm " rs-descripcion (/ rs-tiempo-transcurrido 60))
      (format " %s @%dh%dm " rs-descripcion (/ rs-tiempo-transcurrido 3600) 
	    (% (/ rs-tiempo-transcurrido 60) 60)))
  )

;; Obtiene la tarea activa y prepara el string que colocamos en
;; la barra de estado
(defun hamster-tarea-activa()
  (if (equal (hamster-rs-comando-query) "")
    (hamster-sin-tarea)
    (hamster-texto-tarea)))

;; Mostramos la tarea activa, en la barra de estado, con el color indicado
(defun hamster-actualiza-barra-estado()
  (setq global-mode-string (propertize (hamster-tarea-activa)
				       'face '(:foreground "orange"))))

;; Aquí empieza todo. Cuando se activa este modo, el sistema empieza a imprimir
;; el tiempo y tarea transcurrida en la barra de estado
(define-minor-mode hamster-mode
  "Modo Hamster. Gestor de Tareas"
  nil nil nil nil
  (run-at-time "0 sec" 10 'hamster-actualiza-barra-estado))

;; Imprime una cadena compatible con rdmine para cerrar un tíquet
(defun hamster-fixes()
  (interactive)
  (insert (format "fixes%s" (hamster-tarea-activa))))

(defun hamster-refs()
  (interactive)
  (insert (format "refs%s" (hamster-tarea-activa))))

(defun sql-parar-tarea(idtarea)
  (setq command-parar-tarea (concat "sqlite3 " hamster-bd " \"UPDATE facts SET end_time = datetime('now', 'localtime') WHERE id = " idtarea "; \"")))

;; Acción para parar la tarea activa
(defun hamster-parar-tarea-actual()
  (interactive)
  (setq rs-tarea-activa (substring (hamster-rs-comando-query) 0 -1))
  (setq rs-tarea-activa-split (split-string rs-tarea-activa "|"))
  (setq rs-id-tarea (nth 2 rs-tarea-activa-split))
  (shell-command-to-string (sql-parar-tarea rs-id-tarea))
  (hamster-actualiza-barra-estado))

;; Cargamos la actividad de la base de datos. Por si ya existe...
(defun existe-actividad(desc)
  (setq cmd-existe-actividad (concat "sqlite3 " hamster-bd " \"SELECT id FROM activities WHERE name = '" desc "'; \""))
  (shell-command-to-string cmd-existe-actividad))

;; Creamos la actividad en base de datos y devolvemos ID
(defun crear-actividad(desc)
  (shell-command-to-string (concat "sqlite3 " hamster-bd " \"INSERT INTO activities(name, category_id, search_name) VALUES('" desc "', 1, '" desc "');\""))
  (obtiene-id-actividad (existe-actividad desc)))

;; Recibimos el id de actividad y lo preparamos
(defun obtiene-id-actividad(idact)
  (substring idact 0 -1))

;; Acción para crear una nueva tarea
(defun hamster-nueva-tarea(desc)
  (interactive "MNueva tarea: ")
  (setq id-actividad (existe-actividad desc))
  (if (equal id-actividad "")
      (setq id-actividad (crear-actividad desc))
      (setq id-actividad (obtiene-id-actividad id-actividad)))
  
  ;; Ya estamos preparados para realizar la inserción
  (shell-command-to-string (concat "sqlite3 " hamster-bd " \"INSERT INTO facts(activity_id, start_time) VALUES(" id-actividad ", datetime('now', 'localtime')); \""))
  (hamster-actualiza-barra-estado))


;; Nueva tarea, indicando hora de inicio
(defun hamster-nueva-tarea-desde(desc hora)
  (interactive "MNueva tarea: \nMHora desde: ")
  (setq id-actividad (existe-actividad desc))
  (if (equal id-actividad "")
      (setq id-actividad (crear-actividad desc))
      (setq id-actividad (obtiene-id-actividad id-actividad)))
  
  (setq fecha-hora (concat (format-time-string "%Y-%m-%d " (current-time)) hora))
  
  ;; Ya estamos preparados para realizar la inserción
  (shell-command-to-string (concat "sqlite3 " hamster-bd " \"INSERT INTO facts(activity_id, start_time) VALUES(" id-actividad ", '" fecha-hora "'); \""))
  (hamster-actualiza-barra-estado))

;; Mostramos las tareas de hoy
(defun hamster-tareas-de-hoy()
  (interactive)
  (defvar fecha-desde (format-time-string "%Y-%m-%d 00:00" (current-time)))
  (defvar tareas (shell-command-to-string (concat "sqlite3 " hamster-bd " \"SELECT strftime('%s', 'now', 'localtime') - strftime('%s', facts.start_time), activities.name, facts.start_time, facts.end_time FROM facts JOIN activities ON facts.activity_id = activities.id WHERE facts.start_time >= '" fecha-desde "'\"")))
  (defvar tareas-split (split-string tareas "\n"))

  ;; Creamos buffer vacío para añadir la lista de tareas
  (generate-new-buffer "hamster")
  (pop-to-buffer "hamster")
  (insert "Tareas de hoy\n")
  (insert "=============\n\n")
  (insert tareas)
  )


(provide 'hamster)
