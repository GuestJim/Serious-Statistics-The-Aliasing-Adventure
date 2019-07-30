library(readr)
library(ggplot2)
library(gridExtra)
setwd("E:/Users/Jim/My Documents/OCC/@Reviews/Serious Statistics AA/Data/DX11 - GC/")
#	change to the appropriate path on your system, or run script directly, not in R GUI

game = character(0)
game = "Serious Sam Fusion 2017 (DX11 - Fresh)"

gameF = gsub(":", "-", game)

titled = TRUE
graphs = FALSE

if(titled) {
	recording = ""
	recordnam = paste(game, sep="")
	setname = paste(" - \n", recordnam, sep = "")
} else {
	recording = character(0)
	setname = character(0)
}

pdf = TRUE
DPI = 120
ggscale = 1

theme_set(theme_grey(base_size = 16))

NAMlist = c(
"None00",
"SSAA2x",
"SSAA4x",
"FXAALw",
"FXAAMd",
"FXAAHi",
"FXAAUl",
"MSAA2x",
"MSAA4x",
"MSAA8x"
)

NAMread = c(
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

set_labeller = function(variable, value){
	return(NAMEs[value])
}

NAMconv = c(
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

RUNlist = c(
"00 - None",
"01 - SSAA 2x",
"02 - SSAA 4x",
"03 - FXAA Low",
"04 - FXAA Medium",
"05 - FXAA High",
"06 - FXAA Ultra",
"07 - MSAA 2x",
"08 - MSAA 4x",
"09 - MSAA 8x"
)

FLDlist = c(
"None/",
"SSAA/",
"SSAA/",
"FXAA/",
"FXAA/",
"FXAA/",
"FXAA/",
"MSAA/",
"MSAA/",
"MSAA/"
)

COMlist = paste(FLDlist, RUNlist, sep = "")

yclk = seq(from = 400, to = 1600, by = 300)

yfps = c(seq(from = 30, to = 330, by = 30))
xfps = seq(30, to = 450, by = 30)

pstates = c(852, 991, 1084, 1138, 1200, 1401, 1536, 1630)
plabels = c("P0 - 852", "P1 - 991", "P2 - 1084", "P3 - 1138", "P4 - 1200", "P5 - 1401", "P6 - 1536", "P7 - 1630")

mstates = c(167, 500, 800, 945)
mlabels = c("P0 - 167", "P1 - 500", "P2 - 800", "P3 - 945")

ytimes = c(120, 60, 30, 20, 15, 12, 10)
ytimes = c(ytimes,-ytimes)

results = data.frame(matrix(ncol = 6, nrow = 0))

for (run in 1:length(COMlist)) {
	comreadOCAT = paste('OCAT_', NAMlist[run], ' = read_csv("', COMlist[run], ' - OCAT.csv")', sep = "")
	comreadADRN = paste('ADRN_', NAMlist[run], ' = read_csv("', COMlist[run], ' - ADRN.csv")', sep = "")
	eval(parse(text = comreadOCAT))
	eval(parse(text = comreadADRN))

	comreadRESULTS = paste("colnames(ADRN_", NAMlist[run], ") = gsub(' ', '', colnames(ADRN_", NAMlist[run], "))", sep = "")
	eval(parse(text = comreadRESULTS))
	#	handles the ADRN column names having spaces

	comreadRESULTS = paste("results = rbind(results, c('", NAMlist[run], "',
	min(ADRN_", NAMlist[run], "$GPUVRAMUTIL),
	mean(ADRN_", NAMlist[run], "$GPUVRAMUTIL),
	max(ADRN_", NAMlist[run], "$GPUVRAMUTIL),
	mean(ADRN_", NAMlist[run], "$GPUSCLK),
	mean(ADRN_", NAMlist[run], "$GPUPWR),
	mean(ADRN_", NAMlist[run], "$GPUTEMP),
	mean(ADRN_", NAMlist[run], "$GPUFAN),
	1000/mean(OCAT_", NAMlist[run], "$MsBetweenPresents),
	median(OCAT_", NAMlist[run], "$MsBetweenPresents),
	median(diff(OCAT_", NAMlist[run], "$MsBetweenPresents))), stringsAsFactors = FALSE)", sep = "")
	eval(parse(text = comreadRESULTS))
}
colnames(results) = c("RUN", "VRAMmin", "VRAMmean", "VRAMmax", "GPUCLK", "GPUPWR", "GPUTEMP", "GPUFAN", "FPSAVG", "FTIME", "FDIFF")
#results = sapply(results, as.character)
results[, 2:11] = sapply(results[, 2:11], as.numeric)
results[, 2:11] = round(results[, 2:11], 3)

OCAT = data.frame(matrix(ncol = 13, nrow = 0))
ADRN = data.frame(matrix(ncol = 9, nrow = 0))

for (run in NAMlist) {
	commandOCAT = paste("OCAT_", run, "$RUN <- rep('", run, "', nrow(OCAT_", run, "))", sep = "")
	commandADRN = paste("ADRN_", run, "$RUN <- rep('", run, "', nrow(ADRN_", run, "))", sep = "")
	eval(parse(text = commandOCAT))
	eval(parse(text = commandADRN))

	commandADRN = paste("ADRN_", run, "$TIME <- seq(from = 1, to = nrow(ADRN_", run, "))", sep = "")
	eval(parse(text = commandADRN))

	commandOCAT = paste("OCAT = rbind(OCAT, OCAT_", run, ")", sep = "")
	commandADRN = paste("ADRN = rbind(ADRN, ADRN_", run, ")", sep = "")
	eval(parse(text = commandOCAT))
	eval(parse(text = commandADRN))
}

OCAT$RUN = factor(OCAT$RUN, levels = NAMlist)
ADRN$RUN = factor(ADRN$RUN, levels = NAMlist)
#	sets grouping levels for use later

OCATf = OCAT
ADRNf = ADRN

OCATf$RUN = factor(OCAT$RUN, levels = rev(NAMlist))
ADRNf$RUN = factor(ADRN$RUN, levels = rev(NAMlist))
#	need to reverse the factor levels to get the order I want for faceted graphs

colnames(ADRN) = gsub(" ", "", colnames(ADRN))
#	Removes spaces from column names

write_csv(results, path = "@Combined.csv")
#	reads in all of the OCAT CSVs
#	also generates the data for @Combined.csv

write_csv(OCAT, "Combined OCAT.csv")
write_csv(ADRN, "Combined ADRN.csv")

pshape = 10
psize = 5
#	size and shape for the average points in some plots

options(error=expression(NULL))

pdf(NULL) #prevents rplots.pdf from being generated

#VRAM Maximum
if (TRUE){
scaleFP = 1 / 60
ggplot(na.rm = TRUE) +
ggtitle(paste("Comparison of VRAM Usage", setname, sep = ""), subtitle="Maximum GB") +
scale_fill_gradient2("VRAM (GB)", low="blue", mid = "green", midpoint = 4,  high="red", limits = c(0, 8), breaks = 1:4*2) +
geom_boxplot(data = OCAT, outlier.shape = NA, aes(x = RUN, y = 1000 / MsBetweenPresents * scaleFP)) +
geom_col(data = results, aes(x = RUN, y = VRAMmax, fill=VRAMmax)) +
geom_boxplot(data = OCAT, outlier.shape = NA, aes(x = RUN, y = 1000 / MsBetweenPresents * scaleFP), alpha = 0.25) +
geom_label(data = results, aes(label = VRAMmax, x = RUN, y = 0), vjust=-0.25) +
scale_y_continuous(name="VRAM Utilized (GB)", breaks=1:8, limits = c(0, 9), expand = c(0.02, 0)
, sec.axis = sec_axis(~., name = "Frame Rate (FPS)", breaks = (yfps * scaleFP), labels = yfps)) +
scale_x_discrete(name = "AA Option", limits = NAMlist, labels = substr(RUNlist, 6, 20)) +
geom_point(data = results, aes(x = RUN, y = FPSAVG * scaleFP), color = "black", shape = pshape, size = psize) +
theme(legend.position = c(1, 0.9))

if (pdf) {
		ggsave(filename=paste(gameF, " - VRAM.pdf", sep=""), device="pdf", width=16, height=9, dpi=DPI, scale = ggscale)
	} else {
		ggsave(filename=paste(gameF, " - VRAM.png", sep=""), device="png", width=16, height=9, dpi=DPI, scale = ggscale)
	}
}


#VRAM through Course
if (TRUE){
ggplot(na.rm = TRUE) +
ggtitle(paste("VRAM Usage Through Course", setname, sep = ""), subtitle="GB") +
scale_fill_gradient2("VRAM (GB)", low="blue", mid = "green", midpoint = 4,  high="red", limits = c(0, 8), breaks = 1:4*2) +
geom_col(data = ADRNf, aes(x = TIME, y = GPUVRAMUTIL, group=RUN, fill = GPUVRAMUTIL)) +
facet_grid(RUN ~., as.table = FALSE, drop = FALSE, labeller = labeller(RUN = NAMconv)) +
scale_x_continuous(name = "Time", breaks = seq(from = 0, to = 300, by = 60), expand=c(0.02, 0)) +
scale_y_continuous(name="VRAM (GB)", breaks = 0:4*2, limits = c(-0.5, 5), expand = c(0.01, 0), minor_breaks = NULL) +
theme(panel.spacing=unit(.1, "lines"), panel.border = element_rect(color = "blue", fill = NA, size = 1), strip.background = element_rect(color = "black", size = 1))

if (pdf) {
		ggsave(filename=paste(gameF, " - Course Facet - VRAM.pdf", sep=""), device="pdf", width=10, height=13.5, dpi=DPI, scale = ggscale)
	} else {
		ggsave(filename=paste(gameF, " - Course Facet - VRAM.png", sep=""), device="png", width=10, height=13.5, dpi=DPI, scale = ggscale)
	}
}

pstates = c(852, 991, 1084, 1138, 1200, 1401, 1536, 1630)
plabels = c("P0 - 852", "P1 - 991", "P2 - 1084", "P3 - 1138", "P4 - 1200", "P5 - 1401", "P6 - 1536", "P7 - 1630")

#GPU through Course
if (TRUE){
ggplot(na.rm = TRUE) +
ggtitle(paste("GPU Clock Through Course", setname, sep = ""), subtitle="MHz") +
scale_fill_gradient2(name = "MHz", low = "blue", mid = "green", midpoint = 1200,  high="red", limits = c(1100, 1600), breaks = pstates) + 
#scale_fill_gradient2("VRAM (GB)", low="blue", mid = "green", midpoint = 4,  high="red", limits = c(0, 8), breaks = 1:4*2) +
geom_col(data = ADRNf, aes(x = TIME, y = GPUSCLK, group=RUN, fill = GPUSCLK)) +
facet_grid(RUN ~., as.table = FALSE, drop = FALSE, labeller = labeller(RUN = NAMconv)) +
scale_x_continuous(name = "Time", breaks = seq(from = 0, to = 300, by = 60), expand=c(0.02, 0)) +
scale_y_continuous(name="GPU Clock Speed (MHz)", breaks = pstates, labels = plabels, limits=c(NA,1900), expand=c(0.02, 0), minor_breaks = NULL) + coord_cartesian(ylim = c(1100, 1700)) + 
#scale_y_continuous(name="VRAM (GB)", breaks = 0:4*2, limits = c(-0.5, 5), expand = c(0.01, 0), minor_breaks = NULL) +
theme(panel.spacing=unit(.1, "lines"), panel.border = element_rect(color = "blue", fill = NA, size = 1), strip.background = element_rect(color = "black", size = 1))

if (pdf) {
		ggsave(filename=paste(gameF, " - Course Facet - GPU.pdf", sep=""), device="pdf", width=10, height=13.5, dpi=DPI, scale = ggscale)
	} else {
		ggsave(filename=paste(gameF, " - Course Facet - GPU.png", sep=""), device="png", width=10, height=13.5, dpi=DPI, scale = ggscale)
	}
}

#Temp through Course
if (TRUE){
ggplot(na.rm = TRUE) +
ggtitle(paste("GPU Temperature Through Course", setname, sep = ""), subtitle="°C") +
scale_fill_gradient2(name = "°C", low = "blue", mid = "green", midpoint = 70,  high="red", limits = c(60, 90)) + 

geom_col(data = ADRNf, aes(x = TIME, y = GPUTEMP, group=RUN, fill = GPUTEMP)) +
facet_grid(RUN ~., as.table = FALSE, drop = FALSE, labeller = labeller(RUN = NAMconv)) +
scale_x_continuous(name = "Time", breaks = seq(from = 0, to = 300, by = 60), expand=c(0.02, 0)) +
scale_y_continuous(name="Temperature (°C)", breaks = c(25, 50, 75, 85), limits = c(0, 95), expand = c(0.01, 0), minor_breaks = NULL) +
theme(panel.spacing=unit(.1, "lines"), panel.border = element_rect(color = "blue", fill = NA, size = 1), strip.background = element_rect(color = "black", size = 1))

if (pdf) {
		ggsave(filename=paste(gameF, " - Course Facet - Temp.pdf", sep=""), device="pdf", width=10, height=13.5, dpi=DPI, scale = ggscale)
	} else {
		ggsave(filename=paste(gameF, " - Course Facet - Temp.png", sep=""), device="png", width=10, height=13.5, dpi=DPI, scale = ggscale)
	}
}

#Power through Course
if (TRUE){
ggplot(na.rm = TRUE) +
ggtitle(paste("GPU Power Through Course", setname, sep = ""), subtitle="Watts") +
scale_fill_gradient2(name = "Watts", low = "blue", mid = "green", midpoint = 150,  high="red", limits = c(0, 300), breaks = 0:4*75) + 
geom_col(data = ADRNf, aes(x = TIME, y = GPUPWR, group=RUN, fill = GPUPWR)) +
facet_grid(RUN ~., as.table = FALSE, drop = FALSE, labeller = labeller(RUN = NAMconv)) +
scale_x_continuous(name = "Time", breaks = seq(from = 0, to = 300, by = 60), expand=c(0.02, 0)) +
scale_y_continuous(name="ASIC Power (W)", breaks = 0:4*75, limits = c(0, 235)) + 
theme(panel.spacing=unit(.1, "lines"), panel.border = element_rect(color = "blue", fill = NA, size = 1), strip.background = element_rect(color = "black", size = 1))

if (pdf) {
		ggsave(filename=paste(gameF, " - Course Facet - Power.pdf", sep=""), device="pdf", width=10, height=13.5, dpi=DPI, scale = ggscale)
	} else {
		ggsave(filename=paste(gameF, " - Course Facet - Power.png", sep=""), device="png", width=10, height=13.5, dpi=DPI, scale = ggscale)
	}
}

#Frame Rate Distributions - Grouped
if (TRUE){
ggplot(OCAT, na.rm = TRUE) +
ggtitle(paste("Frequency Plot of Frame Rates", setname, sep = ""), subtitle="1000 * MsBetweenPresents^-1") +
geom_freqpoly(aes(1000 / MsBetweenPresents, group = RUN, color = RUN), binwidth=1, size=1) +
scale_x_continuous(name="Frame Rate (FPS)", breaks = xfps, expand=c(0.02, 0), limits = c(30, 450)) + expand_limits(x=c(30, 60)) + scale_y_continuous(name="Count", expand=c(0.02, 0)) +
labs(color = "AA Option") + scale_color_hue(labels = NAMEs)

if (pdf) {
		ggsave(filename=paste(gameF, " - FPS Grouped.pdf", sep=""), device="pdf", width=16, height=9, dpi=DPI, scale = ggscale)
	} else {
		ggsave(filename=paste(gameF, " - FPS Grouped.png", sep=""), device="png", width=16, height=9, dpi=DPI, scale = ggscale)
	}
}

#Frame Time Courses Faceted
if (TRUE){
ggplot(na.rm = TRUE) +
ggtitle(paste("Frame Times Through Course", setname, sep = ""), subtitle="MsBetweenPresents") +
geom_point(data = OCATf, aes(x = TimeInSeconds, y = MsBetweenPresents), color="black", alpha = 0.10) +
scale_y_continuous(name="Frame Time (ms)", breaks=c(0, round(1000/ytimes, 2)), limits=c(NA,1000/40), expand=c(0.02, 0), minor_breaks = NULL) +
scale_x_continuous(name="Time (s)", breaks=seq(from=0, to=signif(max(OCAT$TimeInSeconds, na.rm = TRUE), digits=1), by=60), expand=c(0.02, 0)) + expand_limits(y=c(0, 1000/30)) +
facet_grid(RUN ~ ., as.table = FALSE, drop = FALSE, labeller = labeller(RUN = NAMconv)) +
theme(panel.spacing=unit(.1, "lines"), panel.border = element_rect(color = "blue", fill = NA, size = 1), strip.background = element_rect(color = "black", size = 1))

#	ggsave(filename=paste(gameF, " - Course Facet - Frames.pdf", sep=""), device="pdf", width=10, height=13.5, dpi=DPI, scale = ggscale)
#	very large PDF, avoid
	ggsave(filename=paste(gameF, " - Course Facet - Frames.png", sep=""), device="png", width=10, height=13.5, dpi=DPI, scale = ggscale)
}

#Display Rate Distributions - Grouped
if (TRUE){
ggplot(OCAT, na.rm = TRUE) +
ggtitle(paste("Frequency Plot of Display Rates", setname, sep = ""), subtitle="MsBetweenDisplayChange") +
geom_freqpoly(aes(MsBetweenDisplayChange * 60 / 1000, group = RUN, color = RUN), binwidth=0.003, size=1) +
scale_x_continuous(name="Refresh Cycles Later (1 / 60 Hz)", breaks=seq(from=0, to=5, by=1), minor_breaks=NULL, limits=c(0, 1.1), expand=c(0.02, 0)) + expand_limits(x=c(0, 2)) + scale_y_continuous(name="Count", expand=c(0.02, 0)) +
labs(color = "AA Option") + scale_color_hue(labels = NAMEs)

if (pdf) {
		ggsave(filename=paste(gameF, " - FPS Grouped - Display.pdf", sep=""), device="pdf", width=16, height=9, dpi=DPI, scale = ggscale)
	} else {
		ggsave(filename=paste(gameF, " - FPS Grouped - Display.png", sep=""), device="png", width=16, height=9, dpi=DPI, scale = ggscale)
	}
}

#Display Time Courses Faceted
if (TRUE){
ggplot(na.rm = TRUE) +
ggtitle(paste("Display Times Through Course", setname, sep = ""), subtitle="MsBetweenDisplayChange") +
geom_point(data = OCATf, aes(x = TimeInSeconds, y = MsBetweenDisplayChange), color="black", alpha = 0.10) +
scale_y_continuous(name="Cycles Later (1 / 60 Hz)", breaks=c(0, 1000/60, 1000/30), labels=c(0, 1, 2), limits=c(NA,1000/31), expand=c(0.02, 0), minor_breaks = NULL) +
scale_x_continuous(name="Time (s)", breaks=seq(from=0, to=signif(max(OCAT$TimeInSeconds, na.rm = TRUE), digits=1), by=60), expand=c(0.02, 0)) + expand_limits(y=c(0, 1000/30)) +
#geom_hline(yintercept = c(quantile(OCAT$MsBetweenDisplayChange, c(.001, .01, .99, 0.999))), color="red") +
facet_grid(RUN ~ ., as.table = FALSE, drop = FALSE, labeller = labeller(RUN = NAMconv)) +
theme(panel.spacing=unit(.1, "lines"), panel.border = element_rect(color = "blue", fill = NA, size = 1), strip.background = element_rect(color = "black", size = 1))

#	ggsave(filename=paste(gameF, " - Course Facet - Display.pdf", sep=""), device="pdf", width=10, height=13.5, dpi=DPI, scale = ggscale)
#	very large PDF, avoid
	ggsave(filename=paste(gameF, " - Course Facet - Display.png", sep=""), device="png", width=10, height=13.5, dpi=DPI, scale = ggscale)
}

NAMlistF = c(
"None00",
"SSAA2x",
"SSAA4x",
"",
"FXAALw",
"FXAAMd",
"FXAAHi",
"FXAAUl",
"MSAA2x",
"MSAA4x",
"MSAA8x"
)

OCAT$RUN = factor(OCAT$RUN, levels = NAMlistF)
results$RUN = factor(results$RUN, levels = NAMlistF)

if (TRUE){
ggplot(data=OCAT, aes(x=MsBetweenPresents, y=rbind(c(diff(MsBetweenPresents), 0))[1,], group = RUN)) +
	ggtitle(paste("Frame Times vs Frame Time Difference (next frame)", setname, sep = ""), subtitle="MsBetweenPresents consecutive differences") +
#	annotate("rect", ymin=quantile(diff(MsBetweenPresents), c(.001, .010)), ymax=quantile(diff(MsBetweenPresents), c(.999, .990)), xmin=quantile(MsBetweenPresents, c(.001, .010)), xmax=quantile(MsBetweenPresents, c(.999, .990)), alpha=c(0.1, 0.075), fill=c("red", "blue")) +
#		does not work, would need to put quantile data in other object, don't care
	geom_point(alpha = 0.1) +
	# stat_density_2d(geom = "polygon", aes(fill = stat(nlevel), alpha = stat(nlevel)), show.legend = FALSE) + 	scale_fill_viridis_c() +
	stat_density_2d(geom = "polygon", aes(fill = stat(nlevel)), show.legend = FALSE) + 	scale_fill_viridis_c() +
	geom_point(data=results, aes(x=FTIME, y=FDIFF, group = RUN), color = "magenta", shape ="x", stat = "identity") +
	facet_wrap(RUN ~., as.table = TRUE, drop = FALSE, labeller = labeller(RUN = NAMconv)) +
	scale_x_continuous(name="Frame Time (ms)", breaks=seq(from=0, to=ceiling(1000/30), by=1000/120), labels=round(seq(from=0, to=ceiling(1000/30), by=1000/120), 2), limits=c(0, 1000/40), expand=c(0.02, 0), sec.axis = dup_axis()) +
	scale_y_continuous(name="Consecutive Frame Time Difference (ms)", breaks=c(0, round(1000/ytimes, 2)), limits=c(-1000/50, 1000/50), expand=c(0, 0))

#	ggsave(filename=paste(gameF, " - Time vs Diff Facet.pdf", sep=""), device="pdf", width=16, height=9, dpi=DPI, scale = ggscale)
#	very large PDF, avoid
	ggsave(filename=paste(gameF, " - Time vs Diff Facet.png", sep=""), device="png", width=16, height=9, dpi=DPI*2, scale = ggscale)
}

#Display Times instead
if (TRUE){
ggplot(data=OCAT, aes(x=MsBetweenDisplayChange, y=rbind(c(diff(MsBetweenDisplayChange), 0))[1,], group = RUN)) +
	ggtitle(paste("Display Times vs Display Time Difference (next frame)", setname, sep = ""), subtitle="MsBetweenDisplayChange consecutive differences") +
#	annotate("rect", ymin=quantile(diff(MsBetweenPresents), c(.001, .010)), ymax=quantile(diff(MsBetweenPresents), c(.999, .990)), xmin=quantile(MsBetweenPresents, c(.001, .010)), xmax=quantile(MsBetweenPresents, c(.999, .990)), alpha=c(0.1, 0.075), fill=c("red", "blue")) +
#		does not work, would need to put quantile data in other object, don't care
	geom_point(alpha = 0.1) +
	# stat_density_2d(geom = "polygon", aes(fill = stat(nlevel), alpha = stat(nlevel)), show.legend = FALSE) + 	scale_fill_viridis_c() +
	stat_density_2d(geom = "polygon", aes(fill = stat(nlevel)), show.legend = FALSE) + 	scale_fill_viridis_c() +
#	geom_point(data=results, aes(x=FTIME, y=FDIFF, group = RUN), color = "magenta", shape ="x", stat = "identity") +
	facet_wrap(RUN ~., as.table = TRUE, drop = FALSE, labeller = labeller(RUN = NAMconv)) +
	scale_x_continuous(name="Refresh Cycles Later (1 / 60 Hz)", breaks=seq(from=0, to=ceiling(1000/30), by=1000/120), labels=round(seq(from=0, to=2, by=0.5), 2), limits=c(0, 1000/40), expand=c(0.02, 0), sec.axis = dup_axis()) +
#	scale_x_continuous(name="Frame Time (ms)", breaks=seq(from=0, to=ceiling(1000/30), by=1000/120), labels=round(seq(from=0, to=ceiling(1000/30), by=1000/120), 2), limits=c(0, 1000/40), expand=c(0.02, 0)) +
	scale_y_continuous(name="Consecutive Display Time Difference (ms)", breaks=c(0, round(1000/ytimes, 2)), limits=c(-1000/50, 1000/50), expand=c(0, 0))

#	ggsave(filename=paste(gameF, " - Time vs Diff Facet.pdf", sep=""), device="pdf", width=16, height=9, dpi=DPI, scale = ggscale)
#	very large PDF, avoid
	ggsave(filename=paste(gameF, " - Time vs Diff Facet - Display.png", sep=""), device="png", width=16, height=9, dpi=DPI*2, scale = ggscale)
}
