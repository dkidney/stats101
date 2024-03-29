
## Survival analysis

********************************************************************************

### Survival times

Let's assume that survival times come from an <a href="Exponential distribution.html#S">exponential distribution</a>.

$$ T \sim Exp(\lambda) $$

For example, if $\lambda = 0.05$, then the distribution would look like this:


```r
lambda = 0.05
tmax = 100
curve(dexp(x, lambda), col = 4, main = "Distribution of survival times", ylab = "Density", 
    xlab = "Time", xlim = c(0, tmax), ylim = c(0, dexp(0, lambda)), from = 0, 
    xaxs = "i", yaxs = "i")
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1.png) 


This might represent the distribution of survival times in years for some Medieval population.

The distribution of survival times is sometimes called the **event density**.

********************************************************************************

### Survival function

This gives the probabilty that time of death, $T$, occurs after time $t$.

$$ S(t) = P(T > t) $$

If we wanted to calculate this from the distribution of survival times we would calculate the area under the curve between $t$ and $\infty$. For the exponential distribution we would get,

$$ S(t) = \int_t^\infty \lambda e^{-\lambda t} = 1 - \int_{-\infty}^t \lambda e^{-\lambda t} = 1 - \left[1 - e^{-\lambda t} \right] = e^{-\lambda t} $$

If $\lambda = 0.05$, the probability of surviving beyond a time of $t=20$ years in our Medieval population would be,

$$ S(20) = e^{-0.05 \times 20} = 0.3678798 $$


```r
t = 20
integrate(function(x, lambda) dexp(x, lambda), lambda = lambda, lower = t, upper = Inf)
```

```
## 0.3679 with absolute error < 4e-05
```

```r
curve(dexp(x, lambda), col = 4, main = "Distribution of survival times", ylab = "Density", 
    xlab = "Time", ylim = c(0, dexp(0, lambda)), xlim = c(0, tmax), xaxs = "i", 
    yaxs = "i")
abline(v = t, lty = 2)
xvals = seq(t, tmax, length = 100)
polygon(c(t, xvals, tmax), c(0, dexp(xvals, lambda), 0), col = "pink")
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 


So for survival times following the exponential distribution with $\lambda = 0.05$, the survival function would look like this,


```r
curve(exp(-lambda * x), col = 4, main = "Survival function", ylab = "S(t)", 
    xlab = "Time", ylim = c(0, 1), xlim = c(0, tmax), xaxs = "i", yaxs = "i")
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 


It is generally assumed that $S(0)=1$

It is also usually assumed that as $t$ increases $S(t)$ decreases (i.e. $S(t) \rightarrow 0$ as $t \rightarrow \infty$).

********************************************************************************

### Lifetime distribution function

This gives the probabilty that time of death occurs *by* time $t$. You could think of this as the opposite of the survival function.

$$ F(t) = P(T \leq t) = 1 - S(t) $$

This is the same as the **cdf** of the distribution of survival times - i.e. it gives the cumulative probability of death over time. 

Equivalently you could think of it as giving the expected *proportion* of individuals in a population that have already died by time $t$.  

For the exponential distribution it would look like this,

$$ F(t) = \int_{-\infty}^t \lambda e^{-\lambda t} = 1 - e^{-\lambda t} $$

...and for the exponential distribution with $\lambda = 0.05$ it would look this this,


```r
curve(1 - exp(-lambda * x), col = 4, main = "Lifetime distribution function", 
    ylab = "F(t)", xlab = "Time", ylim = c(0, 1), xlim = c(0, tmax), xaxs = "i", 
    yaxs = "i")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 


The derivative of $F(t)$ takes us back to the original distribution for the survival times. 

For the exponential distribution we would have,

$$ f(t) = \frac{d}{dt} F(t) = \frac{d}{dt} \left[1 - S(t)\right] = \frac{d}{dt} 1 - e^{-\lambda t} = \lambda e^{-\lambda t} $$


```r
D(expression(1 - exp(-lambda * t)), "t")
```

```
## exp(-lambda * t) * lambda
```


You can also think of the event density as being proportional to the **death rate per unit time** - i.e. it gives the rate of change in the proportion of indivduals that have died.

$$ f(t) = \underset{dt \; \rightarrow \; 0}{\lim}{\frac{ F(t + dt) - F(t) }{ dt }} $$

For the exponential distribution this rate starts off being very high, but gradually decreases until eventually it falls off to almost zero at large values of $t$, since by this time most of the population will have already died.

********************************************************************************
<a id="Hazard function"></a>

### Hazard function

The formula for this is,

$$ h(t) = \frac{ f(t) }{ S(t) } $$

Which is the event density at time $t$, scaled by the the proportion of the population that are expected to still be alive at time $t$.

It's also called the **hazard rate** or **failure rate**, since it gives the (instantaneous) rate of death at time $t$ for the those that have survived up to that point.

It does **not** give a probability (since it can be any positive number) and it does **not** give a probability density (since it integrates to $\infty$).

#### An example

The hazard function for the exponential distribution looks like this,

$$ \frac{ f(t) }{ S(t) } = \frac{ \lambda e^{-\lambda t} }{ e^{-\lambda t} } = \lambda $$

So the parameter $\lambda$ can also be interpreted as the hazard, meaning that the hazard for the exponential distribution is constant over time (which is a consequence of the 'memoryless' property of the exponential distribution).

To illustrate, let's suppose we have 100000 people in our Medieval population. To make things easy, let's also pretend that they were all born at the same time. We would expect around 36788 people to survive to age 20 ($S(20)$ = $\exp(-0.05 \times 20)$ = $0.36788$). The instantaneous rate of death at year 20 will be $f(20)$ = $0.05 \times \exp(-0.05 \times 20)$ = $0.0184$, which means that at this point the proportion of dead people is increasing by about 1.8 % per year. Or to put it another way, at this point the number of dead people is increasing by about 1839.4 *people* per year ($100000 \times 0.0184$ = $1839.4$). If that is the rate of death per year and there are 36788 people left in the population, that means that at this point the rate of death for the survivors is about 5% per year ($1839.4 / 36788$ = $0.05$, or alternatively $0.0184 / 0.36788$ = $0.05$). This is the hazard, which is equal to our value for $\lambda$. We can therefore interpret the hazard rate in this case as the proporion of the remaining survivors that are expected to die per year (or the yearly survival probability for each remaining survivor). Since the hazard is constant for the exponential distribution, it is the same regardless of the age of the survivors.

Note that the value of the hazard is senstive to the units of time being used. If we have measured time in centuries for example instead of years the hazard would have been much larger (5 in this case), but it's meaning would have been the same (500% per century = 5% per year).

********************************************************************************

### Cumulative hazard function

This is the integral of the hazard function,

$$ H(t) = \int_0^t h(t) \; dt $$

So for the exponential distribution, where $h(t) = \lambda$, the cumulative hazard is $H(t) = \lambda t$.

In terms of our Medieval poplation, the cumulative hazard by year 20 is equal to 1 ($0.05 \times 20$) but this doesn't seem particularly intuitive to me.

********************************************************************************

<a href="index.html#S">(back to S)</a> 

<a href="index.html">(back to index)</a> 

