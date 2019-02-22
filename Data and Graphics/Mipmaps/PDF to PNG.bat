@echo off
::uses ImageMagick to convert PDFs to PNGs

set DPI=96

:start

convert +antialias "%~1" -quality 95 "%~dp1\%~n1.png"

::the -quality 95 uses the greatest compression (set with the 9) and adaptive data filtering (set with the 5)

shift

if "%~1"=="" goto end
goto start

:end

::pause