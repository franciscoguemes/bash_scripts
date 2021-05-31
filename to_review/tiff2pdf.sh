#!/bin/bash

# Command: ./tiff2pdf.sh

# Converts all *.tif files in the directory into *.pdf files
# For each *.tif file it will generate a *.pdf file
# The program first converts into jpg in order to

# More info at:
#   https://askubuntu.com/questions/60401/batch-processing-tif-images-converting-tif-to-jpeg
#   https://askubuntu.com/questions/246647/convert-a-directory-of-jpeg-files-to-a-single-pdf-document
#   https://askubuntu.com/questions/1081895/trouble-with-batch-conversion-of-png-to-pdf-using-convert
#   https://imagemagick.org/


for f in *.tif
do
    echo "Converting $f"
    convert "$f"  "$(basename "$f" .tif).jpg"
done

for f in *.jpg
do
    echo "Converting $f"
    convert "$f"  "$(basename "$f" .jpg).pdf"
done