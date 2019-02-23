@echo off
::echo "%~1"

::this allows me to use one file to concatenate.
::If I drag media files onto it, a list is built, and if I drag the list onto it, ffmpeg is run

set folder=Jittered Samples

set background=-transparent white
set background=

set scale=
set scale=-interpolate NearestNeighbor -sample 1024x1024

::Filter options
::	http://www.imagemagick.org/script/command-line-options.php?#filter

:start
TITLE %folder% - %~dp1

if NOT EXIST "%~dp1%folder%" (
mkdir "%~dp1%folder%"
)

echo Converting %~nx1

if NOT EXIST "%~dp1%folder%" (
mkdir "%~dp1%folder%"
)

convert -size 1024x1024 -define sample:offset=25x25 -sample 4x4 "%~1" -quality 95 %scale% %background% "%~dp1%folder%\%~n1 - A UL.png"
convert -size 1024x1024 -define sample:offset=75x25 -sample 4x4 "%~1" -quality 95 %scale% %background% "%~dp1%folder%\%~n1 - B UR.png"
convert -size 1024x1024 -define sample:offset=25x75 -sample 4x4 "%~1" -quality 95 %scale% %background% "%~dp1%folder%\%~n1 - C LL.png"
convert -size 1024x1024 -define sample:offset=75x75 -sample 4x4 "%~1" -quality 95 %scale% %background% "%~dp1%folder%\%~n1 - D LR.png"

::pause