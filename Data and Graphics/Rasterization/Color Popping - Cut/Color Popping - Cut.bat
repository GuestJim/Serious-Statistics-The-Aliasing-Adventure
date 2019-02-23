@echo off
::echo "%~1"

::this allows me to use one file to concatenate.
::If I drag media files onto it, a list is built, and if I drag the list onto it, ffmpeg is run

set folder=Color Popping - Cut

set background=-transparent white
set background=

set scale=-filter point -interpolate nearest -resize 800x800
set scale=-filter point -resize 800x800
set scale=
set scale=-interpolate NearestNeighbor -sample 128x128

::Filter options
::	http://www.imagemagick.org/script/command-line-options.php?#filter

:start
TITLE %folder% - %~dp1

echo Converting %~nx1

convert -size 1x1 "%~1" -quality 95 %scale% %background% "%~dp1\%~n1 - 1x.png"
convert -size 2x2 "%~1" -quality 95 %scale% %background% "%~dp1\%~n1 - 2x.png"
convert -size 4x4 "%~1" -quality 95 %scale% %background% "%~dp1\%~n1 - 4x.png"
convert -size 8x8 "%~1" -quality 95 %scale% %background% "%~dp1\%~n1 - 8x.png"
convert -size 16x16 "%~1" -quality 95 %scale% %background% "%~dp1\%~n1 - 16x.png"
convert -size 32x32 "%~1" -quality 95 %scale% %background% "%~dp1\%~n1 - 32x.png"
convert -size 64x64 "%~1" -quality 95 %scale% %background% "%~dp1\%~n1 - 64x.png"
convert -size 128x128 "%~1" -quality 95 %scale% %background% "%~dp1\%~n1 - 128x.png"

::pause