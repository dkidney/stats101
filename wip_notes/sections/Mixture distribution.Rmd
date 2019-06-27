
## Mixture distribution

********************************************************************************

This describes the distribution of random variables whose values are derived from an underlying set of other distributions. Each random variable in a mixture distribution has a certain probability of coming from each of the underlying distriutions.

The individual distributions that combined to form the mixture distribution are called **mixture components** and the probabilities (or weights) associated with them are called **mixture weights**.

********************************************************************************

### Finite mixtures

If a mixture distribution is composed of $K$ mixture components (where $0 < K < \infty$), the probability density function of the mixture distribution can be expressed as,

$$ f(x) = \sum_{k=1}^K w_k p_k(x) $$

where,

$w_k$ = the weight for component $k$

$p_k(x)$ = the probability density function for component $k$

The weights also have the constraints that they must be individually between 0 and 1 (i.e. $0 \leq w_i \leq 1$) and sum to 1 (i.e. $\sum w_i = 1$).

********************************************************************************

### Example: Mixture of two normal distributions

Assume we have some data that come from a mixture of two normal distributions, with means $\mu_1$ and $\mu_2$ and standard deviations $\sigma_1$ and $\sigma_2$. 

In this case the pdf of the mixture distribtion can be written as,

$$ f(x ; \mu_1, \mu_2, \sigma_1, \sigma_2) = \sum_{k=1}^2 w_k p_k(x ; \mu_k, \sigma_k) $$


********************************************************************************

### See also 

<a href="EM algorithm.html">EM algorithm</a> 

<a href="Mixture model.html">Mixture model</a> 

********************************************************************************

<a href="index.html#M">(back to M)</a> 

<a href="index.html">(back to index)</a> 

