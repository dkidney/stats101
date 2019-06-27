##############################################################################
##############################################################################

# Colinearity

##############################################################################
##############################################################################

require(mvtnorm)
require(lattice)
require(rgl)
require(car)

n <- 100

cor <- 0
cor <- 0.99

Sigma <- matrix(c(1, cor, cor, 1), nc=2) ; Sigma

X <- rmvnorm(n, mean=c(0,0), Sigma) ; head(X) ; dim(X)

x1 <- X[,1]

x2 <- X[,2]

par(mar=c(4,4,1,1), oma=c(0,0,0,0))

plot(x1, x2, pch=19, xlab="x1", ylab="x2", col="blue", xlim=c(-3,3), ylim=c(-3,3))

B0 <- B1 <- B2 <- 0.1

y <- B0 + B1*x1 + B2*x2 + rnorm(n, 0, 0.05)

if(0){
    par(mar = c(0,0,0,0), oma = c(0,0,0,0))
    par.set <- list(axis.line = list(col = "transparent"), clip = list(panel = "off"))
    cloud(y ~ x1 + x2, pch=19, xlim=c(-3,3), ylim=c(-3,3), col="blue", par.settings=par.set, distance = .3, zoom = 1.2, cex=1.1)
    plot3d(x1, x2, y, col="blue", type="s", radius=0.1,  xlim=c(-3,3), ylim=c(-3,3))
    play3d(spin3d(axis = c(0,0,1), rpm = 4), duration = 60)
}

model <- lm(y ~ x1 + x2)

summary(model)

vif(model)

sqrt(vif(model))

x.seq <- seq(-3, 3, length=10)

preds <- outer(x.seq, x.seq, function(x,y) predict(model, data.frame(x1=x, x2=y)))

par(mar = c(0,0,0,0), oma = c(0,0,0,0))

res <- persp(x.seq, x.seq, preds, theta=320, phi=30, r=4, xlab="x1", ylab="x2", zlab="y", xlim=c(-3,3), ylim=c(-3,3))

points(trans3d(x1, x2, y, res), pch=19, col="blue")

if(0){
    plot3d(x1, x2, y, col="blue", type="s", radius=0.1,  xlim=c(-3,3), ylim=c(-3,3))
    surface3d(x.seq, x.seq, preds, color="#FF2222", alpha=0.25, add=TRUE)
    surface3d(x.seq, x.seq, preds, color="grey", back="lines", front="lines", add=TRUE)
    play3d(spin3d(axis = c(0,0,1), rpm = 4), duration = 60)
}

print(summary(model))

