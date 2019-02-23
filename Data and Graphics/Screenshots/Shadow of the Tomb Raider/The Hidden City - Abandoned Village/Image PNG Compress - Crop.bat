@echo off
::echo "%~1"

::this allows me to use one file to concatenate.
::If I drag media files onto it, a list is built, and if I drag the list onto it, ffmpeg is run

set folder=Crop


:start
TITLE %folder% - %~dp1

if NOT EXIST "%~dp1%folder%" (
mkdir "%~dp1%folder%"
)

echo Converting %~nx1
convert "%~1" -quality 95 -crop 381x423+0+328 +repage "%~dp1%folder%\Wall - %~n1.png"
convert "%~1" -quality 95 -crop 230x453+651+309 +repage "%~dp1%folder%\Vines - %~n1.png"
::the -quality 95 uses the greatest compression (set with the 9) and adaptive data filtering (set with the 5)

shift

if "%~1"=="" goto end
goto start

:end

::pause