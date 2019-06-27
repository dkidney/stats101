
## Ordinary least squares (OLS)

********************************************************************************

### Model

$$ y = X\beta + \epsilon $$

#### Assumptions

$\mbox{E} \left[ \epsilon \right] = 0$, which implies that $\mbox{E} \left[ y \right] = X\beta$

$\mbox{Var} \left[ \epsilon \right] = \sigma^2 I$, which implies that $\mbox{Var} \left[ y \right] = \sigma^2 I$

$\mbox{Cov} \left[ \epsilon_i, \epsilon_j \right] = 0$ 

********************************************************************************

### OLS estimator

$$ \widehat{\beta} = \left( X^TX \right)^{-1} X^Ty $$

#### Derivation

We want to find the values of $\beta$ which minimse the error sum of squares,

$$ 
\begin{align}
\widehat{\beta} &= \underset{\beta} {\mathrm{argmin}} \; \epsilon^T\epsilon \\
                &= \underset{\beta} {\mathrm{argmin}} \; \left(y-X\beta\right)^T\left(y-X\beta\right) 
\end{align}
$$

So we need to find the derivative of the error sum of squares with respect to $\beta$ and solve it,

$$ \frac{ \partial }{ \partial\beta } \left(y-X\beta\right)^T\left(y-X\beta\right) $$

$$ = \frac{ \partial }{ \partial\beta } \left( y^Ty - 2(X\beta)^Ty + (X\beta)^T(X\beta) \right) $$

$$ = \frac{ \partial }{ \partial\beta } \left( y^Ty - 2\beta^TX^Ty + \beta^TX^TX\beta \right) $$

$$ = \frac{ \partial }{ \partial\beta } \left( y^Ty \right) - \frac{ \partial }{ \partial\beta } \left( 2\beta^TX^Ty \right) + \frac{ \partial }{ \partial\beta } \left( \beta^TX^TX\beta \right) $$

$$ = 0 + 2X^Ty - (X^TX + (X^TX)^T)\beta $$

because $X^TX$ is square, this becomes,

$$ = 0 + 2X^Ty - 2X^TX\beta $$

which is zero at,

$$ 0 = 2X^Ty - 2X^TX\widehat{\beta} X$$

$$ 2X^T\widehat{\beta} X = 2X^Ty $$

$$ X^T\widehat{\beta} X = X^Ty $$

$$ \widehat{\beta} = (X^TX)^{-1}X^Ty $$

********************************************************************************

### Expected value of OLS estimator

$$ \mbox{E} \left[ \widehat{\beta} \right] = \beta $$

#### Derivation

$$ \mbox{E} \left[ \widehat{\beta} \right] = \mbox{E} \left[ (X^TX)^{-1}X^Ty \right] $$

$$ = (X^TX)^{-1}X^T \mbox{E} \left[ y \right] $$

$$ = (X^TX)^{-1}X^T X\beta $$

$$ = \beta $$

********************************************************************************

### Variance of OLS estimator

$$ \mbox{Cov} \left[ \widehat{\beta} \right] = \sigma^2 \left( X^T X \right)^{-1} $$

$$ \mbox{Var} \left[ \widehat{\beta}_j \right] = \sigma^2 \left( \left( X^T X \right)^{-1} \right)_{jj} $$

#### Derivation

$$ \mbox{Cov} \left[ \widehat{\beta} \right] = \mbox{Var} \left[ (X^TX)^{-1}X^Ty \right] $$

$$ = \left( (X^TX)^{-1}X^T \right)^T \mbox{Var} \left[ y \right] \left( (X^TX)^{-1}X^T \right) $$

$$ = \left( (X^TX)^{-1}X \right) \mbox{Var} \left[ y \right] \left( (X^TX)^{-1}X^T \right) $$

I don't think I've done this perfectly, but basically one of the $(X^TX)^{-1}$ cancels out the two $X$'s leaving,

$$ = \mbox{Var} \left[ y \right] \left( X^T X \right)^{-1} $$

$$ = \sigma^2 I \left( X^T X \right)^{-1} $$

$$ = \sigma^2 \left( X^T X \right)^{-1} $$

********************************************************************************

### Fitted values

$$ \widehat{y} = X\widehat{\beta} $$

$$ = X\left( X^TX \right)^{-1} X^Ty $$

$$ = Hy $$

where $H = X\left( X^TX \right)^{-1} X^T$ is the **hat matrix**.

********************************************************************************

### Residuals

$$ \widehat{\epsilon} = y - \widehat{y} $$

$$ = y - Hy $$

$$ = (I - H)y $$

where $I$ is an identity matrix.

********************************************************************************

<a href="index.html#H">(back to H)</a> 

<a href="index.html">(back to index)</a> 

