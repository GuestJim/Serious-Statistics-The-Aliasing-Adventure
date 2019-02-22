library(ggplot2)
#	based on the Python code from https://en.wikipedia.org/wiki/File:AliasingSines.svg

sam1000 = seq(-1, 10, length.out = 1000) + 0.5
fun1000 = sam1000 * 2 * pi
sam0010 = -1:10 + 0.5
fun0010 = sam0010 * 2 * pi

FUN9 = function(x) sin((x) * 2 * pi * 0.9)
FUN9g = function(x) sin((x) * 2 * pi * 0.9) + 1
FUN1 = function(x) sin((x) * 2 * pi * 0.1)
FUN1g = function(x) sin((x) * 2 * pi * 0.1) + 1

stp0010 = (max(sam0010) - min(sam0010)) / (length(sam0010) - 1)
stp1000 = (max(sam1000) - min(sam1000)) / (length(sam1000) - 1)

#	makes 1000 samples between 0 and 10
#		the + 0.5 is needed for ideal alignment

theme_set(theme_grey(base_size = 22))
pdf(NULL) #prevents rplots.pdf from being generated

ggplot() + 
geom_rug(aes(x =sam0010), color = "magenta", size = 1) + 
geom_path(aes(x=sam0010, y = sin(fun0010 * 0.9))) +
geom_point(aes(x=sam0010, y = sin(fun0010 * 0.9)), color = "magenta", size = 3) + 
scale_x_continuous(breaks = (0:10), name="X", limits = c(-1, 11)) + scale_y_continuous(name="Y") +
theme(panel.background = element_blank(), plot.background = element_rect(fill = "#dfdfdf"))

ggsave(filename="Alias Example - Sin Samples.pdf", device="pdf", width=16, height=9)
ggsave(filename="Alias Example PNGs\\Alias Example - Sin Samples.png", device="png", width=16, height=9)

ggplot() + 
geom_rug(aes(x = sam0010), color = "magenta", size = 1) + 
geom_path(aes(x=sam0010, y = sin(fun0010 * 0.9) + 1)) +
geom_rect(aes(xmin = min(sam0010) - 0.5, xmax = max(sam0010) + 0.5, ymin = -0.25, ymax = 0), fill = "white") + 
geom_col(aes(x = sam0010, y = -0.25), width = stp0010, fill = "black", alpha = (sin(fun0010 * 0.9) / 2 + 0.5)) +
geom_point(aes(x=sam0010, y = sin(fun0010 * 0.9) + 1), color = "magenta", size = 2) + 
scale_x_continuous(breaks = (0:10), name="X", limits = c(-1, 11)) +
scale_y_continuous(name="Y", breaks = c(0, 0.5, 1, 1.5, 2), labels = c("-1.0", "-0.5", "0.0", "0.5", "1.0")) +
theme(panel.background = element_blank(), plot.background = element_rect(fill = "#dfdfdf"))

ggsave(filename="Alias Example - Sin Samples 0.1 - Grad.pdf", device="pdf", width=16, height=9)
ggsave(filename="Alias Example PNGs\\Alias Example - Sin Samples 0.1 - Grad.png", device="png", width=16, height=9)

ggplot() + 
#geom_rug(aes(x = sam1000), color = "magenta", size = 0.25) + 
geom_path(aes(x=sam1000, y = sin(fun1000 * 0.9) + 1), color = "blue") +
geom_rect(aes(xmin = min(sam1000) - stp1000/2, xmax = max(sam1000) + stp1000/2, ymin = -0.25, ymax = 0), fill = "white") + 
geom_col(aes(x = sam1000, y = -0.25), width = stp1000, fill = "black", alpha = (sin(fun1000 * 0.9) / 2 + 0.5)) +
#geom_point(aes(x=sam1000, y = sin(fun1000 * 0.9) + 1), color = "magenta", size = 2) + 
scale_x_continuous(breaks = (0:10), name="X", limits = c(-1, 11)) +
scale_y_continuous(name="Y", breaks = c(-1, -0.5, 0, 0.5, 1) + 1, labels = c("-1.0", "-0.5", "0.0", "0.5", "1.0")) +
theme(panel.background = element_blank(), plot.background = element_rect(fill = "#dfdfdf"))

ggsave(filename="Alias Example - Sin Samples 0.9 - Grad.pdf", device="pdf", width=16, height=9)
ggsave(filename="Alias Example PNGs\\Alias Example - Sin Samples 0.9 - Grad.png", device="png", width=16, height=9)

ggplot() + 
#geom_vline(xintercept = (0:10 + 0.5), alpha=0.25) + 
geom_rug(aes(x = -1:10 + 0.5), color = "magenta", size = 1) + 
geom_path(aes(x=sam0010, y = sin(fun0010 * 0.1))) +
stat_function(data = data.frame(x = 0), mapping = aes(x = x), fun = FUN1, n = 10000, color = "red") + 
#geom_path(aes(x=sam1000, y = sin(fun1000 * 0.1)), color = "red") + 
#geom_path(aes(x=sam1000, y = sin(fun1000 * 0.9)), color = "blue") +
geom_point(aes(x=sam0010, y = sin(fun0010 * 0.1)), color = "magenta", size = 2) + 
scale_x_continuous(breaks = (0:10), name="X", limits = c(-1, 11)) + scale_y_continuous(name="Y") +
theme(panel.background = element_blank(), plot.background = element_rect(fill = "#dfdfdf"))

ggsave(filename="Alias Example - Sin Waves - 0.1.pdf", device="pdf", width=16, height=9)
ggsave(filename="Alias Example PNGs\\Alias Example - Sin Samples 0.1.png", device="png", width=16, height=9)

ggplot() + 
#geom_vline(xintercept = (0:10 + 0.5), alpha=0.25) + 
geom_rug(aes(x = -1:10 + 0.5), color = "magenta", size = 1) + 
geom_path(aes(x=sam0010, y = sin(fun0010 * 0.1))) +
#stat_function(data = data.frame(x = 0), mapping = aes(x = x), fun = FUN1, n = 10000, color = "red") +
#geom_path(aes(x=sam1000, y = sin(fun1000 * 0.1)), color = "red") + 
stat_function(data = data.frame(x = 0), mapping = aes(x = x), fun = FUN9, n = 10000, color = "blue") + 
#geom_path(aes(x=sam1000, y = sin(fun1000 * 0.9)), color = "blue") +
geom_point(aes(x=sam0010, y = sin(fun0010 * 0.1)), color = "magenta", size = 2) + 
scale_x_continuous(breaks = (0:10), name="X", limits = c(-1, 11)) + scale_y_continuous(name="Y") +
theme(panel.background = element_blank(), plot.background = element_rect(fill = "#dfdfdf"))

ggsave(filename="Alias Example - Sin Waves - 0.9.pdf", device="pdf", width=16, height=9)
ggsave(filename="Alias Example PNGs\\Alias Example - Sin Samples 0.9.png", device="png", width=16, height=9)

ggplot() + 
#geom_vline(xintercept = (0:10 + 0.5), alpha=0.25) + 
geom_rug(aes(x = -1:10 + 0.5), color = "magenta", size = 1) + 
geom_path(aes(x=sam0010, y = sin(fun0010 * 0.1))) +
stat_function(data = data.frame(x = 0), mapping = aes(x = x), fun = FUN1, n = 10000, color = "red") + 
stat_function(data = data.frame(x = 0), mapping = aes(x = x), fun = FUN9, n = 10000, color = "blue") +
geom_point(aes(x=sam0010, y = sin(fun0010 * 0.1)), color = "magenta", size = 2) + 
scale_x_continuous(breaks = (0:10), name="X", limits = c(-1, 11)) + scale_y_continuous(name="Y") +
theme(panel.background = element_blank(), plot.background = element_rect(fill = "#dfdfdf"))

ggsave(filename="Alias Example - Sin Waves.pdf", device="pdf", width=16, height=9)
ggsave(filename="Alias Example PNGs\\Alias Example - Sin Waves.png", device="png", width=16, height=9)

ggplot() + 
geom_rug(aes(x = -1:10 + 0.5), color = "magenta", size = 1) + 
geom_rect(aes(xmin = min(sam1000) - stp1000/2, xmax = max(sam1000) + stp1000/2, ymin = -0.75, ymax = -0.5), fill = "white") + 
geom_col(aes(x = sam1000, y = -0.75), width = stp1000, fill = "blue", alpha = (sin(fun1000 * 0.9) / 2 + 0.5)) +

geom_rect(aes(xmin = min(sam0010) - 0.49, xmax = max(sam0010) + 0.49, ymin = -0.5, ymax = -0.25), fill = "white") + 
geom_rect(aes(xmin = sam0010 - stp0010/2, xmax = sam0010 + stp0010/2, ymin = -0.5, ymax = -0.25), fill = "black", alpha = (sin(fun0010 * 0.9) / 2 + 0.5)) + 
#geom_col(aes(x = sam0010, y = -0.5), width = stp0010, fill = "black", alpha = (sin(fun0010 * 0.9) / 2 + 0.5)) +

geom_rect(aes(xmin = min(sam1000) - stp1000/2, xmax = max(sam1000) + stp1000/2, ymin = -0.25, ymax = 0), fill = "white") + 
geom_col(aes(x = sam1000, y = -0.25), width = stp1000, fill = "red", alpha = (sin(fun1000 * 0.1) / 2 + 0.5)) +

geom_path(aes(x=sam0010, y = sin(fun0010 * 0.1) + 1)) +
stat_function(data = data.frame(x = 0), mapping = aes(x = x), fun = FUN1g, n = 10000, color = "red") + 
stat_function(data = data.frame(x = 0), mapping = aes(x = x), fun = FUN9g, n = 10000, color = "blue") +
geom_point(aes(x=sam0010, y = sin(fun0010 * 0.1) + 1), color = "magenta", size = 2) + 
scale_x_continuous(breaks = (0:10), name="X", limits = c(-1, 11)) + 
scale_y_continuous(name="Y", breaks = c(0, 0.5, 1, 1.5, 2), labels = c("-1.0", "-0.5", "0.0", "0.5", "1.0")) +
theme(panel.background = element_blank(), plot.background = element_rect(fill = "#dfdfdf"))

ggsave(filename="Alias Example - Sin Waves - Grad.pdf", device="pdf", width=16, height=9)
ggsave(filename="Alias Example PNGs\\Alias Example - Sin Waves - Grad.png", device="png", width=16, height=9)
#	manually edit the graphic here, so the height of the sample gradient is correct

sin((0:10 + 0.5) * 2*pi * 0.1)
sin((0:10 + 0.5) * 2*pi * 0.9)

round(sin((0:10 + 0.5) * 2*pi * 0.1) - sin((0:10 + 0.5) * 2*pi * 0.9), 14)
#	going to more than 14 decimal places does show the differences

samPP25 = seq(-1, 10) + 0.5 + 0.25
funPP25 = samPP25 * 2 * pi

samPN25 = seq(-1, 10) + 0.5 - 0.25
funPN25 = samPN25 * 2 * pi

ggplot() + 
scale_color_manual(guide = "legend", values = c("-0.25" = "red", "0" = "magenta",  "+0.25" = "cyan" ), breaks = c("-0.25", "0", "+0.25"), labels = c("-0.25", "0", "+0.25")) + 
geom_rug(aes(x = samPP25), color = "cyan", size = 2) + 
geom_rug(aes(x = sam0010), color = "magenta", size = 2) + 
geom_rug(aes(x = samPN25), color = "red", size = 2) + 
geom_path(aes(x=samPP25, y = sin(funPP25 * 0.9)), color = "gray") +
geom_point(aes(x=samPP25, y = sin(funPP25 * 0.9), color = "+0.25"), size = 2) + 
geom_path(aes(x=samPN25, y = sin(funPN25 * 0.9)), color = "gray") +
geom_point(aes(x=samPN25, y = sin(funPN25 * 0.9), color = "-0.25"), size = 2) + 
stat_function(data = data.frame(x = 0), mapping = aes(x = x), fun = FUN1, n = 10000, color = "black") + 
geom_point(aes(x=sam0010, y = sin(fun0010 * 0.9), color = "0"), size = 2) +
scale_x_continuous(breaks = (0:10), name="X", limits = c(-1, 11)) + scale_y_continuous(name="Y") + labs(color = "Offset") + 
theme(panel.background = element_blank(), plot.background = element_rect(fill = "#dfdfdf"))

ggsave(filename="Alias Example - Sin Popping.pdf", device="pdf", width=16, height=9)
ggsave(filename="Alias Example PNGs\\Alias Example - Sin Popping.png", device="png", width=16, height=9)

ggplot() + 
scale_color_manual(guide = "legend", values = c("-0.25" = "red", "0" = "magenta",  "+0.25" = "cyan" ), breaks = c("-0.25", "0", "+0.25"), labels = c("-0.25", "0", "+0.25")) + 
geom_rug(aes(x = samPP25), color = "cyan", size = 2) + 
geom_rug(aes(x = sam0010), color = "magenta", size = 2) + 
geom_rug(aes(x = samPN25), color = "red", size = 2) + 

geom_rect(aes(xmin = min(sam0010) - 0.5, xmax = max(sam0010) + 0.5, ymin = -0.75, ymax = -0.5), fill = "white") + 
geom_col(aes(x = samPP25 - 0.25, y = -0.75), width = stp0010, fill = "cyan", alpha = (sin(funPP25 * 0.9) / 2 + 0.5)) +

geom_rect(aes(xmin = min(sam0010) - 0.5, xmax = max(sam0010) + 0.5, ymin = -0.5, ymax = -0.25), fill = "white") + 
geom_col(aes(x = sam0010, y = -0.5), width = stp0010, fill = "magenta", alpha = (sin(fun0010 * 0.9) / 2 + 0.5)) +

geom_rect(aes(xmin = min(sam0010) - 0.5, xmax = max(sam0010) + 0.5, ymin = -0.25, ymax = 0), fill = "white") + 
geom_col(aes(x = samPN25 + 0.25, y = -0.25), width = stp0010, fill = "red", alpha = (sin(funPN25 * 0.9) / 2 + 0.5)) +
#	above are the gradients
geom_point(aes(x=samPP25, y = sin(funPP25 * 0.9) + 1, color = "+0.25"), size = 2) + 
geom_point(aes(x=sam0010, y = sin(fun0010 * 0.9) + 1, color = "0"), size = 2) +
geom_point(aes(x=samPN25, y = sin(funPN25 * 0.9) + 1, color = "-0.25"), size = 2) + 
geom_path(aes(x=samPP25, y = sin(funPP25 * 0.9) + 1), color = "gray") +
stat_function(data = data.frame(x = 0), mapping = aes(x = x), fun = FUN1g, n = 10000, color = "black") + 
geom_path(aes(x=samPN25, y = sin(funPN25 * 0.9) + 1), color = "gray") +
#	above are the plots
scale_x_continuous(breaks = (0:10), name="X", limits = c(-1, 11)) + labs(color = "Offset") + 
scale_y_continuous(name="Y", breaks = c(-1, -0.5, 0, 0.5, 1) + 1, labels = c("-1.0", "-0.5", "0.0", "0.5", "1.0")) +
theme(panel.background = element_blank(), plot.background = element_rect(fill = "#dfdfdf"))

ggsave(filename="Alias Example - Sin Popping - Grad.pdf", device="pdf", width=16, height=9)
ggsave(filename="Alias Example PNGs\\Alias Example - Sin Popping - Grad.png", device="png", width=16, height=9)


SUPsam = data.frame(c(samPN25, sam0010, samPP25), sin(c(funPN25, fun0010, funPP25) * 0.9))
colnames(SUPsam) = c("x", "y")
SUPsam = SUPsam[order(SUPsam$x),]

ggplot() + 
scale_color_manual(guide = "legend", values = c("0" = "magenta", "+0.25" = "cyan", "-0.25" = "red"), labels = c("-0.25", "+0.25", "0")) + 
geom_rug(aes(x = -1:10 + 0.5 + 0.25), color = "cyan", size = 2) + 
geom_rug(aes(x = -1:10 + 0.5), color = "magenta", size = 2) + 
geom_rug(aes(x = -1:10 + 0.5 - 0.25), color = "red", size = 2) + 
geom_path(aes(x=SUPsam$x, y = SUPsam$y), color = "black", size = 1) + 
stat_function(data = data.frame(x = 0), mapping = aes(x = x), fun = FUN9, n = 10000, color = "blue") + 
geom_point(aes(x=samPP25, y = sin(funPP25 * 0.9), color = "+0.25"), size = 2) + 
geom_point(aes(x=samPN25, y = sin(funPN25 * 0.9), color = "-0.25"), size = 2) + 
geom_point(aes(x=sam0010, y = sin(fun0010 * 0.9), color = "0"), size = 2) +
#geom_point(aes(x=sam0010, y = sin(fun0010 * 0.9), color = "0"), size = 2) +
scale_x_continuous(breaks = (0:10), name="X", limits = c(-1, 11)) + scale_y_continuous(name="Y") + labs(color = "Offset") + 
theme(panel.background = element_blank(), plot.background = element_rect(fill = "#dfdfdf"))

ggsave(filename="Alias Example - Sin Super.pdf", device="pdf", width=16, height=9)
ggsave(filename="Alias Example PNGs\\Alias Example - Sin Super.png", device="png", width=16, height=9)

#	The below shows the Nyquist Limit, with NY50 being below the limit, and NY45 being the limit
samNY50 = seq(-1, 10, 0.5) + 0.5
funNY50 = samNY50 * 2 * pi

ggplot() + 
#geom_vline(xintercept = (0:10 + 0.5), alpha=0.25) + 
geom_rug(aes(x = samNY50), color = "magenta", size = 1) + 
#geom_path(aes(x=sam1000, y = sin(fun1000 * 0.9)), color = "blue", size = 1.5) +
stat_function(data = data.frame(x = 0), mapping = aes(x = x), fun = FUN9, n = 10000, color = "blue", size = 1.5) + 
#geom_path(aes(x=sam1000, y = sin(fun1000 * 0.1)), color = "red", size = 1) +
#geom_path(aes(x=sam1000, y = -sin(fun1000 * 0.1)), color = "red", size = 1) +
geom_path(aes(x=samNY50, y = sin(funNY50 * 0.9)), size = 2) +
geom_point(aes(x=samNY50, y = sin(funNY50 * 0.9)), color = "magenta", size = 2) + 
scale_x_continuous(breaks = (0:10), name="X", limits = c(-1, 11)) + scale_y_continuous(name="Y") +
theme(panel.background = element_blank(), plot.background = element_rect(fill = "#dfdfdf"))

ggsave(filename="Alias Example - Sin Nyquist 50.pdf", device="pdf", width=16, height=9)
ggsave(filename="Alias Example PNGs\\Alias Example - Sin Nyquist 50.png", device="png", width=16, height=9)


ggplot() + 
#geom_vline(xintercept = (0:10 + 0.5), alpha=0.25) + 
geom_rug(aes(x = samNY50), color = "magenta", size = 1) + 

geom_rect(aes(xmin = min(sam1000) - stp1000/2, xmax = max(sam1000) + stp1000/2, ymin = -0.5, ymax = -0.25), fill = "white") + 
geom_col(aes(x = sam1000, y = -.5), width = stp1000, fill = "blue", alpha = (sin(fun1000 * 0.9) / 2 + 0.5)) +

geom_rect(aes(xmin = min(samNY50) - 0.25, xmax = max(samNY50) + 0.25, ymin = -0.25, ymax = 0), fill = "white") + 
geom_col(aes(x = samNY50, y = -0.25), width = 0.5, fill = "black", alpha = (sin(funNY50 * 0.9) / 2 + 0.5)) +

stat_function(data = data.frame(x = 0), mapping = aes(x = x), fun = FUN9g, n = 10000, color = "blue", size = 1.5) + 
geom_path(aes(x=samNY50, y = sin(funNY50 * 0.9) + 1), size = 2) +
geom_point(aes(x=samNY50, y = sin(funNY50 * 0.9) + 1), color = "magenta", size = 2) + 
scale_x_continuous(breaks = (0:10), name="X", limits = c(-1, 11)) + 
scale_y_continuous(name="Y", breaks = c(-1, -0.5, 0, 0.5, 1) + 1, labels = c("-1.0", "-0.5", "0.0", "0.5", "1.0")) +
theme(panel.background = element_blank(), plot.background = element_rect(fill = "#dfdfdf"))

ggsave(filename="Alias Example - Sin Nyquist 50 - Grad.pdf", device="pdf", width=16, height=9)
ggsave(filename="Alias Example PNGs\\Alias Example - Sin Nyquist 50 - Grad.png", device="png", width=16, height=9)


samNY45 = seq(-1, 10, 0.45) + 0.5
funNY45 = samNY45 * 2 * pi

ggplot() + 
#geom_vline(xintercept = (0:10 + 0.5), alpha=0.25) + 
geom_rug(aes(x = samNY45), color = "magenta", size = 1) + 
#geom_path(aes(x=sam1000, y = sin(fun1000 * 0.9)), color = "blue", size = 2) +
stat_function(data = data.frame(x = 0), mapping = aes(x = x), fun = FUN9, n = 10000, color = "blue", size = 2) + 
geom_path(aes(x=samNY45, y = sin(funNY45 * 0.9)), size = 2) +
geom_point(aes(x=samNY45, y = sin(funNY45 * 0.9)), color = "magenta", size = 2) + 
scale_x_continuous(breaks = (0:10), name="X", limits = c(-1, 11)) + scale_y_continuous(name="Y") +
theme(panel.background = element_blank(), plot.background = element_rect(fill = "#dfdfdf"))

ggsave(filename="Alias Example - Sin Nyquist 45.pdf", device="pdf", width=16, height=9)
ggsave(filename="Alias Example PNGs\\Alias Example - Sin Nyquist 45.png", device="png", width=16, height=9)


ggplot() + 
geom_rug(aes(x = samNY45), color = "magenta", size = 1) + 

geom_rect(aes(xmin = min(sam1000) - stp1000/2, xmax = max(sam1000) + stp1000/2, ymin = -0.5, ymax = -0.25), fill = "white") + 
geom_col(aes(x = sam1000, y = -.5), width = stp1000, fill = "blue", alpha = (sin(fun1000 * 0.9) / 2 + 0.5)) +

geom_rect(aes(xmin = min(samNY45) - 0.225, xmax = max(samNY45) + 0.225, ymin = -0.25, ymax = 0), fill = "white") + 
geom_col(aes(x = samNY45, y = -0.25), width = 0.45, fill = "black", alpha = (sin(funNY45 * 0.9) / 2 + 0.5)) +

stat_function(data = data.frame(x = 0), mapping = aes(x = x), fun = FUN9g, n = 10000, color = "blue", size = 2) + 
geom_path(aes(x=samNY45, y = sin(funNY45 * 0.9) + 1), size = 2) +
geom_point(aes(x=samNY45, y = sin(funNY45 * 0.9) + 1), color = "magenta", size = 2) + 
scale_x_continuous(breaks = (0:10), name="X", limits = c(-1, 11)) + 
scale_y_continuous(name="Y", breaks = c(-1, -0.5, 0, 0.5, 1) + 1, labels = c("-1.0", "-0.5", "0.0", "0.5", "1.0")) +
theme(panel.background = element_blank(), plot.background = element_rect(fill = "#dfdfdf"))

ggsave(filename="Alias Example - Sin Nyquist 45 - Grad.pdf", device="pdf", width=16, height=9)
ggsave(filename="Alias Example PNGs\\Alias Example - Sin Nyquist 45 - Grad.png", device="png", width=16, height=9)


#	Stochastic sampling		add random offsets
runif(10, -0.5, 0.5)
#	generates 10 random numbers from -0.5 to 0.5

samRand = -1:10 + 0.5 + runif(12, -0.5, 0.5)
funRand = samRand * 2 * pi

ggplot() + 
geom_rug(aes(x = samRand), color = "magenta", size = 1) + 
geom_rug(aes(x = sam0010), color = "cyan", size = 1) + 

geom_rect(aes(xmin = min(sam1000) - stp1000/2, xmax = max(sam1000) + stp1000/2, ymin = -0.75, ymax = -0.5), fill = "white") + 
geom_col(aes(x = sam1000, y = -0.75), width = stp1000, fill = "blue", alpha = (sin(fun1000 * 0.9) / 2 + 0.5)) +

geom_rect(aes(xmin = min(sam0010) - 0.5, xmax = max(sam0010) + 0.5, ymin = -0.5, ymax = -0.25), fill = "white") + 
geom_col(aes(x = sam0010, y = -0.5), width = stp0010, fill = "black", alpha = (sin(funRand * 0.9) / 2 + 0.5)) +

geom_rect(aes(xmin = min(sam0010) - 0.5, xmax = max(sam0010) + 0.5, ymin = -0.25, ymax = 0), fill = "white") + 
geom_col(aes(x = sam0010, y = -0.25), width = stp0010, fill = "red", alpha = (sin(fun0010 * 0.9) / 2 + 0.5)) +

stat_function(data = data.frame(x = 0), mapping = aes(x = x), fun = FUN1g, n = 10000, color = "red", size = 2) + 
stat_function(data = data.frame(x = 0), mapping = aes(x = x), fun = FUN9g, n = 10000, color = "blue", size = 2) +
geom_point(aes(x=sam0010, y = sin(fun0010 * 0.9) + 1), color = "cyan", size = 2) + 
geom_path(aes(x=samRand, y = sin(funRand * 0.9) + 1), size = 2) +
geom_point(aes(x=samRand, y = sin(funRand * 0.9) + 1), color = "magenta", size = 2) + 
scale_x_continuous(breaks = (0:10), name="X", limits = c(-1, 11)) +
scale_y_continuous(name="Y", breaks = c(-1, -0.5, 0, 0.5, 1) + 1, labels = c("-1.0", "-0.5", "0.0", "0.5", "1.0")) +
theme(panel.background = element_blank(), plot.background = element_rect(fill = "#dfdfdf"))

ggsave(filename="Alias Example - Sin Rand 100.pdf", device="pdf", width=16, height=9)
ggsave(filename="Alias Example PNGs\\Alias Example - Sin Rand 100.png", device="png", width=16, height=9)

#comparing NYquist 50 to Stochastic
Samstep = 0.5
samRand = seq(-1, 10, Samstep) + 0.5
samRand = samRand + runif(length(samRand), -Samstep/2, Samstep/2)
funRand = samRand * 2 * pi

ggplot() + 
geom_rug(aes(x = samRand), color = "magenta", size = 1) + 
geom_rug(aes(x = samNY50), color = "cyan", size = 1) + 

geom_rect(aes(xmin = min(sam1000) - stp1000/2, xmax = max(sam1000) + stp1000/2, ymin = -0.75, ymax = -0.5), fill = "white") + 
geom_col(aes(x = sam1000, y = -0.75), width = stp1000, fill = "blue", alpha = (sin(fun1000 * 0.9) / 2 + 0.5)) +

geom_rect(aes(xmin = min(samNY50) - 0.25, xmax = max(samNY50) + 0.25, ymin = -0.5, ymax = -0.25), fill = "white") + 
geom_col(aes(x = samNY50, y = -0.5), width = Samstep, fill = "black", alpha = (sin(funRand * 0.9) / 2 + 0.5)) +

geom_rect(aes(xmin = min(samNY50) - 0.25, xmax = max(samNY50) + 0.25, ymin = -0.25, ymax = 0), fill = "white") + 
geom_col(aes(x = samNY50, y = -0.25), width = Samstep, fill = "red", alpha = (sin(funNY50 * 0.9) / 2 + 0.5)) +

geom_path(aes(x=samNY50, y = sin(funNY50 * 0.9) + 1), size = 1, color = "red") +
stat_function(data = data.frame(x = 0), mapping = aes(x = x), fun = FUN9g, n = 10000, color = "blue", size = 1) +
geom_point(aes(x=samNY50, y = sin(funNY50 * 0.9) + 1), size = 2, color = "cyan") + 
geom_path(aes(x=samRand, y = sin(funRand * 0.9) + 1), size = 2) +
geom_point(aes(x=samRand, y = sin(funRand * 0.9) + 1), color = "magenta", size = 2) + 

scale_x_continuous(breaks = (0:10), name="X", limits = c(-1, 11)) +
scale_y_continuous(name="Y", breaks = c(-1, -0.5, 0, 0.5, 1) + 1, labels = c("-1.0", "-0.5", "0.0", "0.5", "1.0")) +
theme(panel.background = element_blank(), plot.background = element_rect(fill = "#dfdfdf"))

ggsave(filename="Alias Example - Sin Rand 50 - Grad.pdf", device="pdf", width=16, height=9)
ggsave(filename="Alias Example PNGs\\Alias Example - Sin Rand 50 - Grad.png", device="png", width=16, height=9)
