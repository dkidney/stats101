
## Normal distribution

********************************************************************************

### Pdf

$$ f(x) = \frac{1}{\sigma \sqrt{2\pi}} \exp\left\{ -\frac{(x-\mu)^2}{2\sigma^2} \right\} $$

********************************************************************************

### Log of pdf

$$ 

\begin{eqnarray}

&& \log\left(\frac{1}{\sigma \sqrt{2\pi}} \exp\left\{ -\frac{(x-\mu)^2}{2\sigma^2} \right\} \right) \\

&&\\

&=& \log\left(\frac{1}{\sigma \sqrt{2\pi}}\right) + \log\left( \exp\left\{ -\frac{(x-\mu)^2}{2\sigma^2} \right\} \right) \\

&&\\

&=& \log\left(\frac{1}{\sigma \sqrt{2\pi}}\right) - \frac{(x-\mu)^2}{2\sigma^2} \\

&&\\

&=& \log(1) - \log\left(\sigma \sqrt{2\pi}\right) - \frac{(x-\mu)^2}{2\sigma^2} \\

&&\\

&=& 0 - \left\{\log(\sigma) + \log\left(\sqrt{2\pi}\right)\right\} - \frac{(x-\mu)^2}{2\sigma^2} \\

&&\\

&=& - \log(\sigma) - \log\left(\sqrt{2\pi}\right) - \frac{(x-\mu)^2}{2\sigma^2} \\

&&\\

&=& - \log(\sigma) - \frac{1}{2}\log(2\pi) - \frac{(x-\mu)^2}{2\sigma^2} \\

\end{eqnarray}

$$

********************************************************************************

### Check in R


```r
x = 1
mu = 2
sigma = 3
```


#### Standard form


```r
dnorm(x, mu, sigma)
```

```
## [1] 0.1258
```

```r
1/(sigma * sqrt(2 * pi)) * exp(-(x - mu)^2/(2 * sigma^2))
```

```
## [1] 0.1258
```


#### Log form


```r
dnorm(x, mu, sigma, log = TRUE)
```

```
## [1] -2.073
```

```r
-log(sigma) - 0.5 * log(2 * pi) - (x - mu)^2/(2 * sigma^2)
```

```
## [1] -2.073
```


********************************************************************************

<a href="index.html#N">(back to N)</a> 

<a href="index.html">(back to index)</a> 
