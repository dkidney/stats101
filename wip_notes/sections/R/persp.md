<a id="top"></a> 
## persp

********************************************************************************

<a href="#theta">theta</a> 
<a href="#phi">phi</a>
<a href="#r">r</a>
<a href="#d">d</a>
<a href="#ltheta">ltheta</a> 
<a href="#lphi">lphi</a>
<a href="#col">col</a>
<a href="#border">border</a>

********************************************************************************

This behaves a bit like <a href="image.html">image</a> in that it needs at least three arguments:

* **x** - a vector of unique x-values
* **y** - a vector of unique y-values
* **z** - a matrix of z-values

<a id="kde2d"></a> 


```r
set.seed(3)
x = rnorm(500)
y = rnorm(500)
par(mfrow = c(1, 3), mar = c(2, 2, 2, 2), oma = c(0, 0, 0, 0))
plot(x, y, asp = 1)
suppressMessages(require(MASS))
n = 30
f = kde2d(x, y, n = n)  # kernel density estimation
x = f$x
y = f$y
z = f$z
contour(x, y, z, asp = 1)
persp(x, y, z)
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1.png) 


********************************************************************************
<a id="theta"></a>

### theta

This rotates the figure theta degrees clockwise about the **vertical** axis.


```r
par(mfrow = c(2, 3), mar = c(2, 2, 2, 2), oma = c(0, 0, 0, 0))
for (i in seq(0, 90, length = 6)) persp(x, y, z, theta = i, main = paste("theta =", 
    i), phi = 15, d = 5)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 


<a href="#top">[back to top]</a> 

********************************************************************************
<a id="phi"></a>

### phi

This rotates the figure phi degrees about the **horizontal** axis.


```r
par(mfrow = c(2, 3), mar = c(2, 2, 2, 2), oma = c(0, 0, 0, 0))
for (i in seq(0, 90, length = 6)) persp(x, y, z, phi = i, main = paste("phi =", 
    i), d = 5)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 


<a href="#top">[back to top]</a> 

********************************************************************************
<a id="r"></a>

### r

This controls the **perspective**.


```r
par(mfrow = c(2, 3), mar = c(2, 2, 2, 2), oma = c(0, 0, 0, 0))
for (i in seq(0, 3, length = 6)) persp(x, y, z, r = i, main = paste("r =", i))
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 


<a href="#top">[back to top]</a> 

********************************************************************************
<a id="d"></a>

### d

This also controls the **perspective**.


```r
par(mfrow = c(2, 3), mar = c(2, 2, 2, 2), oma = c(0, 0, 0, 0))
for (i in seq(0.1, 3, length = 6)) persp(x, y, z, d = i, main = paste("d =", 
    i))
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5.png) 


<a href="#top">[back to top]</a> 

********************************************************************************
<a id="shade"></a>

### shade

This controls the degree of **contrast** between lit areas and unlit areas.


```r
par(mfrow = c(2, 3), mar = c(2, 2, 2, 2), oma = c(0, 0, 0, 0))
for (i in seq(0.1, 0.6, length = 6)) persp(x, y, z, shade = i, main = paste("shade =", 
    i), theta = 0, phi = 90, border = NA, box = FALSE, d = 10)
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6.png) 


<a href="#top">[back to top]</a> 

********************************************************************************
<a id="ltheta"></a>

### ltheta

This controls the angle of **lighting** about the **vertical** axis (relative to the surface).


```r
par(mfrow = c(2, 3), mar = c(2, 2, 2, 2), oma = c(0, 0, 0, 0))
for (i in seq(0, 180, length = 6)) persp(x, y, z, shade = 0.75, ltheta = i, 
    main = paste("ltheta =", i), theta = 0, phi = 90, border = NA, box = FALSE, 
    d = 10)
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7.png) 


<a href="#top">[back to top]</a> 

********************************************************************************
<a id="lphi"></a>

### lphi

This controls the angle of **lighting** about the **horizontal** axis (relative to the plotting area). I think phi = 0 means that the light is coming from the bottom, and phi = 180 means it's coming from the top.


```r
par(mfrow = c(2, 3), mar = c(2, 2, 2, 2), oma = c(0, 0, 0, 0))
for (i in seq(0, 180, length = 6)) persp(x, y, z, shade = 0.75, lphi = i, main = paste("lphi =", 
    i), theta = 30, phi = 30, border = NA, box = FALSE, d = 10)
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8.png) 


<a href="#top">[back to top]</a> 

********************************************************************************
<a id="col"></a>

### col

You can use simple colors.


```r
par(mar = c(2, 2, 2, 2), oma = c(0, 0, 0, 0))
persp(x, y, z, col = "lightblue", theta = 45, phi = 30, shade = 0.5, ltheta = 160, 
    d = 3, expand = 0.5)
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 


Complicated colours are more difficult. You can give a vector of colours that is the same length as the number of grid squares but it's quite tricky, since the number of grid squares is (nx-1)(ny-1). 


```r
par(mar = c(2, 2, 2, 2), oma = c(0, 0, 0, 0))
persp(x, y, z, col = rep(1:(n - 1), each = n - 1), phi = 90, d = 100)
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10.png) 


So to get colours for each of the grid squares you need to find the height of the centre of each grid square.


```r
# function to make a vector of colours
persp.cols = function(z, ncols = 10) {
    grid.means <- (z[-1, -1] + z[-1, -ncol(z)] + z[-nrow(z), -1] + z[-nrow(z), 
        -ncol(z)])/4
    heat.colors(ncols)[cut(grid.means, ncols)]
}

par(mar = c(2, 2, 2, 2), oma = c(0, 0, 0, 0))
persp(x, y, z, col = persp.cols(z, 10), theta = 45, phi = 30, shade = 0.5, ltheta = 160, 
    d = 3, expand = 0.5)
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11.png) 


<a href="#top">[back to top]</a> 

********************************************************************************
<a id="border"></a>

### border


```r
par(mar = c(2, 2, 2, 2), oma = c(0, 0, 0, 0))
persp(x, y, z, col = "grey", theta = 45, phi = 30, shade = 1, ltheta = 160, 
    d = 3, expand = 0.5, border = "green")
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12.png) 


********************************************************************************

<a href="../R functions.html">[back to R functions]</a> 

<a href="../index.html">[back to Index]</a> 

