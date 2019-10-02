library(ggplot2)
#	the coordinates for the sample positions are based on the DirectX standard sampling positions found here:
#		https://docs.microsoft.com/en-us/windows/win32/api/d3d11/ne-d3d11-d3d11_standard_multisample_quality_levels
#	Microsoft uses an upside-down Y-axis in those patterns, but that is corrected here

FAC2NUM	=	function(FRAME, COLS)	{
	for (place in COLS)	{
		FRAME[, place]	=	as.numeric(as.character(FRAME[, place]))
	}
	return(FRAME)
}

if	(interactive())	{
	setwd("E:/Users/Jim/My Documents/OCC/@Reviews/Serious Statistics AA/@1.1 Stuff/Sampling Patterns 1.1/R Output")
}	else	{
	pdf(NULL)
}

theme_set(theme_grey(base_size = 22))

gWIDTH	=	16
gHEIGH	=	9
DPI		=	120

customSave	=	function(type="", device=ggdevice, plot = last_plot(), width=gWIDTH, height=gHEIGH, dpi=DPI)	{
	if	(device	==	"png"	|	device == "both")	{
		ggsave(filename=paste0("Sample Patterns - ", type, ".png"), plot = plot, device="png", width=width, height=height, dpi=dpi)
	}
	if	(device	==	"pdf"	|	device == "both")	{
		ggsave(filename=paste0("Sample Patterns - ", type, ".pdf"), plot = plot, device="pdf", width=width, height=height)
	}
}

BORD	=	list(
	geom_segment(x = -8,	xend = 8,	y = 8,	yend = 8,												size = 1),
	geom_segment(x = -8,	xend = 8,	y = 0,	yend = 0,	color = "darkgrey",							size = 1),
	geom_segment(x = -8,	xend = -8,	y = -8,	yend = 8,												size = 1),
	geom_segment(x = -8,	xend = 8,	y = -8,	yend = -8,						linetype = "dashed",	size = 1),
	geom_segment(x = 0,		xend = 0,	y = -8,	yend = 8,	color = "darkgrey",							size = 1),
	geom_segment(x = 8,		xend = 8,	y = -8,	yend = 8,						linetype = "dashed",	size = 1)
)


AXES = function(SAMPLE = 16)	{
	list(
		scale_x_continuous(name = NULL, limits = c(-8, 8), breaks = seq(-8, 7, by = 16/SAMPLE), minor_breaks = NULL, labels = NULL, expand = c(0,0)), 
		scale_y_continuous(name = NULL, limits = c(-8, 8), breaks = seq(-8, 7, by = 16/SAMPLE), minor_breaks = NULL, labels = NULL, expand = c(0,0)), 
		scale_color_manual(guide = "legend", name = "", values = c("Sample" = "red", "Tap" = "cyan"), breaks = c("Sample", "Tap")),
		theme(legend.position = c(1, 0.98), legend.direction="horizontal", legend.justification = c(1,-1), legend.background = element_rect(NA)),
		coord_fixed(ratio = 1),
		theme(axis.ticks = element_blank())
	)
}

LINES	=	list(
	geom_hline(aes(yintercept = y),							color = "blue",	linetype = "dashed",	size = 2), 
	geom_vline(aes(xintercept = x),							color = "blue",	linetype = "dashed",	size = 2), 
	geom_abline(aes(slope = Slope, intercept = Intercept),	color = "blue", linetype = "dashed",	size = 2)
)


ORDER2x	=	c("Vertical", "Horizontal", "Diagonal (Down)", "Diagonal (Up)", "Quincunx")
DATA2x	=	as.data.frame(rbind(
	c(0,	4,		"Vertical",			"Sample"),
	c(0,	-4,		"Vertical",			"Sample"),
	
	c(-4,	0,		"Horizontal",		"Sample"),
	c(4,	0,		"Horizontal",		"Sample"),
	
	c(-4,	4, 		"Diagonal (Down)",	"Sample"),
	c(4,	-4, 	"Diagonal (Down)",	"Sample"),
	
	c(-4,	-4, 	"Diagonal (Up)",	"Sample"),
	c(4,	4, 		"Diagonal (Up)",	"Sample"),
	
	c(-8,	8,		"Quincunx",			"Sample"),
	c(0,	0,		"Quincunx",			"Sample"),
	c(-8,	-8,		"Quincunx",			"Tap"),
	c(8,	-8,		"Quincunx",			"Tap"),
	c(8,	8,		"Quincunx",			"Tap")
)	)
LINES2x = as.data.frame(rbind(
	c(0, 	NA,	NA,	NA,	"Vertical"),
	c(NA,	0,	NA,	NA,	"Horizontal"),
	c(NA,	NA,	-1,	0,	"Diagonal (Down)"),
	c(NA,	NA,	1,	0,	"Diagonal (Up)"),
	c(NA,	NA,	NA,	NA,	"Quincunx")
)	)

DATA2x		=	FAC2NUM(DATA2x, 1:2)
DATA2x[,3]	=	factor(DATA2x[,3], levels = ORDER2x, ordered = TRUE)
colnames(DATA2x)	=	c("x", "y", "Pattern", "Type")

LINES2x	=	FAC2NUM(LINES2x, 1:4)
LINES2x[,5]	=	factor(LINES2x[,5], levels = ORDER2x, ordered = TRUE)
colnames(LINES2x)	=	c("x", "y", "Slope", "Intercept", "Pattern")

SAMPLE	=	2

ggplot(data = LINES2x, aes(x = x, y = y)) + 
ggtitle("2x Sample Patterns") + 
BORD + LINES + 
geom_point(data = DATA2x, aes(color = Type), size = 7) + 
facet_grid(cols = vars(Pattern)) + AXES(SAMPLE)

customSave("2x", "both")


ORDER4x	=	c("Ordered", "Rotated", "Diagonal", "Rook (1)", "Rook (2)", "Queen", "Quincunx")
D	=	8/sqrt(2)
DATA4x	=	as.data.frame(rbind(
	c(-4,	4,		"Ordered",	"",				"Sample"),
	c(-4,	-4,		"Ordered",	"",				"Sample"),
	c(4,	-4,		"Ordered",	"",				"Sample"),
	c(4,	4,		"Ordered",	"",				"Sample"),
	
	c(-D,	0,		"Rotated",	"",				"Sample"),
	c(D,	0,		"Rotated",	"",				"Sample"),
	c(0,	-D,		"Rotated",	"",				"Sample"),
	c(0,	D,		"Rotated",	"",				"Sample"),
	
	c(-6,	6,	"Diagonal",	"",				"Sample"),
	c(-2,	2,	"Diagonal",	"",				"Sample"),
	c(2,	-2,	"Diagonal",	"",				"Sample"),
	c(6,	-6,	"Diagonal",	"",				"Sample"),
	
	c(-6,	-6,	"Diagonal",	"Reflection",	"Sample"),
	c(-2,	-2,	"Diagonal",	"Reflection",	"Sample"),
	c(2,	2,	"Diagonal",	"Reflection",	"Sample"),
	c(6,	6,	"Diagonal",	"Reflection",	"Sample"),
	
	c(-6,	6,		"Rook (1)",	"",				"Sample"),
	c(-2,	-2,		"Rook (1)",	"",				"Sample"),
	c(2,	2,		"Rook (1)",	"",				"Sample"),
	c(6,	-6,		"Rook (1)",	"",				"Sample"),
	
	c(-6,	-6,		"Rook (1)",	"Reflection",	"Sample"),
	c(-2,	2,		"Rook (1)",	"Reflection",	"Sample"),
	c(2,	-2,		"Rook (1)",	"Reflection",	"Sample"),
	c(6,	6,		"Rook (1)",	"Reflection",	"Sample"),
	
	c(-6,	2,		"Rook (2)",	"",				"Sample"),
	c(-2,	6,		"Rook (2)",	"",				"Sample"),
	c(2,	-6,		"Rook (2)",	"",				"Sample"),
	c(6,	-2,		"Rook (2)",	"",				"Sample"),
	
	c(-6,	-2,		"Rook (2)",	"Reflection",	"Sample"),
	c(-2,	-6,		"Rook (2)",	"Reflection",	"Sample"),
	c(2,	6,		"Rook (2)",	"Reflection",	"Sample"),
	c(6,	2,		"Rook (2)",	"Reflection",	"Sample"),
	
	c(-6,	-2,		"Queen",	"",				"Sample"),
	c(-2,	6,		"Queen",	"",				"Sample"),
	c(2,	-6,		"Queen",	"",				"Sample"),
	c(6,	2,		"Queen",	"",				"Sample"),
	
	c(-6,	2,		"Queen",	"Reflection",	"Sample"),
	c(-2,	-6,		"Queen",	"Reflection",	"Sample"),
	c(2,	6,		"Queen",	"Reflection",	"Sample"),
	c(6,	-2,		"Queen",	"Reflection",	"Sample"),
	
	c(-8,	8,		"Quincunx",	"",				"Sample"),
	c(-8,	0,		"Quincunx",	"",				"Sample"),
	c(0,	8,		"Quincunx",	"",				"Sample"),
	c(0,	0,		"Quincunx",	"",				"Sample"),
	c(-8,	-8,		"Quincunx",	"",				"Tap"),
	c(0,	-8,		"Quincunx",	"",				"Tap"),
	c(8,	-8,		"Quincunx",	"",				"Tap"),
	c(8,	0,		"Quincunx",	"",				"Tap"),
	c(8,	8,		"Quincunx",	"",				"Tap")
)	)
LINES4x = as.data.frame(rbind(
	c(4, 	NA,		NA,	NA,		"Ordered", ""),
	c(-4,	NA,		NA,	NA,		"Ordered", ""),
	c(NA,	4,		NA,	NA,		"Ordered", ""),
	c(NA,	-4,		NA,	NA,		"Ordered", ""),
	
	c(NA, 	NA,		1,	D,		"Rotated", ""),
	c(NA,	NA,		1,	-D,		"Rotated", ""),
	c(NA,	NA,		-1,	-D,		"Rotated", ""),
	c(NA,	NA,		-1,	D,		"Rotated", ""),
	
	c(NA, 	NA,		-1,	0,		"Diagonal", ""),
	c(NA, 	NA,		1,	0,		"Diagonal", "Reflection"),
	
	c(NA, 	NA,		NA,	NA,		"Rook (1)",	""),
	c(NA, 	NA,		NA,	NA,		"Rook (1)",	"Reflection"),
	c(NA, 	NA,		NA,	NA,		"Rook (2)",	""),
	c(NA, 	NA,		NA,	NA,		"Rook (2)",	"Reflection"),
	c(NA, 	NA,		NA,	NA,		"Queen",	""),
	c(NA, 	NA,		NA,	NA,		"Queen",	"Reflection"),
	c(NA, 	NA,		NA,	NA,		"Quincunx",	"")
)	)

DATA4x		=	FAC2NUM(DATA4x, 1:2)
DATA4x[,3]	=	factor(DATA4x[,3], levels = ORDER4x, ordered = TRUE)
colnames(DATA4x)	=	c("x", "y", "Pattern", "Reflection", "Type")

LINES4x	=	FAC2NUM(LINES4x, 1:4)
colnames(LINES4x)	=	c("x", "y", "Slope", "Intercept", "Pattern", "Reflection")
LINES4x[,5]	=	factor(LINES4x[,5], levels = ORDER4x, ordered = TRUE)

SAMPLE	=	4

ggplot(data = LINES4x, aes(x = x, y = y)) + 
ggtitle("4x Sample Patterns") + 
BORD + LINES + 
geom_point(data = DATA4x, aes(color = Type), size = 7) + 
facet_grid(cols = vars(Pattern), rows = vars(Reflection)) + AXES(SAMPLE)

customSave("4x", "both", width = 7/5*16)


ORDERMS	=	c("2x", "4x", "8x", "16x")
DATAMS	=	as.data.frame(rbind(
	c(-4,	4,	"2x"),
	c(4,	-4,	"2x"),
	
	c(-6,	-2,	"4x"),
	c(-2,	6,	"4x"),
	c(2,	-6,	"4x"),
	c(6,	2,	"4x"),
	
	c(-7,	1,	"8x"),
	c(-5,	-5,	"8x"),
	c(-3,	5,	"8x"),
	c(-1,	-3,	"8x"),
	c(1,	3,	"8x"),
	c(3,	-7,	"8x"),
	c(5,	-1,	"8x"),
	c(7,	7,	"8x"),
	
	c(-8,	0,	"16x"),
	c(-7,	8,	"16x"),
	c(-6,	-4,	"16x"),
	c(-5,	2,	"16x"),
	c(-4,	6,	"16x"),
	c(-3,	-2,	"16x"),
	c(-2,	-6,	"16x"),
	c(-1,	3,	"16x"),
	c(0,	7,	"16x"),
	c(1,	-1,	"16x"),
	c(2,	-5,	"16x"),
	c(3,	5,	"16x"),
	c(4,	1,	"16x"),
	c(5,	-3,	"16x"),
	c(6,	7,	"16x"),
	c(7,	4,	"16x")
)	)

LINESMS = as.data.frame(rbind(
	c(NA, 	NA,		NA,	NA,		"2x",	""),
	c(NA, 	NA,		NA,	NA,		"4x",	""),
	c(NA, 	NA,		NA,	NA,		"8x",	""),
	c(NA, 	NA,		NA,	NA,		"16x",	"")
)	)

DATAMS		=	FAC2NUM(DATAMS, 1:2)
DATAMS[,3]	=	factor(DATAMS[,3], levels = ORDERMS, ordered = TRUE)
colnames(DATAMS)	=	c("x", "y", "Pattern")

LINESMS	=	FAC2NUM(LINESMS, 1:4)
colnames(LINESMS)	=	c("x", "y", "Slope", "Intercept", "Pattern")
LINESMS[,5]	=	factor(LINESMS[,5], levels = ORDERMS, ordered = TRUE)


ggplot(data = LINESMS, aes(x = x, y = y)) + 
ggtitle("DirectX Standard Sample Patterns") + 
BORD + LINES + 
geom_point(data = DATAMS, color = "red", size = 7) + 
facet_grid(cols = vars(Pattern)) + AXES()

customSave("MS Standard Patterns", "both", width = 4/5*16)


NAMES	=	c("x", "y", "Pattern", "Type")

QUADS	=	function(FRAME, Type)	{
	UL	=	cbind(FRAME,							Type,	"Sample")
	UR	=	cbind(FRAME[,1] + 16,	FRAME[,2],		Type,	"Tap")
	LL	=	cbind(FRAME[,1],		FRAME[,2] - 16,	Type,	"Tap")
	LR	=	cbind(FRAME[,1] + 16,	FRAME[,2] - 16,	Type,	"Tap")


	colnames(UL)	=	NAMES
	colnames(UR)	=	NAMES
	colnames(LL)	=	NAMES
	colnames(LR)	=	NAMES
	return(rbind(UL, UR, LL, LR))
}

AXESpd = list(
	scale_x_continuous(name = NULL, limits = c(-8, 8+16), breaks = -7:(8+16), minor_breaks = NULL, labels = NULL, expand = c(0,0)), 
	scale_y_continuous(name = NULL, limits = c(-8-16, 8), breaks = (-7-16):8, minor_breaks = NULL, labels = NULL, expand = c(0,0)), 
	scale_color_manual(guide = "legend", name = "", values = c("Sample" = "red", "Tap" = "cyan"), breaks = c("Sample", "Tap")),
	theme(legend.position = c(1, 0.95), legend.direction="horizontal", legend.justification = c(1,-1), legend.background = element_rect(NA)),
	coord_fixed(ratio = 1),
	theme(axis.ticks = element_blank())
)


PD8x	=	as.data.frame(rbind(
	c(-7,	1),
	c(-5,	-5),
	c(-3,	5),
	c(-1,	-3),
	c(1,	3),
	c(3,	-7),
	c(5,	-1),
	c(7,	7)
)	)

PD16x	=	as.data.frame(rbind(
	c(-8,	0),
	c(-7,	8),
	c(-6,	-4),
	c(-5,	2),
	c(-4,	6),
	c(-3,	-2),
	c(-2,	-6),
	c(-1,	3),
	c(0,	7),
	c(1,	-1),
	c(2,	-5),
	c(3,	5),
	c(4,	1),
	c(5,	-3),
	c(6,	-7),
	c(7,	4)
)	)

MSPD	=	rbind(QUADS(PD8x, "8x"), QUADS(PD16x, "16x"))

MSPD		=	FAC2NUM(MSPD, 1:2)
MSPD[,3]	=	factor(MSPD[,3], levels = ORDERMS, ordered = TRUE)

ggplot(data = MSPD, aes(x = x, y = y)) + 
ggtitle("DirectX Standard Sample Patterns (Poisson Disk)") + 
BORD +
geom_point(data = MSPD[MSPD$Pattern == "8x",],	color = "black",	size = 28,		shape = 1) + 
geom_point(data = MSPD[MSPD$Pattern == "16x",],	color = "black",	size = 23,	shape = 1) + 
geom_point(aes(color = Type),	size = 7) + 
facet_grid(cols = vars(Pattern)) + AXESpd + theme(legend.position = "none")

customSave("Poisson Disks", "both", width = 4/5*16)
