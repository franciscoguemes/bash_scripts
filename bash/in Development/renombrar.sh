#!/bin/sh
# rename.sh /carpeta prefijo
# Inicio de nombre nuevo fichero.
# Sacado de: http://www.espaciolinux.com/foros/programacion/script-para-renombrar-archivos-t44231.html

#Testar el número de argumentos y explicar un poco que argumentos hay que pasar...

#Añadir la opcion de recursividad o no...

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
			mv $1/$i $1/$prefijo"_"$i
		  fi
		fi
	done
}


prefijo=$2
cd $1 
recursiva $1 $2
#echo "Argumento 0: $0"
#echo "Argumento 1: $1"
#echo "Argumento 2: $2"