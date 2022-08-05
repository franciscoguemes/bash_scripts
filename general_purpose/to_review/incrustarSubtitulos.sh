#/bin/bash
#mencoder video.avi -o video_harsubeado.avi -sub subtitulo.srt -subfont-text-scale 2.5 -subfont-blur 0 -subfont-outline 0.10 -ffactor 0.90 -subcp iso-8859-15 -oac copy -ovc xvid -xvidencopts pass=1:bitrate=2050

#Pongo la variable IFS con valor: salto de línea y retorno de carro
OLD_IFS=$IFS
IFS=$'\x0A'$'\x0D'

input_video=`kdialog --title "Escoger vídeo entrada (*.avi):" --getopenfilename ~ "*.avi |Avi video Files"`
if [ $? = 0 ]; then
  echo "Vídeo escogido: " $input_video
  input_subtitles=`kdialog --title "Escoger subtitulos *.srt:" --getopenfilename : "*.srt |Srt subtitles file"`
  if [ $? = 0 ]; then
    echo "Subtitulo escogido: " $input_subtitles
    output_video=`kdialog --title "Seleecionar fichero de salida (*.avi):" --getsavefilename : "*.avi |Avi video Files"`
    if [ $? = 0 ]; then
      echo "Fichero salida: " $output_video
      #echo "mencoder: " $input_video $output_video $input_subtitles
      mencoder ${input_video} -o ${output_video} -sub ${input_subtitles} -subfont-text-scale 2.5 -subfont-blur 0 -subfont-outline 0.10 -ffactor 0.90 -subcp iso-8859-15 -oac copy -ovc xvid -xvidencopts pass=1:bitrate=2050
    fi
  fi
else
  echo "Escogiste cancelar"
fi  

#Restablezco el valor de IFS...
IFS=$OLD_IFS


  