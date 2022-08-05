#/bin/bash

#Comando: mp3splt -t tiempo -d directorio_salida fichero_entrada.mp3 
#Ejemplo: mp3splt -t 05.00 -d Trozos asot541.mp3 

#Pongo la variable IFS con valor: salto de línea y retorno de carro
OLD_IFS=$IFS
IFS=$'\x0A'$'\x0D'

input_audio=`kdialog --title "Escoger fichero de audio a partir (*.mp3 | *.ogg):" --getopenfilename ~ "*.mp3 *.ogg |MP3 and OGG Audio Files" `
if [ $? = 0 ]; then
  echo "Audio escogido: " $input_audio
  time=`kdialog --title "Tiempo" --inputbox "Introduzca la frecuencia de corte en formato mm.ss. 
      Este tiempo será usado para trocear el fichero de audio. Ej: 05.00 
      El fichero de entrada se troceará cada 5 minutos de audio. 
      El separador de minutos y segundos es un punto"`
  if [ $? = 0 ]; then
    echo "Frecuencia de corte: " $time
    output_directory=`kdialog --title "Seleecionar directorio de salida:" --getexistingdirectory ${input_audio}`
    if [ $? = 0 ]; then
      echo "Directorio de salida: " $output_directory
      mp3splt -t ${time} -d ${output_directory} ${input_audio}
      dolphin ${output_directory}
    fi
  fi
else
  echo "Has escogido cancelar. Fin del script."
fi  

#Restablezco el valor de IFS...
IFS=$OLD_IFS
 
