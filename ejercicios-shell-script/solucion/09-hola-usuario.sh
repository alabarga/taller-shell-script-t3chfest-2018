#! /bin/bash

# script que saca un "Hola " + parámetros + "!" por pantalla
# separando cada parámetro con una coma (,)
# que verifica que hayamos introducido al menos un parámetro
# que además verifique que sean usuarios del sistema
# y que muestra una ayuda en caso de error

# función de ayuda
function ayuda() {

cat << DESCRPCION_AYUDA
SYNOPSIS
	$0 NOMBRE_1 [NOMBRE_2] ... [NOMBRE_N]

DESCRIPCION
   Muestra "Hola NOMBRE_1, NOMBRE_2, ... NOMBRE_N!" por pantalla.

CÓDIGOS DE RETORNO
	1 Si el número de parámetros es menor que 1
	2 Si el usuario no está conectado
DESCRPCION_AYUDA

}

# si número de parámetros <= 0
if [ $# -le 0 ] ; then
  echo "Hay que introducir al menos un parámetro."
  ayuda
  exit 1
fi

MENSAJE="Hola"
PRIMERO=1

# mientras haya parámetros
while [ -n "$1" ]; do

	ESTA_CONECTADO=`./07-usuario-conectado $1`

	if [ "$ESTA_CONECTADO" == "NO" ]; then
		echo "El usuario $1 no está conectado"
		ayuda
		exit 2
	fi

	if [ $PRIMERO -eq 1 ]; then

		MENSAJE="$MENSAJE $1"
		PRIMERO=0
	else
		MENSAJE="$MENSAJE, $1"
	fi

	# pasamos al siguiente parámetro
	shift
done

# mostramos la salida por pantalla
echo ${MENSAJE}"!"