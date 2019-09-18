library(ggplot2)
#	based on the Python code from https://en.wikipedia.org/wiki/File:AliasingSines.svg

sin.1	=	function(x)	sin(x * 2 * pi * 0.1)
sin.9	=	function(x)	sin(x * 2 * pi * 0.9)

samps	=	function(LEN = NULL, BY = NULL, stoc = FALSE, STOC = FALSE, END = 10, ...)	{
	ARGS	=	list(...)
	#	using ... to accept additional arguments is helpful but they need to be used, which this does without impacting anything
	if	(is.null(LEN)	&	is.null(BY)		&	!stoc)	{
		out	=	seq(-1, END) + 0.5
	}
	if	(!is.null(LEN)	&	is.null(BY)		&	!stoc)	{
		out	=	seq(-1, END, length.out = LEN) + 0.5
	}
	if	(is.null(LEN)	&	!is.null(BY)	&	!stoc)	{
		# out	=	seq(-1, END, by = BY) + 0.5
		out	=	c(seq(0, -1, by = -BY), seq(0, END, by = BY)) + 0.5
		#	I want it to always have the point 0.5
	}
	if	(stoc	&	!STOC)	{
		out	=	stocs
	}
	if	(STOC)	{
		out	=	STOCS(END)
	}
	return(unique(sort(out)))
}


# sin.9FL	=	function(END = 10, BY = 1, func = mean)	{
	# mean = box,	TRIAG = triangle,	GAUSS = gaussian
	# out	=	matrix(seq(-1, END-1/BY, by = 1/BY)+1/(2*BY), ncol = BY, byrow = TRUE)
	# out	=	apply(sin.9(out), 1, func)
	# return(out)
# }

# TRIAG	=	function(DATA)	{
	# len = length(DATA)
	# weighted.mean(DATA, 0:(len - 1)/len + 1/(2*len))
# }

# GAUSS	=	function(DATA)	{
	# len = length(DATA)
	# weighted.mean(DATA, pnorm(0:(len - 1)/len + 1/(2*len)))
# }
#	nice to have and I think it will work, but I do not want to try incorporating it

if	(interactive())	{
	setwd("E:/Users/Jim/My Documents/OCC/@Reviews/Serious Statistics AA/@1.1 Stuff")
}	else	{
	pdf(NULL)
}

theme_set(theme_grey(base_size = 22))

gWIDTH	=	16
gHEIGH	=	9
DPI		=	120

customSave	=	function(type="", device=ggdevice, plot = last_plot(), width=gWIDTH, height=gHEIGH, dpi=DPI)	{
	if	(device	==	"png"	|	device == "both")	{
		ggsave(filename=paste0("Alias Example - ", type, ".png"), plot = plot, device="png", width=width, height=height, dpi=dpi)
	}
	if	(device	==	"pdf"	|	device == "both")	{
		ggsave(filename=paste0("Alias Example - ", type, ".pdf"), plot = plot, device="pdf", width=width, height=height)
	}
}


POINTS		=	function(CLR = "magenta", OFF = 0, ...)	{
	geom_point(	data = data.frame(x = samps(...) + OFF), aes(x, y = sin.9(x)), color = CLR, size = 2)
}
LINES		=	function(lineCLR = "black", lineSIZE = 0, OFF = 0, ...)		{
	geom_path(	data = data.frame(x = samps(...) + OFF), aes(x, y = sin.9(x)), color = lineCLR, size = lineSIZE)
}
RUG			=	function(CLR = "magenta", OFF = 0, ...)	{
	geom_rug(data = data.frame(x = samps(...) + OFF), aes(x), color = CLR, size = 1)
}

COMBINED	=	function(...)	{
	list(
		LINES(	...),
		POINTS(	...),
		RUG(	...)
	)
	#	separate layers can be added as a list like this
}

FUN	=	function(func, samples = 5000, CLR)	{
	stat_function(aes(x = samps()), fun = func, n = samples, color = CLR) 
}

GRAD	=	function(func = sin.9, stoc = FALSE, STOC = FALSE, OFF = 0, hOFF = 0, vOFF = 0, WID = 1, CLR = "black", ...)	{
	list(
		geom_rect(aes(
				xmin	=	min(samps(...)) - hOFF - WID / 2,
				xmax	=	max(samps(...)) + hOFF + WID / 2,
				ymin	=	-1 - vOFF,
				ymax	=	-1 - 0.25 - vOFF	),
			fill = "white",
			color = "black"
			),
		geom_rect(aes(
				xmin	=	samps(...) - hOFF - WID / 2,
				xmax	=	samps(...) + hOFF + WID / 2,
				ymin	=	-1 - 0 - vOFF,
				ymax	=	-1 - 0.25 - vOFF	),
			alpha	=	(func(samps(stoc = stoc, STOC = STOC, ...) + OFF) / 2 + 0.5),
			fill	=	CLR
			)
	)
}

scales	=	list(
	scale_x_continuous(breaks = 0:10, name = "X"),
	scale_y_continuous(breaks = -2:2/2, name = "Y"),
	coord_cartesian(xlim = c(-1, 11))
	)

THEME	=	theme(panel.background = element_blank(), plot.background = element_rect(fill = "#dfdfdf"))


COMBINED	=	function(stoc = FALSE, ...)	{
	list(
		LINES(		stoc = stoc),
		POINTS(		stoc = stoc),
		RUG(		stoc = stoc)
	)
	#	separate layers can be added as a list like this
}


#Samples
ggplot() + 
COMBINED(	) + 
scales + THEME

customSave("Sine Samples", "both")

ggplot() + 
GRAD(		) + 
COMBINED(	) + 
scales + THEME

customSave("Sine Samples - Grad", "both")

#Samples + Sin 0.1
ggplot() + 
FUN(sin.1, 10000, "red") +
COMBINED(	END = 20) + 
scales + THEME

customSave("Sine Samples - 0.1", "both")

ggplot() + 
GRAD(		vOFF = 0.25) + 
GRAD(		func = sin.1, LEN = 10000, WID = 11/10000, CLR = "red") + 
FUN(sin.1, 10000, "red") +
COMBINED(	) + 
scales + THEME

customSave("Sine Samples - 0.1 - Grad", "both")

#Samples + Sin 0.9
ggplot() + 
FUN(sin.9, 10000, "blue") +
COMBINED(	) + 
scales + THEME

customSave("Sine Samples - 0.9", "both")

ggplot() + 
GRAD(		vOFF = 0.25) + 
GRAD(		func = sin.9, LEN = 10000, WID = 11/10000, CLR = "blue") + 
FUN(sin.9, 10000, "blue") +
COMBINED(	) + 
scales + THEME

customSave("Sine Samples - 0.9 - Grad", "both")


#Sine Waves
ggplot() +
FUN(sin.1, 10000, "red") +
FUN(sin.9, 10000, "blue") +
COMBINED() + 
scales + THEME

customSave("Sine Waves", "both")


ggplot() +
GRAD(	func = sin.1,	LEN = 10000,	WID = 11/10000,				CLR = "red") + 
GRAD(													vOFF = 0.25) + 
GRAD(	func = sin.9,	LEN = 10000,	WID = 11/10000,	vOFF = 0.5,	CLR = "blue") + 
FUN(sin.1, 10000, "red") +
FUN(sin.9, 10000, "blue") +
COMBINED() + 
scales + THEME

customSave("Sine Waves - Grad", "both")

#	Offsets with legend
ggplot() +
GRAD(		OFF = -0.25, 				CLR = "red") + 
GRAD(					vOFF = 0.25,	CLR = "magenta") + 
GRAD(		OFF = 0.25,	vOFF = 0.5,	CLR = "cyan") + 
COMBINED(	OFF = -0.25,	CLR = "red",	lineCLR = "darkgrey") +
COMBINED(	) + 
COMBINED(	OFF = 0.25,		CLR = "cyan",	lineCLR = "darkgrey") + 
scales + THEME + 
scale_color_manual(guide = "legend", name = "Offset", values = c("0" = "magenta", "+0.25" = "cyan", "-0.25" = "red"), labels = c("+0.25", "0", "-0.25")) + 
#	for this to work I am adding generic points with the aesthetics including a color so the scale will work
geom_point(aes(x = -Inf, y = -Inf, color = "-0.25")) +
geom_point(aes(x = -Inf, y = -Inf, color = "0")) +
geom_point(aes(x = -Inf, y = -Inf, color = "+0.25")) +
geom_point(aes(x = -Inf, y = -Inf), color = "#dfdfdf")
#	this last one covers the points

customSave("Temporal", "both")

LEN	=	4096
END	=	48

ggplot() + 
GRAD(		func = sin.1,	LEN = LEN,		WID = (END + 1)/LEN,	vOFF = 0.00,	CLR = "red",	END = END) + 
GRAD(		BY = 1.0,						WID = 1.0,				vOFF = 0.25,					END = END) +
GRAD(		BY = 0.5,						WID = 0.5,				vOFF = 0.50,					END = END) +
GRAD(		BY = (1/0.9)/2,					WID = (1/0.9)/2,		vOFF = 0.75,					END = END) +
GRAD(		BY = (1/0.9)/4,					WID = (1/0.9)/4,		vOFF = 1.00,					END = END) +
GRAD(		func = sin.9,	LEN = LEN,		WID = (END + 1)/LEN,	vOFF = 1.25,	CLR = "blue",	END = END) + 
scale_x_continuous(name = NULL, breaks = NULL) + 
scale_y_continuous(name = NULL, breaks = -(0:5/4)-1.125, labels = c(
	"sin(0.1x + .5)",
	"Width: 1.0",
	"Width: 0.5",
	"Width: 0.5556",
	"Width: 0.2778",
	"sin(0.9x + .5)"
)) + coord_cartesian(expand = FALSE) + 
THEME + theme(axis.text.y=element_text(hjust = 0))

customSave("Rate Comparison", "both")

#	Nyquist stuff, just use BY
NS = (1/0.9)/2
NS = (1/0.9)/1.25
NS = 1

NyquistGraph	=	function(NS)	{
	ggplot() + 
	GRAD(		BY = NS,						WID = NS, END = 10) +
	GRAD(		func = sin.9,	LEN = 10000,	WID = 11/10000,	vOFF = 0.25,	CLR = "blue", END = 10) + 
	FUN(sin.9, 10000, "blue") +
	COMBINED(	BY = NS, lineSIZE = 1.5) +
	scales + THEME
}
NyquistGraph(0.75)

customSave("Nyquist - Rate", "both",	NyquistGraph(1/(0.9*2)))
customSave("Nyquist - Rate x2", "both",	NyquistGraph(1/(0.9*4)))

#	Stochastic
STOCS	=	function(END = 10)	{
	-1:END + 0.5 + runif(2 + END, -0.5, 0.5)
}

END	=	1694/2
LEN	=	1694*3
END	=	360		#	original value used

store = STOCS(END)
stocs = store[1:362]	#	for use with END = 360	
stocs = store


ggplot() + 
GRAD(		func = sin.1,	LEN = LEN,		WID = (END + 1)/LEN,	vOFF = 0.00,	CLR = "red",	END = END) + 
GRAD(		BY = 1.0,						WID = 1.0,				vOFF = 0.25,					END = END) +
GRAD(		stoc = TRUE,											vOFF = 0.50,					END = END) +
GRAD(		func = sin.9,	LEN = LEN,		WID = (END + 1)/LEN,	vOFF = 0.75,	CLR = "blue",	END = END) + 
scale_x_continuous(name = NULL, breaks = NULL) + 
scale_y_continuous(name = NULL, breaks = -(0:3/4)-1-0.125, labels = c(
	"sin(0.1x + .5)",
	"Width: 1", 
	"Stochastic",
	"sin(0.9x + .5)"
)) + coord_cartesian(expand = FALSE) + 
THEME + theme(axis.text.y=element_text(hjust = 0))

customSave("Stochastic Comparison", "both")							#	with END = 360
customSave("Stochastic Comparison - Pixel", "both", height = 1.5)	#	with END = 1694/2

#	to make a comparison of multiple stochastic placements, save the plots to variables, and then combine them
#		saving the plots this way protects them from changes
stocs = store[1:12]
ggplot() + 
GRAD(		BY = 1.0,						WID = 1.0,				vOFF = 0.00,					END = END) +
GRAD(		stoc = TRUE,											vOFF = 0.25) +
GRAD(		func = sin.9,	LEN = LEN,		WID = (END + 1)/LEN,	vOFF = 0.50,	CLR = "blue",	END = END) + 
COMBINED(	stoc = TRUE) +
FUN(sin.9, 10000, "blue") +
scales + THEME

customSave("Stochastic", "both")
