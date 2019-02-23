library(mmand)
library(ggplot2)

setwd("E:/Users/Jim/My Documents/OCC/@Reviews/Serious Statistics AA/Blend Filters/")

#Box

#Tent

#Quadratic

#Cubic

#Gauss
pdf("Gaussian.pdf")
plot(dnorm, -3.5, 3.5, xlab = "", ylab = "", ylim = c(-0.04, 1))
dev.off()

#Catmull-Rom
pdf("Catmull-Rom.pdf")
plot(mitchellNetravaliKernel(0, 1/2), ylim = c(-0.04, 1))
dev.off()

#Mitchell-Netravali
pdf("Mitchell-Netravali.pdf")
plot(mitchellNetravaliKernel(1/3, 1/3), ylim = c(-0.04, 1))
dev.off()
