
## Delta method

********************************************************************************

This is a method for obtaining the variance of a function of estimated parameters.

$$
\widehat{\mbox{Var}}\left[ f\left( \widehat{\theta} \right) \right] = 
\left( \frac{\partial f }{ \partial\theta } \right)_{\theta=\widehat{\theta}}^T
\; \widehat{\mbox{Cov}}\left[ \widehat{\theta} \right] \;
\left( \frac{\partial f }{ \partial\theta } \right)_{\theta=\widehat{\theta}}
$$

where,

$\theta$ is a parameter vector estimated by $\widehat{\theta}$

$\widehat{\mbox{Cov}}\left[ \widehat{\theta} \right]$ is the estimated variance covariance matrix for the estimated parameters

and,

$$
\left( \frac{\partial f }{ \partial\theta } \right) =
\begin{pmatrix}
    \frac{\partial f }{ \partial\theta_1 } \\ 
    \frac{\partial f }{ \partial\theta_2 } \\ 
    \vdots 
\end{pmatrix}
$$

********************************************************************************

### Example: B-splines

This is a linear example, so there are probably simpler ways to do the same thing, but it's good for illustration.

Consider the following data set which is generated from an underlying sine wave,


```r
n = 100
x = seq(0, 2 * pi, length = n)
mu = sin(x)
sigma = 0.5
y = rnorm(n, mu, sigma)
plot(x, y, pch = 19, col = "grey", main = "Example data")
lines(x, mu, col = 4)
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1.png) 


Let's use a cubic B-spline with 5 degrees of freedom to model the data.


```r
suppressMessages(require(splines))
X = bs(x, df = 5, degree = 3, intercept = TRUE)
model = lm(y ~ 0 + X)
preds = predict(model, se = TRUE)
plot(x, y, pch = 19, col = "grey", main = "Fitted values and 95% CI for the mean")
lines(x, preds$fit, col = 2)
lines(x, preds$fit - 1.96 * preds$se.fit, col = 2, lty = 2)
lines(x, preds$fit + 1.96 * preds$se.fit, col = 2, lty = 2)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 


Now let's try and get the same confidence intervals using the delta method.

First we'll write a function to represent the B-spline, which takes x-values and five parameters (X1 to X5) as input.


```r
f = function(x, X1, X2, X3, X4, X5) {
    X = bs(x, df = 5, degree = 3, intercept = TRUE)
    as.numeric(X %*% c(X1, X2, X3, X4, X5))
}
```


Using this function inside another function called **numericDeriv** we can calculate the dervatives and get standard errors for the fitted function at any point on the x-axis (but we'll use the original x-values for convenience).


```r
delta.func = function(x, theta, cov.theta) {
    
    n = length(x)
    
    X1 = theta[1]
    X2 = theta[2]
    X3 = theta[3]
    X4 = theta[4]
    X5 = theta[5]
    
    grad = attr(numericDeriv(quote(f(x, X1, X2, X3, X4, X5)), names(theta)), 
        "gradient")
    
    # apply the delta method for each value of x
    var = sapply(1:n, function(i) t(grad[i, ]) %*% cov.theta %*% grad[i, ])
    
    estimate = f(x, X1, X2, X3, X4, X5)
    
    list(fit = estimate, lower = estimate - 1.96 * sqrt(var), upper = estimate + 
        1.96 * sqrt(var))
    
}

intervals = delta.func(x, theta = coef(model), cov.theta = vcov(model))

plot(x, y, pch = 19, col = "grey", main = "Fitted values and 95% CI calculated using the delta method")
lines(x, intervals$fit, col = 2)
lines(x, intervals$lower, col = "darkgreen", lty = 2)
lines(x, intervals$upper, col = "darkgreen", lty = 2)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 


********************************************************************************

<a href="index.html#D">(back to D)</a> 

<a href="index.html">(back to index)</a> 

