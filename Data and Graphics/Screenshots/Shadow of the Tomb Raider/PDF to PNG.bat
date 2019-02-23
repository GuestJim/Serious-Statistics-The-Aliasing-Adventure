@echo off
::echo "%~1"

::this allows me to use one file to concatenate.
::If I drag media files onto it, a list is built, and if I drag the list onto it, ffmpeg is run


:start
TITLE %folder% - %~dp1

echo Converting %~nx1
convert -density 96 +antialias "%~1" -quality 95 "%~n1.png"
::the -quality 95 uses the greatest compression (set with the 9) and adaptive data filtering (set with the 5)

shift

if "%~1"=="" goto end
goto start

:end

::pause