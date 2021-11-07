#!/usr/bin/env bash

# Bash script for down-sampling all images in a given directory. Requires ImageMagick 7 installed
# Usage: in root folder
# ./downsample_images.sh images/recipes/pan-fried-salmon 500
# Make sure your permissions are okay with executing the script!

# To crop images to square, you can use:
# mogrify -gravity Center -crop 3024x3024+0+0 image_name.jpg
# but we don't really use this - we crop images using CSS for the recipes page.

if [ -z "$1" ]
then
  echo "Missing target folder in first argument"
  exit 1
fi

if [ -z "$2" ]
then
  echo "Missing width in second argument"
  exit 1
fi

targetfolder=$1
targetwidth=$2
let count=0

for file in "$(pwd)/$targetfolder"/*
do
  if [[ $file == *.jpg ]];
  then
    imagedim=(`identify -format '%w %h' ${file}`)
    imagewidth=${imagedim[0]}
    imageheight=${imagedim[1]}
    flip=false

    if [ $imagewidth -gt $imageheight ];
    then
      flip=true
      convert $file -rotate 90 $file
    fi

    convert $file -resize $targetwidth $file

    if [ "$flip" = true ];
    then
      convert $file -rotate 270 $file
    fi

    echo "Converted $file to $targetwidth along smaller dimension"
  fi
done

