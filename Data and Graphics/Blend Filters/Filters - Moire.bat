::Thinking it is not going to be worth trying to use these to show the impact it can have on blending samples. Just not finding a way to adequately recreate the super-sampling involved and also it appears Point sampling still blends when it should not
::	maybe working off of a raster instead of a graphic would help

@echo off
::echo +antialias "%~1"

::this allows me to use one file to concatenate.
::If I drag media files onto it, a list is built, and if I drag the list onto it, ffmpeg is run

set folder=Filters

set background=-transparent white
set background=

::Filter options
::	http://www.imagemagick.org/script/command-line-options.php?#filter

:start
TITLE %folder% - %~dp1

if NOT EXIST "%~dp1%folder%" (
mkdir "%~dp1%folder%"
)

echo Converting %~nx1

set filter=Point
set id=01
echo %filter%

if NOT EXIST "%~dp1%folder%\%id% %filter%" (
mkdir "%~dp1%folder%\%id% %filter%"
)


convert -size 200x200 +antialias "%~1" -quality 95 %background%  "%~dp1%folder%\%id% %filter%\%~n1 - 1x.png"
convert -size 400x400 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 2x.png"
convert -size 800x800 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 4x.png"
convert -size 1600x1600 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 8x.png"

set filter=Box
set id=02
echo %filter%

if NOT EXIST "%~dp1%folder%\%id% %filter%" (
mkdir "%~dp1%folder%\%id% %filter%"
)

convert -size 200x200 +antialias "%~1" -quality 95 %background%  "%~dp1%folder%\%id% %filter%\%~n1 - 1x.png"
convert -size 400x400 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 2x.png"
convert -size 800x800 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 4x.png"
convert -size 1600x1600 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 8x.png"

set filter=Triangle
set id=03
echo %filter%

if NOT EXIST "%~dp1%folder%\%id% %filter%" (
mkdir "%~dp1%folder%\%id% %filter%"
)

convert -size 200x200 +antialias "%~1" -quality 95 %background%  "%~dp1%folder%\%id% %filter%\%~n1 - 1x.png"
convert -size 400x400 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 2x.png"
convert -size 800x800 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 4x.png"
convert -size 1600x1600 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 8x.png"

set filter=Quadratic
set id=04
echo %filter%

if NOT EXIST "%~dp1%folder%\%id% %filter%" (
mkdir "%~dp1%folder%\%id% %filter%"
)

convert -size 200x200 +antialias "%~1" -quality 95 %background%  "%~dp1%folder%\%id% %filter%\%~n1 - 1x.png"
convert -size 400x400 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 2x.png"
convert -size 800x800 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 4x.png"
convert -size 1600x1600 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 8x.png"

set filter=Cubic
set id=05
echo %filter%

if NOT EXIST "%~dp1%folder%\%id% %filter%" (
mkdir "%~dp1%folder%\%id% %filter%"
)

convert -size 200x200 +antialias "%~1" -quality 95 %background%  "%~dp1%folder%\%id% %filter%\%~n1 - 1x.png"
convert -size 400x400 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 2x.png"
convert -size 800x800 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 4x.png"
convert -size 1600x1600 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 8x.png"

set filter=Gaussian
set id=06
echo %filter%

if NOT EXIST "%~dp1%folder%\%id% %filter%" (
mkdir "%~dp1%folder%\%id% %filter%"
)

convert -size 200x200 +antialias "%~1" -quality 95 %background%  "%~dp1%folder%\%id% %filter%\%~n1 - 1x.png"
convert -size 400x400 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 2x.png"
convert -size 800x800 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 4x.png"
convert -size 1600x1600 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 8x.png"

set filter=Catrom
set id=07
echo %filter%

if NOT EXIST "%~dp1%folder%\%id% %filter%" (
mkdir "%~dp1%folder%\%id% %filter%"
)

convert -size 200x200 +antialias "%~1" -quality 95 %background%  "%~dp1%folder%\%id% %filter%\%~n1 - 1x.png"
convert -size 400x400 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 2x.png"
convert -size 800x800 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 4x.png"
convert -size 1600x1600 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 8x.png"

set filter=Mitchell
set id=08
echo %filter%

if NOT EXIST "%~dp1%folder%\%id% %filter%" (
mkdir "%~dp1%folder%\%id% %filter%"
)

convert -size 200x200 +antialias "%~1" -quality 95 %background%  "%~dp1%folder%\%id% %filter%\%~n1 - 1x.png"
convert -size 400x400 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 2x.png"
convert -size 800x800 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 4x.png"
convert -size 1600x1600 +antialias "%~1" -quality 95 %background% -filter %filter% -resize 200x200 "%~dp1%folder%\%id% %filter%\%~n1 - 8x.png"

::the -quality 95 uses the greatest compression (set with the 9) and adaptive data filtering (set with the 5)

shift

if +antialias "%~1"=="" goto end
goto start

:end

::pause