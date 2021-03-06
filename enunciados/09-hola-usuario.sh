#! /bin/bash

# script que saca un "Hola " + parámetros + "!" por pantalla
# separando cada parámetro con una coma (,)
# que verifica que hayamos introducido al menos un parámetro
# que además verifique que sean usuarios del sistema
# y que muestra una ayuda en caso de error

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

NUMERO_DE_PARAMETROS=$#
if [ $NUMERO_DE_PARAMETROS -le 0 ]; then
    echo "Hay que introducir al menos un parámetro."
    ayuda
    exit 1
fi

MENSAJE="Hola"
ES_PRIMERO=1
PRIMER_PARAMETRO=$1

while [ -n "$PRIMER_PARAMETRO" ]; do

    # ¿cómo llamamos a otro script (varias opciones)?
    ESTA_CONECTADO=`./07-usuario-conectado $PRIMER_PARAMETRO`

    if [ "$ESTA_CONECTADO" == "NO" ]; then
        echo "El usuario $1 no está conectado"
        ayuda
        exit 2
    fi

    if [ $ES_PRIMERO -eq 1 ]; then
        MENSAJE="$MENSAJE $PRIMER_PARAMETRO"
        ES_PRIMERO=0
    else
        MENSAJE="$MENSAJE, $PRIMER_PARAMETRO"
    fi

    shift
    PRIMER_PARAMETRO=$1
done

echo $MENSAJE"!"
