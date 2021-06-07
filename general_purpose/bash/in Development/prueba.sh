#!/bin/sh
# rename.sh [-R] /carpeta prefijo
# Inicio de nombre nuevo fichero.
# Sacado de: http://www.espaciolinux.com/foros/programacion/script-para-renombrar-archivos-t44231.html

#Testar el número de argumentos y explicar un poco que argumentos hay que pasar...
E_WRONG_ARGS=85
Number_of_min_args=2
Number_of_max_args=3
script_parameters="-R"
#                  -R = recursivo.

if [ $# -ne $Number_of_min_args ] && [ $# -ne $Number_of_max_args ]
then
  echo "Usage: `basename $0` [$script_parameters] directory_name header"
  # `basename $0` is the script's filename.
  exit $E_WRONG_ARGS
fi



#Evita problemas con cadenas con espacios en blanco
IFS=$'\x0A'$'\x0D'

function recursiva {
	for i in $(ls $1); do
		if [ -d $1/$i ]; then  
			echo "Directorio localizado: $i"
			#echo "Estoy en: `pwd`"
			recursiva "$1/$i"
		else
		  if [ -f $1/$i ]; then
			echo "$prefijo"_"$i"
			#mv $1/$i $1/$prefijo"_"$i
		  fi
		fi
	done
}

function no_recursiva {
	for i in $(ls $1); do
		if [ -f $1/$i ]; then
		    echo "$prefijo"_"$i"
		    #mv $1/$i $1/$prefijo"_"$i
		fi
	done
}

echo "Argumento 0: $0"
echo "Argumento 1: $1"
echo "Argumento 2: $2"
echo "Argumento 3: $3"


d_actual=`pwd`
#Traduzco el directorio pasado como argumento a un directorio absoluto
cd $arg2 
arg2=`pwd`
echo $arg2



if [ $# -eq $Number_of_min_args ] 
then
  prefijo=$2
  no_recursiva $1 $2
else
  prefijo=$3
  recursiva $2 $3
fi

#Vuelvo al directorio donde estaba...
cd $d_actual
pwd


