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

### Ficheros

| Combinación   | Descripción                                   |
| ------------- | --------------------------------------------- |
| C+x C+f       | Abrir fichero                                 |
| C+x C+s       | Guardar fichero                               |


