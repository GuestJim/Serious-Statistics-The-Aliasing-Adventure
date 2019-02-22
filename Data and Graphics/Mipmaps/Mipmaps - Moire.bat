@echo off
::echo +antialias "%~1"

::this allows me to use one file to concatenate.
::If I drag media files onto it, a list is built, and if I drag the list onto it, ffmpeg is run

set folder=Mipmaps

set background=-transparent white
set background=

::Filter options
::	http://www.imagemagick.org/script/command-line-options.php?#filter

:start
TITLE %folder% - %~dp1

echo Converting %~nx1

set filter=Point
set id=01
echo %filter%

if NOT EXIST "%~dp1\%id% %filter%" (
mkdir "%~dp1\%id% %filter%"
)

convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize 100.0%% "%~dp1\%id% %filter%\%~n1 - 800.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  50.0%% "%~dp1\%id% %filter%\%~n1 - 400.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  25.0%% "%~dp1\%id% %filter%\%~n1 - 200.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  12.5%% "%~dp1\%id% %filter%\%~n1 - 100.png"

set filter=Box
set id=02
echo %filter%

if NOT EXIST "%~dp1\%id% %filter%" (
mkdir "%~dp1\%id% %filter%"
)

convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize 100.0%% "%~dp1\%id% %filter%\%~n1 - 800.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  50.0%% "%~dp1\%id% %filter%\%~n1 - 400.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  25.0%% "%~dp1\%id% %filter%\%~n1 - 200.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  12.5%% "%~dp1\%id% %filter%\%~n1 - 100.png"

set filter=Triangle
set id=03
echo %filter%

if NOT EXIST "%~dp1\%id% %filter%" (
mkdir "%~dp1\%id% %filter%"
)

convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize 100.0%% "%~dp1\%id% %filter%\%~n1 - 800.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  50.0%% "%~dp1\%id% %filter%\%~n1 - 400.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  25.0%% "%~dp1\%id% %filter%\%~n1 - 200.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  12.5%% "%~dp1\%id% %filter%\%~n1 - 100.png"

set filter=Quadratic
set id=04
echo %filter%

if NOT EXIST "%~dp1\%id% %filter%" (
mkdir "%~dp1\%id% %filter%"
)

convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize 100.0%% "%~dp1\%id% %filter%\%~n1 - 800.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  50.0%% "%~dp1\%id% %filter%\%~n1 - 400.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  25.0%% "%~dp1\%id% %filter%\%~n1 - 200.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  12.5%% "%~dp1\%id% %filter%\%~n1 - 100.png"

set filter=Cubic
set id=05
echo %filter%

if NOT EXIST "%~dp1\%id% %filter%" (
mkdir "%~dp1\%id% %filter%"
)

convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize 100.0%% "%~dp1\%id% %filter%\%~n1 - 800.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  50.0%% "%~dp1\%id% %filter%\%~n1 - 400.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  25.0%% "%~dp1\%id% %filter%\%~n1 - 200.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  12.5%% "%~dp1\%id% %filter%\%~n1 - 100.png"

set filter=Gaussian
set id=06
echo %filter%

if NOT EXIST "%~dp1\%id% %filter%" (
mkdir "%~dp1\%id% %filter%"
)

convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize 100.0%% "%~dp1\%id% %filter%\%~n1 - 800.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  50.0%% "%~dp1\%id% %filter%\%~n1 - 400.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  25.0%% "%~dp1\%id% %filter%\%~n1 - 200.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  12.5%% "%~dp1\%id% %filter%\%~n1 - 100.png"

set filter=Catrom
set id=07
echo %filter%

if NOT EXIST "%~dp1\%id% %filter%" (
mkdir "%~dp1\%id% %filter%"
)

convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize 100.0%% "%~dp1\%id% %filter%\%~n1 - 800.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  50.0%% "%~dp1\%id% %filter%\%~n1 - 400.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  25.0%% "%~dp1\%id% %filter%\%~n1 - 200.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  12.5%% "%~dp1\%id% %filter%\%~n1 - 100.png"

set filter=Mitchell
set id=08
echo %filter%

if NOT EXIST "%~dp1\%id% %filter%" (
mkdir "%~dp1\%id% %filter%"
)

convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize 100.0%% "%~dp1\%id% %filter%\%~n1 - 800.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  50.0%% "%~dp1\%id% %filter%\%~n1 - 400.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  25.0%% "%~dp1\%id% %filter%\%~n1 - 200.png"
convert +antialias "%~1" -quality 95 %background% -filter %filter% -resize  12.5%% "%~dp1\%id% %filter%\%~n1 - 100.png"

::the -quality 95 uses the greatest compression (set with the 9) and adaptive data filtering (set with the 5)

shift

if "%~1"=="" goto end
goto start

:end

::pause