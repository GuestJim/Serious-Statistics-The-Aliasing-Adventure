meanADRN	=	function(DATA)	{
	out			=	c(mean(DATA), median(DATA), max(DATA))
	names(out)	=	c("Mean", "Median", "Max")
	return(out)
}

GROUPS	=	list(AA = resultsADRN$AA)
COLUMNS	=	list(
	Temperature	=	resultsADRN$GPUTEMP,
	Fan			=	resultsADRN$GPUFAN,
	Power		=	resultsADRN$GPUPWR,
	Clock		=	resultsADRN$GPUSCLK,
	Memory		=	resultsADRN$GPUMCLK,
	VRAM		=	resultsADRN$GPUVRAMUTIL
	)

dataADRN	=	sepCOL(aggregate(COLUMNS, GROUPS, meanADRN))[, c(
"AA",
"Temperature.Mean",
"Fan.Mean",
"Power.Mean",
"Power.Median",
"Power.Max",
"Clock.Mean",
"Clock.Median",
"VRAM.Mean",
"VRAM.Max"
)]
# graphSTATS	=	sepCOL(aggregate(COLUMNS, GROUPS, statGRAPH))
# graphSTATS$AA	=	factor(graphSTATS$AA, levels = listAA, ordered = TRUE)

colnames(dataADRN)	=	gsub(".", " ", colnames(dataADRN), fixed = TRUE)

sinkTXT	=	function()	{
	options(width = 1000)

	sink(paste0(gameGAQF, " - ADRN.txt"), split = TRUE)
		writeLines(gameGAQ)
		writeLines(type)
		writeLines("\n")
		print(dataADRN, row.names = FALSE)
	sink()
}

library(tableHTML)
OCCHTML	=	function(DATA)	{
	tableHTML(DATA, rownames = FALSE, class="OCC") %>%
	replace_html('style="border-collapse:collapse;" class=OCC border=1', 'align="center" border="1" cellpadding="1" cellspacing="1" style="width: 90%;"') %>%
	replace_html(' id=\"tableHTML_header_\\d\"', '', replace_all = TRUE) %>%
	replace_html(' id=\"tableHTML_column_\\d\"', '', replace_all = TRUE)
}

writeOCC	=	function(DATA, dataNAME, name=gameGAQF, fold = FOLD)	{
	if	(fold != "")	{
		write_tableHTML(OCCHTML(DATA), file = paste0(fold, "\\", name, " - ", dataNAME,".html"))
	}	else	{
		write_tableHTML(OCCHTML(DATA), file = paste0(name, " - ", dataNAME,".html"))
	}
}

sinkHTML	=	function()	{
	writeOCC(dataADRN,				dataNAME = paste0(typeSHORT, "ADRN"))
}

sinkOUT	=	function(datatype)	{
if	(textOUT)	sinkTXT(datatype)
if	(HTMLOUT)	sinkHTML(datatype)
}

if	(textOUT	|	HTMLOUT)	sinkOUT()
message("")


if	(multiGPU)	{
	labsGPU	=	labs()
}	else	{
	labsGPU	=	labs(caption = cGPU)
}

#	spacing between facet panels can be set with  theme(panel.spacing.x = unit(1, "lines"))

scale_Time	=	scale_x_continuous(name="Time (s)", breaks=seq(from=0, to=max(resultsADRN$TIME), by=60), labels = labelBreak, expand=c(0.01, 0))
facet_Blue	=	theme(panel.spacing=unit(.1, "lines"), panel.border = element_rect(color = "blue", fill = NA, size = 1))
pstates	=	c(852, 991, 1084, 1138, 1200, 1401, 1536, 1630)
plabels	=	paste0("P", 0:7, " - ", pstates)

#Maximum VRAM and FPS Boxes
message("Means + VRAM")
ggplot(data = resultsOCAT, aes(x = AA, y = MsBetweenPresents/2)) + 
ggtitle(game, subtitle="Maximum VRAM Usage (GB), MsBetweenPresents") + labsGPU + 
scale_fill_gradient2("VRAM (GB)", low="blue", mid = "green", midpoint = 4,  high="red", limits = c(0, 8), breaks = 1:4*2) +
stat_summary(fun.data = BoxPerc, geom = "boxplot", width = 0.6) +
geom_col(data = dataADRN, aes(x = AA, y = dataADRN[, "VRAM Max"], fill = dataADRN[, "VRAM Max"])) + 
stat_summary(fun.data = BoxPerc, geom = "boxplot", width = 0.6, alpha = 0.5) +
geom_point(data = dataMEAN, aes(x = AA, y = Mean/2), color = "black", shape = 10, size = 5) + 
geom_label(data = dataADRN, aes(label = paste0(dataADRN[, "VRAM Max"], " GB"), x = AA, y = 0), vjust=-0.25) +
scale_y_continuous(name="VRAM Utilized (GB)", breaks=1:8, limits = c(0, 9), expand = c(0.02, 0)
, sec.axis = sec_axis(~./2, name = "Frame Time (ms)", breaks = c(0, ytimes/4), labels =  c(0, round(ytimes,2)))) + 
scale_x_discrete(name = "Anti-Aliasing Option", labels = labelBreak) +
# scale_x_discrete(name = "Anti-Aliasing Option", limits = listAA, labels = substr(RUNlist, 6, 20)) +
theme(legend.position = c(0.975, 0.975), legend.justification = c("right", "top"))

customSave("Means + VRAM", width = 16, height = 9, device = "both")


#VRAM through Course
message("Course VRAM")
ggplot(data = resultsADRN, aes(x = TIME, y = GPUVRAMUTIL, fill = GPUVRAMUTIL)) + 
ggtitle(game, subtitle="VRAM Usage Through Course (GB)") + labsGPU + 
scale_fill_gradient2("VRAM (GB)", low="blue", mid = "green", midpoint = 4,  high="red", limits = c(0, 8), breaks = 1:4*2) +
geom_col() +
facet_grid(rows = vars(AA), switch = "y") +
scale_y_continuous(name="VRAM Utilized (GB)", breaks=1:4*2, limits = c(0, 9), expand = c(0.01, 0)) + 
scale_Time + facet_Blue

customSave("Course VRAM", width = 9, height = 14, device = "both")


#GPU Clock through Course
message("Course GPU Clock")
ggplot(data = resultsADRN, aes(x = TIME, y = GPUSCLK, fill = GPUSCLK)) + 
ggtitle(game, subtitle="GPU Clock Frequency through Course (MHz)") + labsGPU + 
scale_fill_gradient2(name = "MHz", low = "blue", mid = "green", midpoint = 1200,  high="red", limits = c(1100, 1600), breaks = pstates) + 
geom_col() + 
facet_grid(rows = vars(AA), switch = "y") +
scale_y_continuous(name="Frequency (MHz)", breaks = pstates, labels = plabels, limits=c(NA,1900), expand=c(0.02, 0)) + coord_cartesian(ylim = c(1100, 1700)) + 
scale_Time + facet_Blue

customSave("Course GPU Clock", width = 9, height = 14, device = "both")


#GPU Temperature through Course
message("Course GPU Temperature")
ggplot(data = resultsADRN[resultsADRN$TIME != 1,], aes(x = TIME, y = GPUTEMP, fill = GPUTEMP)) + 
#	removing TIME == 1 because of weird values there
ggtitle(game, subtitle="GPU Temperature through Course (°C)") + labsGPU + 
scale_fill_gradient2(name = "°C", low = "blue", mid = "green", midpoint = 70,  high="red", limits = c(60, 90)) + 
geom_col() + 
facet_grid(rows = vars(AA), switch = "y") +
scale_y_continuous(name="Temperature (°C)", breaks = c(25, 50, 75, 85), limits = c(0, 95), expand = c(0.01, 0)) +
coord_cartesian(ylim = c(50, 95)) + 
scale_Time + facet_Blue

customSave("Course Temp", width = 9, height = 14, device = "both")


#GPU Power through Course
message("Course GPU Power")
ggplot(data = resultsADRN, aes(x = TIME, y = GPUPWR, fill = GPUPWR)) + 
ggtitle(game, subtitle="GPU Power through Course (W)") + labsGPU + 
scale_fill_gradient2(name = "Watts", low = "blue", mid = "green", midpoint = 150,  high="red", limits = c(0, 300), breaks = 0:4*75) + 
geom_col() + 
facet_grid(rows = vars(AA), switch = "y") +
scale_y_continuous(name="ASIC Power (W)", breaks = 0:4*75, limits = c(0, 235), expand = c(0.05, 0)) +
scale_Time + facet_Blue

customSave("Course Power", width = 9, height = 14, device = "both")


#GPU Fan Speed through Course
message("Course GPU Fan")
ggplot(data = resultsADRN[resultsADRN$TIME != 1,], aes(x = TIME, y = GPUFAN, fill = GPUFAN)) + 
#	removing TIME == 1 because of weird values there
ggtitle(game, subtitle="GPU Fan Speed through Course (RPM)") + labsGPU + 
scale_fill_gradient2(name = "°C", low = "blue", mid = "green", midpoint = 2200,  high="red", limits = c(1000, 3200)) + 
geom_col() + 
facet_grid(rows = vars(AA), switch = "y") +
scale_y_continuous(name="Fan Speed (RPM)", expand = c(0.05, 0)) +
coord_cartesian(ylim = c(2000, 3500)) + 
scale_Time + facet_Blue

customSave("Course Fan", width = 9, height = 14, device = "both")