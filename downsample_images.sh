#!/usr/bin/env bash

# Bash script for down-sampling images. Requires ImageMagick 7 installed

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
    convert $file -resize $targetwidth $file
    echo "Converted $file to width $targetwidth"
  fi
done

