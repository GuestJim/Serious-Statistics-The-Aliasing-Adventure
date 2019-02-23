@echo off
::uses ImageMagick to convert PDFs to PNGs

convert +antialias "%~1" -quality 95 "%~dp1\%~n1.png"

::the -quality 95 uses the greatest compression (set with the 9) and adaptive data filtering (set with the 5)