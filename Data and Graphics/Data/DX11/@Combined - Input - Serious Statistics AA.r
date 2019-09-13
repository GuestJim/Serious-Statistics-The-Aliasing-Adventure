library(readr)
library(ggplot2)
library(moments)

game		=	"Serious Statistics: The Aliasing Adventure"
gameName	=	"Serious Sam Fusion 2017 (DX11 - Hatsheput)"
cGPU		=	"RX Vega 64"

gameF = gsub(":", "-", game)
gameF = unlist(strsplit(gameF, split=" [(]"))[1]

theme_set(theme_grey(base_size = 16))
DPI = 120
ggdevice = "png"

textOUT		=	TRUE
HTMLOUT		=	TRUE
graphs		=	TRUE
graphs_all	=	FALSE
useSHORT	=	TRUE

textFRAM	=	FALSE
graphFRAM	=	TRUE

textDISP	=	TRUE
graphDISP	=	TRUE

textREND	=	FALSE
graphREND	=	TRUE

listFPS		=	NULL
#	for adding to the FPS Percentile list
QUAN		=	c(0.01, 0.99)
FtimeLimit	=	1000/30

gWIDTH	=	9
gHEIGH	=	14

if (!graphs){
	graphFRAM	=	FALSE
	graphDISP	=	FALSE
	graphREND	=	FALSE
	graphDIFF	=	FALSE
}

if (interactive())	{
	setwd("E:/Users/Jim/My Documents/OCC/@Reviews/Serious Statistics AA/@1.1 Stuff/OCAT - Data")
}	else	{
	pdf(NULL)
}
#	checks if the script is being run in the GUI or not
#		prevents rplots.pdf from being generated

resultsOCAT	=	read_csv("Combined OCAT.csv")
resultsADRN	=	read_csv("Combined ADRN.csv")

listAA	=	c(
"None",
"SSAA 2x",
"SSAA 4x",
"FXAA Low",
"FXAA Medium",
"FXAA High",
"FXAA Ultra",
"MSAA 2x",
"MSAA 4x",
"MSAA 8x"
)

NAMEs = c(
"None00" = "None",
"SSAA2x" = "SSAA 2x",
"SSAA4x" = "SSAA 4x",
"FXAALw" = "FXAA Low",
"FXAAMd" = "FXAA Medium",
"FXAAHi" = "FXAA High",
"FXAAUl" = "FXAA Ultra",
"MSAA2x" = "MSAA 2x",
"MSAA4x" = "MSAA 4x",
"MSAA8x" = "MSAA 8x"
)

listLOC		=	c(
"Hatsheput"
)

shortLOC	=	c(
NULL
)

listAPI		=	c(
"DirectX 11"
)

shortAPI	=	c(
NULL
)


resultsOCAT$AA	=	factor(resultsOCAT$AA, levels = listAA, ordered = TRUE)
resultsADRN$AA	=	factor(resultsADRN$AA, levels = listAA, ordered = TRUE)

multiGPU	=	FALSE

testAPI	=	FALSE

gameQ		=	game
gameGAQ		=	game
gameGAQF	=	gameF

source("@Combined - Output - OCAT.r")

# source("@Combined - Output - ADRN.r")