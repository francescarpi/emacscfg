# EmacsCFG

Emacscfg es mi configuración personal para Emacs. La que utilizo diariamente. Es una recopilación de paquetes, configurados a mi gusto. El propósito es tener un backup de mi configuración en la nuve. Y si a alguien le gusta, que la aproveche.

## Instalación

* Clonar el repositorio en cualquier lugar de tu sistema.

	<pre>
	git clone --recursive https://github.com/francescarpi/emacscfg.git
	</pre>

* Activar configuración:

	<pre>
	ln -s ~/path-de-tu-emacscfg/emacs ~/.emacs
	ln -s ~/path-de-tu-emacscfg/paquetes ~/.emacs.d/
	</pre>


## Combinaciones de teclas

Combinaciones de teclas que más uso. Mi chuleta.

### Ventanas y buffers

| Combinación   | Descripción                                   |
| ------------- | --------------------------------------------- |
| C+x 0         | Cerrar la ventana actual                      |
| C+x 1         | Maximizar la ventana actual                   |
| C+x 2         | Dividir la ventana horizontalmente            |
| C+x 3         | Dividir la ventana verticalmente              |
| C+x o         | Ir a la ventana siguiente                     |
| C+x b         | Cambio de buffer por nombre                   |
| C+x C+b       | Se abre la ventana de buffers.                |
| C+x k         | Mata el buffer actual                         |
| C+x <right>   | Ir a buffer siguiente                         |
| C+x <left>    | Ir a buffer anterior                          |
| C+x x <right> | Ir a la ventana de la derecha (custom)        |
| C+x x <down>  | Ir a la ventana de abajo                      |
| C+x x <left>  | Ir a la ventana de la izquierda               |
| C+x x <up>    | Ir a la ventana de arriba                     |

Dentro de la ventana de buffers, existen funcionalidades extras:

* g: Refresca ventana
* sm: Ordenar por modo
* sv: Ordenar por fecha/hora

### Ficheros

| Combinación   | Descripción                                   |
| ------------- | --------------------------------------------- |
| C+x C+f       | Abrir fichero                                 |
| C+x C+s       | Guardar fichero                               |

* Buscar ficheros en un directorio:
<pre>
A+x find-dired RET seleccionar carpeta padre RET -name "*.py" RET
</pre>
* Buscar dentro de una carpeta
A+x helm-do-grep RET <seleccionar carpeta> C+u RET <indicar extensión ficheros> RET <indicar patron a buscar dentro de los ficheros>

### Generales

| Combinación   | Descripción                                   |
| ------------- | --------------------------------------------- |
| C+x C+c       | Salir de Emacs                                |
| C+g           | Deshacer operación actual.                    |
| A+x ansi-term | Abrir un shell del sistema                    |
| A+x shell     | Abrir shell propio de emacs. Escrito en lisp  |
| A+!           | Ejecutar un comando en el shell               |

### Navegación

| Combinación   | Descripción                                   |
| ------------- | --------------------------------------------- |
| C+l           | Centrar scroll vertical                       |
| C+k           | Borrar linea actual                           |
| C+a           | Ir al principio de una linea                  |
| C+e           | Ir al final de una linea                      |
| C+f           | Avanzar carácter                              |
| C+b           | Retroceder carácter                           |
| A+f           | Avanzar palabra                               |
| A+b           | Retroceder palabra                            |
| C+n           | Linea siguiente                               |
| C+p           | Linea anterior                                |
| C+v           | Página siguiente                              |
| A+v           | Página anterior                               |
| A+>           | Ir al final del documento                     |
| A+<           | Ir al principio del documento                 |
| A+w           | Copiar al portapapeles                        |
| C+y           | Pegar desde el portapapeles                   |
| C+w           | Cortar hacia el portapapeles                  |
| C+_           | Deshacer                                      |
| C+g C+_       | Rehacer                                       |
| C+s           | Buscar + buscar siguiente                     |
| C+r           | Buscar + buscar anterior                      |
| A+g g         | Ir a una linea concreta                       |
| C+c C+j       | Ir a una definición (clase, método, etc)      |
| C+espacio     | Se activa modo visual                         |
| C+d           | Borrar un carácter                            |
| A+0..9        | Seguido de un comando, lo ejecuta n veces     |
| C+M+e         | Saltar al final de la función/método          |
| C+M+a         | Saltar al inicio de la función/método         |

### Html - Mode

| Combinación   | Descripción                                   |
| ------------- | --------------------------------------------- |
| C+c /         | Cierra un tag                                 |
| C+x TAB       | Oculta tags, dejando sólo cadenas             |
| C+c <left>    | Ir al principio del tag                       |
| C+c <right>   | Ir al final del tag                           |
| C+j           | Ejecuta Emmet                                 |

### Dired Mode

Es una ventana de navegación de ficheros, donde podemos borrarlos, renombrarlos, etc. Al hacer **C+x C+f**, si tenemos seleccionada una carpeta, pulsar **C+d** para abrir dired-mode.

Acciones disponibles dentro del dm.

| Combinación   | Descripción                                   |
| ------------- | --------------------------------------------- |
| g             | Refrescar vista                               |
| s             | Cambiar ordenación entre fecha y nombre       |
| d             | Marcar un fichero para borrar                 |
| u             | Desmarcar un fichero marcado para borrar      |
| x             | Borrar ficheros marcados                      |
| o             | Abrir fichero en una ventana nueva            |
| R             | Renombrar fichero                             |
| Intro         | Abrir fichero en ventana actual               |
| +             | Crear un directorio                           |

Para crear un fichero en dired mode, se puede hacer ejecutando un comando de shell: **A+!** + **touch <nombrefichero>**. Luego un **g** en el dired mode para refrescar la ventana
