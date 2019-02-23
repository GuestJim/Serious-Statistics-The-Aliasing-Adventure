::Thinking it is not going to be worth trying to use these to show the impact it can have on blending samples. Just not finding a way to adequately recreate the super-sampling involved and also it appears Point sampling still blends when it should not
::	maybe working off of a raster instead of a graphic would help

@echo off
::echo "%~1"

::this allows me to use one file to concatenate.
::If I drag media files onto it, a list is built, and if I drag the list onto it, ffmpeg is run

set folder=Jittered Samples

set background=-transparent white
set background=

set scale=
set scale=-interpolate NearestNeighbor -sample 128x128

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

convert -size 1280x1280 -define sample:offset=25x25 -sample 8x8 "%~1" -quality 95 %scale% %background% "%~dp1%folder%\%~n1 - A UL.png"
convert -size 1280x1280 -define sample:offset=75x25 -sample 8x8 "%~1" -quality 95 %scale% %background% "%~dp1%folder%\%~n1 - B UR.png"
convert -size 1280x1280 -define sample:offset=25x75 -sample 8x8 "%~1" -quality 95 %scale% %background% "%~dp1%folder%\%~n1 - C LL.png"
convert -size 1280x1280 -define sample:offset=75x75 -sample 8x8 "%~1" -quality 95 %scale% %background% "%~dp1%folder%\%~n1 - D LR.png"

::pause