
## Expectation-maximization (EM) algorithm

********************************************************************************

This is an iterative method for finding maximum likelihood estimates where the model depends on unobserved latent variables.

The algorithm alternates between two steps: the expectation (E) step and the maximization (M) step.

********************************************************************************

Consider the following likelihood,

$$ L(\theta ; Y, Z) $$ 

where,

$Y$ is a set of observed data

$\theta$ is a vector of parameters

$Z$ is a set of latent data or missing values

The usual way of dealing with this situation is to sum out the latent variable to obtain a marginal form for the likelihood,

$$ L(\theta ; Y, Z) = \sum_Z p(Y, Z ; \theta) $$ 

but this is often intractible. The EM algorithm offers an alternative solution.

********************************************************************************

### E step 

This creates a function for the expectation of the complete-data log-likelihood, which is evaulated using the current estimates of the parameters, $\theta^{(t)}$.

$$ Q(\theta | \theta^{(t)}) = E_{Z \mid Y ; \theta^{(t)}} \left[ \ell(\theta ; Y, Z) \right] $$

This requires that we know $p(Z | Y ; \theta)$ in order to calculate the expectation,

$$ E_{Z \mid Y ; \theta^{(t)}} \left[ \ell(\theta ; Y, Z) \right]  = \sum_Z p(Z | Y ; \theta) \; \ell(\theta ; Y, Z) $$

which can be obtained using <a href="Bayes theorem.html">Bayes' theorm</a>,

$$ p(Z | Y ; \theta^{(t)}) = \frac{ p(Y | Z ; \theta^{(t)}) \; p(Z ; \theta^{(t)}) }{ p(Y ; \theta^{(t)}) }
                           = \frac{ p(Y | Z ; \theta^{(t)}) \; p(Z ; \theta^{(t)}) }{ \sum_{k=1}^K p(Y | Z_k ; \theta^{(t)}) \; p(Z_k ; \theta^{(t)}) } $$

********************************************************************************

### M step

This computes parameters maximising the the expected log-likelihood found in the E step. 

$$ \theta^{(t)} = \underset{\theta} {\mathrm{argmax}} \; Q(\theta | \theta^{(t)}) $$

The parameter estimates $\theta^{(t)}$ are then used in the next iteration of the E step.

********************************************************************************

### Example: Fitting a mixture of two univariate normal distributions

Consider a sample of $n$ independent observations from a mixture of two univariate normal distributions.

$$ Y_i | Z_i = 1 \sim N(\mu_1, \sigma_1^2) $$

$$ Y_i | Z_i = 2 \sim N(\mu_2, \sigma_2^2) $$

where, $P(Z_i = 1) = w_1$ and $P(Z_i = 2) = w_2 = 1 - w_1$.

The likelihood function is,

$$ L(\theta ; Y, Z) = \prod_{i=1}^n \; \sum_{k=1}^2 \; I(z_i = k) \; w_k \; f(y_i ; \mu_k, \sigma_k) $$

where,

$I(z_i = k)$ is an indicator function that equals 1 if $z_i=k$ and 0 otherwise

$f(y ; \mu_k, \sigma_k)$ is the pdf of mixture component $k$

$\theta = (w_1, \mu_1, \mu_2, \sigma_1, \sigma_2)$

And the log-likelihood function is,

$$ \ell(\theta ; Y, Z) = \sum_{i=1}^n \; \sum_{k=1}^2 \; I(z_i = k) \; \left[ \log(w_k) + \log(f(y_i ; \mu_k, \sigma_k)) \right] $$

#### E step

The form for $p(Z | Y ; \theta^{(t)})$ in this case is,

$$ p(Z | Y ; \theta^{(t)}) = \frac{ p(Y | Z ; \theta^{(t)}) \; p(Z ; \theta^{(t)}) }{ p(Y | Z_1 ; \theta^{(t)}) \; p(Z_1 ; \theta^{(t)}) + p(Y | Z_2 ; \theta^{(t)}) \; p(Z_2 ; \theta^{(t)}) } $$

Or more specifically,

$$ p(Z_i=k | Y_i=y_i ; \theta^{(t)}) = \frac{ f(y_i ; \mu_k^{(t)}, \sigma_k^{(t)}) \; w_k^{(t)} }{ f(y_i ; \mu_1^{(t)}, \sigma_1^{(t)}) \; w_1^{(t)} + f(y_i ; \mu_2^{(t)}, \sigma_2^{(t)}) \; w_2^{(t)} } = \tau_{ik}^{(t)} $$

Notice that the denominator is equivalent to the density of the mixture distribution, evaluted at the current values of the parameters. The fraction therefore gives the proportion of the height of the mixture at point $y_i$ attributable to component distribution $k$.

The expected value of the log-likelhood can be written as,

$$ 
\begin{align}
Q(\theta | \theta^{(t)}) 
&= E_{Z \mid Y ; \theta^{(t)}} \left[ \ell(\theta ; Y, Z) \right] \\
&= E_{Z \mid Y ; \theta^{(t)}} \left[ \sum_{i=1}^n \ell(\theta ; y_i, z_i) \right] \\
&= \sum_{i=1}^n E_{Z \mid Y ; \theta^{(t)}} \left[ \ell(\theta ; y_i, z_i) \right] \\
&= \sum_{i=1}^n \sum_{k=1}^2 \tau_{ik}^{(t)} \; I(z_i = k) \; \left[ \log(w_k) + \log(f(y_i ; \mu_k, \sigma_k)) \right] \\
\end{align}
$$

#### M step

Since the parameters all appear in separate linear terms they can be maximised independently of each other.

$$ w_k^{(t+1)} = \frac{1}{n} \sum_{i=1}^n \tau_{ik}^{(t)} $$

$$ \mu_k^{(t+1)} = \frac{ \sum_{i=1}^n \tau_{ik}^{(t)} y_i }{ \sum_{i=1}^n \tau_{ik}^{(t)} } $$

$$ \sigma_k^{(t+1)} = \frac{ \sum_{i=1}^n \tau_{ik}^{(t)} (x_i - \mu_k^{(t+1)})^2 }{ \sum_{i=1}^n \tau_{ik}^{(t)} } $$

#### Termination

Stop the algorithm if,

$$ \ell(\theta^{(t)}; X, Z) - \ell(\theta^{(t-1)}; X, Z) < \lambda $$

where $\lambda$ is some threshold value.

********************************************************************************

#### In R


```r
# make some data
n = 1000  # sample size
w = c(0.4, 0.6)  # mixture weights
z = sample(1:2, size = n, replace = TRUE, prob = w)  # latent grouping variable
mu = c(1, 2)  # means
sigma = c(0.2, 0.15)  # standard deviations
y = rnorm(n, mu[z], sigma[z])  # data

# plot the data
breaks = seq(min(y), max(y), length = n/10)
hist(y, prob = TRUE, breaks = breaks)
curve(w[1] * dnorm(x, mu[1], sigma[1]) + w[2] * dnorm(x, mu[2], sigma[2]), add = TRUE, 
    col = 4, xlim = range(y))
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1.png) 



```r
# helper functions
mixture.density = function(y, mu, sigma, w, K) {
    apply(sapply(1:K, function(k) dnorm(y, mu[k], sigma[k]) * w[k]), 1, sum)
}

calculate.tau = function(y, mu, sigma, w, K) {
    denominator = mixture.density(y, mu, sigma, w, K)
    sapply(1:K, function(k) dnorm(y, mu[k], sigma[k]) * w[k]/denominator)
}

calculate.loglik = function(y, mu, sigma, w, tau, K) {
    sum(sapply(1:K, function(k) tau[, k] * (log(w[k]) + dnorm(y, mu[k], sigma[k], 
        log = TRUE))))
}

predict.Z = function(tau) apply(tau, 1, function(x) which(x < (1/ncol(tau))))

# EM function
EM = function(y, mu, sigma, w, threshold = 1e-05) {
    
    K = length(mu)
    
    continue = TRUE
    
    counter = 0
    
    while (continue) {
        
        # store current values
        mu0 = mu
        sigma0 = sigma
        w0 = w
        
        # E step
        tau = calculate.tau(y, mu, sigma, w, K)
        
        # M step
        for (k in 1:K) {
            
            w[k] = mean(tau[, k])
            
            mu[k] = sum(tau[, k] * y)/sum(tau[, k])
            
            sigma[k] = sqrt(sum(tau[, k] * (y - mu[k])^2)/sum(tau[, k]))  # uses updated mu
            
        }
        
        # terminate
        difference = abs(calculate.loglik(y, mu0, sigma0, w0, tau, K) - calculate.loglik(y, 
            mu, sigma, w, tau, K))
        continue = difference > threshold
        counter = counter + 1
        
    }
    
    return(list(z = predict.Z(tau), mu = mu, sigma = sigma, w = w, K = K, iterations = counter))
    
}

# Give it a try
results = EM(y, mu, sigma, w)
results$mu
```

```
## [1] 0.9982 1.9973
```

```r
results$sigma
```

```
## [1] 0.1850 0.1527
```

```r
hist(y[results$z == 1], xlim = range(y), col = 2, breaks = breaks, xlab = "y", 
    main = "EM results")
hist(y[results$z == 2], col = 4, breaks = breaks, add = TRUE)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 




```r
# check with mixtools package
suppressMessages(require(mixtools))  # prevents annoying messages
capture.output(check <- normalmixEM(y))  # suppresses auto printing
```

```
## [1] "number of iterations= 13 "
```

```r
check$mu
```

```
## [1] 0.9982 1.9973
```

```r
check$sigma
```

```
## [1] 0.1850 0.1527
```


********************************************************************************

### Example: Fitting a mixture of two bivariate normal distributions

To do.

********************************************************************************

<a href="index.html#E">(back to E)</a> 

<a href="index.html">(back to index)</a> 

