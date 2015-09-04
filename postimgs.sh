#!/bin/bash

for img in *.png ; do
  curl -Ls -F "upload[]=@${img}" -F "adult=no" http://postimage.org/ | grep 'id="code_1"'
done
