#!/bin/bash

#Comando: scan fichero_salida.tif
#Ejemplo: scan myPassport.tif

# If you do not have the file /usr/share/color/icc/RGB/AdobeRGB1998.icc your can download it from:
#   https://supportdownloads.adobe.com/product.jsp?product=62&platform=Windows

scanimage --format=tiff    \
            --mode Color     \
            --depth 8        \
            --resolution 300 \
            --icc-profile /usr/share/color/icc/RGB/AdobeRGB1998.icc \
             -l 1mm          \
             -t 1mm          \
             -x 208mm        \
             -y 295mm        \
             -v              \
             > $1.tif