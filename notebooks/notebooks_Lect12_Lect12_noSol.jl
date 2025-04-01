### A Pluto.jl notebook ###
# v0.19.9

using Markdown
using InteractiveUtils

# ╔═╡ 2027e83e-ead0-4e05-9bd8-bf157f90778c
html"""
	<p align=left style="font-size:32px; font-family:family:Georgia"> <b> FINC 672: Workshop in Finance - Empirical Methods</b> <p>
	"""

# ╔═╡ c62078fa-1047-4b7a-babb-c724f358f136
	html"""
	<p style="padding-bottom:1cm"> </p>
	<div align=center style="font-size:25px; font-family:family:Georgia"> FINC-672: Workshop in Finance - Empirical Methods </div>
	<p style="padding-bottom:1cm"> </p>
	<p align=center style="font-size:25px; font-family:family:Georgia"> <b> Introduction to Portfolio Mathematics </b> <p>
	<p style="padding-bottom:1cm"> </p>
	<p align=center style="font-size:25px; font-family:family:Georgia"> Spring 2025 <p>
	<p style="padding-bottom:0.5cm"> </p>
	<div align=center style="font-size:20px; font-family:family:Georgia"> Prof. Matt Fleckenstein </div>
	<p style="padding-bottom:0.05cm"> </p>
	<div align=center style="font-size:20px; font-family:family:Georgia"> University of Delaware, 
	Lerner College of Business and Economics </div>
	<p style="padding-bottom:0.5cm"> </p>
	"""

# ╔═╡ 95a3731a-f718-42ce-ae12-aa317a4dc0c6
vspace

# ╔═╡ e81bdf26-48fa-4474-8b0d-65c94d499edf
TableOfContents(aside=true, depth=2)

# ╔═╡ a548314b-511d-4319-8f7b-95a3158ba90c
html"""
<fieldset>      
<legend>Goals for today</legend>      
<br>
  <input type="checkbox" value="">Understand the basics of portfolio mathematics. <br>      
<br>
  <input type="checkbox" value="">Implement functions to calculate portfolio statistics.<br>
<br>
  <input type="checkbox" value="">Be familiar with CRSP data.<br>      
<br>
</fieldset>      
"""

# ╔═╡ 0d02bf71-e376-4ac8-bfb5-6ec6330f7b73
vspace

# ╔═╡ 9f37984d-ef99-4c89-840a-1e6ead25b385
md"""
**Reminder**: Read the pdf `Reading_Introduction to Portfolio Mathematics` on Canvas prior to this lecture.
"""

# ╔═╡ 0bf6824c-6b69-4eb3-92a2-2eb4ff2f2e4c
vspace

# ╔═╡ 2a5055b4-2137-447d-bfd2-a26cc4b14735
#Load Packages
using Chain, CSV,  Dates, DataFrames, ShiftedArrays, Statistics

# ╔═╡ 2ff3a933-14ba-43e4-96a8-99667f31811a
vspace

# ╔═╡ bd352f2e-3b7f-4b5b-ae43-fd244447347a
md"""
# Return Calculations

The return of holding the asset between $t-1$ and $t$ is

$$R_t = (P_t+D_t)/P_{t-1} - 1,$$

where $P_t$ is the price (measured after dividends) and $D_t$ is the dividend.

We can calculate the returns by a loop or by a more compact notation, see below.

"""

# ╔═╡ 6334d495-fa91-4428-a203-4d8234324ece
md"""
Let's look at an example where we have a stock with three price observations.
"""

# ╔═╡ 6c19fbf2-342d-48ff-97d7-983bb1ae1122
# let
	
# 		P =                     #prices (after dividends) for t=1,2,3
# 		D =                            #dividends, could also use [0;2;0]
	
# 		R =                   #where to store the results
		
# 		for t = 2:length(P)                   #P[2] is the 2nd element of P  
			
# 		end
		
# 		                          #get rid of R[1] since we have no return there

# 	with_terminal() do 
# 		printmat(R*100,colNames=["return, %"],rowNames=2:3,cell00="period",width=15)
# 	end
	
# end

# ╔═╡ 40545841-03bc-43d8-af40-8858d5e63bf7
md"""
- Instead of using a `for` loop, we can do this using a vectorized operation.
- The `ShiftedArrays.jl` package gives us an easy way to get the lags $P_{t-1}$.
"""

# ╔═╡ 1249ca7c-7229-463a-ba80-a9ff82652068
# let
	
# 	P = [100,108,109]                     #prices (after dividends) for t=1,2,3
# 	D = [0,2,0]                           #dividends, could also use [0;2;0]

# 	R = 
# 	popfirst!(R)

# 	with_terminal() do 
# 		printmat(R*100,colNames=["return, %"],rowNames=2:3,cell00="period",width=15)
# 	end
	
# end	

# ╔═╡ 5d4fc0ee-e3aa-404a-8983-bdf73cd4abe1
vspace

# ╔═╡ 75007c57-94e8-49fc-8bbb-3d39d6207fa2
md"""
# Cumulating Returns
Net returns can be cumulated into a portfolio value as

$$V_t = V_{t-1}(1+R_t),$$

where we need a starting value (initial investment) for the portfolio (a common choice is to normalise to $V_0=1$).

With log returns, $r_t=\log(1+R_t)$, we instead do

$$\ln V_t = \ln V_{t-1} + r_t$$

If the return series is an excess return, add the riskfree rate to convert it to get net returns - and then cumulate as described above.
"""

# ╔═╡ c1a5ff0e-ce5e-4390-bed7-af5be140a145
# let
# 	R    = [20,-35,25]/100                #returns for t=1,2,3
# 	V   =               #V(t) = V(t-1)*(1+R(t)), starting at 1 in t=0
# 	lnV =          #lnV(t) = lnV(t-1) + r(t) 
# 	expLnV = 
		
# 	#Display results
# 	with_terminal() do
# 		printmat(R,V,lnV,expLnV,colNames=["R","V","lnV","ExpLnV"],rowNames=1:3,cell00="period")
# 	end
# end

# ╔═╡ 5b46d617-14f3-4c85-8e79-76a75c324fc5
vspace

# ╔═╡ fe5001e5-4efc-4e2f-9d64-86904573317d
md"""
# Fundamentals of Stock Portfolio Mathematics
"""

# ╔═╡ 3db9060b-3ce5-485a-9b77-840a433a7b6d


# ╔═╡ 33ecc1df-9c57-43f3-a500-f2da16a938de
html"""<br>"""

# ╔═╡ cd0af42f-9446-45df-93d1-41f890b800fb
md"""
## Two-Asset Portfolio: Expected Return
For a simple portfolio of two stocks, let $w_1$ and $w_2$ be the fraction of total investment in Asset 1 and Asset 2 (typically $w_1+w_2=1$). 

The **expected return** of the portfolio is the weighted average of the assets’ expected returns: 

$$E[R_p] = w_1\,E[R_1] \;+\; w_2\,E[R_2]\,.$$

Here $E[R_i]$ is the expected return of asset $i$. This formula shows that the portfolio’s expected return is a linear combination of component returns in proportion to their weights. $br


"""

# ╔═╡ 3a44e22d-2bc1-4505-81f6-5d0e7867edb5
html"""<br>"""

# ╔═╡ 581e2ae5-e453-4681-bb58-2b5116440500
md"""
## Two-Asset Portfolio: Variance (Risk)
Portfolio **variance** measures the dispersion or risk of portfolio returns. 

For two assets, portfolio variance depends on each asset’s variance and their covariance. 

The formula is: 

$$\mathrm{Var}(R_p) = w_1^2\,\sigma_1^2 \;+\; w_2^2\,\sigma_2^2 \;+\; 2\,w_1w_2\,\mathrm{Cov}(R_1,R_2)\,.$$

- here $\sigma_i^2$ is the variance of asset $i$ (and $\sigma_i$ its standard deviation).
- and $\mathrm{Cov}(R_1,R_2)$ is the covariance between the returns of assets 1 and 2. 

This extra covariance term means portfolio risk is **not** just a weighted average of individual risks. 

If the two assets do not move perfectly in sync, the covariance term can lower the total variance. 

The **standard deviation** 

$$\sigma_p = \sqrt{\mathrm{Var}(R_p)}$$ 

is often used as the portfolio’s volatility or risk measure.


"""

# ╔═╡ aa210848-60fb-4298-931a-5e52748bb1d9
html"""<br>"""

# ╔═╡ 0e99fdf8-d81d-4f7b-8b95-f92de9c02d8e
md"""
## Diversification and Correlation

**Diversification** is the idea of combining assets with less-than-perfect correlation to reduce risk. 
Covariance can be expressed in terms of the **correlation** coefficient $\rho_{12}$: $\mathrm{Cov}(R_1,R_2) = \rho_{12}\,\sigma_1\,\sigma_2$. 

Substituting this, the two-asset variance becomes:

$$\mathrm{Var}(R_p) = w_1^2\sigma_1^2 + w_2^2\sigma_2^2 + 2\,w_1w_2\,\rho_{12}\,\sigma_1\,\sigma_2\,.$$

- If $\rho_{12} < 1$, the portfolio variance is **lower** than the weighted sum of individual variances – this is the benefit of diversification. Lower or negative correlation between assets yields a greater risk reduction.
- If $\rho_{12} = 1$ (perfect positive correlation), there is no diversification benefit (risk is a linear combination of $\sigma_1$ and $\sigma_2$).
- If $\rho_{12} = -1$ (perfect negative correlation), a complete risk cancellation is possible (one asset’s gains offset the other’s losses), allowing for a **zero-variance portfolio** with appropriate weights.

In practice, selecting assets with low or negative correlation is key to diversification.


"""

# ╔═╡ 33af0342-ffe6-44ef-8862-bca3702fb553
html"""<br>"""

# ╔═╡ d865c030-ebc5-4a9e-8f69-3be70b442da6
md"""
## Three-Asset Portfolio: Extending the Concept
Now consider a portfolio of *three* assets with weights $w_1, w_2, w_3$ (summing to 1). The portfolio’s expected return generalizes to the sum of each asset’s weight times its expected return:

$$E[R_p] = w_1 E[R_1] + w_2 E[R_2] + w_3 E[R_3]\,.$$

The variance formula now includes each asset’s variance and **all pairwise covariances** between the three assets:

$$\begin{aligned}
\mathrm{Var}(R_p) &= w_1^2\sigma_1^2 + w_2^2\sigma_2^2 + w_3^2\sigma_3^2\\ 
&\quad +\; 2\,w_1w_2\,\mathrm{Cov}(R_1,R_2) + 2\,w_1w_3\,\mathrm{Cov}(R_1,R_3) \\
&\quad +\; 2\,w_2w_3\,\mathrm{Cov}(R_2,R_3)\,. 
\end{aligned}$$

Each pair of assets contributes a covariance term. As the number of assets grows, the number of covariance pairs grows as well (for $n$ assets, there are $n(n-1)/2$ distinct covariances). In general, portfolio variance accounts for every asset’s individual risk and each pair’s covariance. More assets provide more opportunities to diversify (reduce risk), but also make the calculations more complex.

"""

# ╔═╡ 4f060660-a958-4f76-ad1f-361f55e6d06b
html"""<br>"""

# ╔═╡ 36d519a3-7ffe-4f00-9a58-e2611692a3f6
md"""
## Covariance Matrix for Multiple Assets
To handle many assets efficiently, we use the **covariance matrix** $\Sigma$. This is an $n \times n$ matrix that summarizes all variances and covariances for an $n$-asset portfolio:

$$\Sigma = 
\begin{pmatrix}
\sigma_1^2      & \mathrm{Cov}_{12} & \mathrm{Cov}_{13} & \cdots & \mathrm{Cov}_{1n}\\
\mathrm{Cov}_{12} & \sigma_2^2    & \mathrm{Cov}_{23} & \cdots & \mathrm{Cov}_{2n}\\
\mathrm{Cov}_{13} & \mathrm{Cov}_{23} & \sigma_3^2   & \cdots & \mathrm{Cov}_{3n}\\
\vdots       & \vdots       & \vdots       & \ddots & \vdots       \\
\mathrm{Cov}_{1n} & \mathrm{Cov}_{2n} & \mathrm{Cov}_{3n} & \cdots & \sigma_n^2
\end{pmatrix}\,.$$

Each diagonal entry is an asset’s own variance $\sigma_i^2$, and each off-diagonal entry $\mathrm{Cov}_{ij}$ is the covariance between assets $i$ and $j$ (with $\mathrm{Cov}_{ij}=\mathrm{Cov}_{ji}$). Using this matrix, we can compute portfolio variance without writing out every term. 

For example, for three assets, the matrix $\Sigma$ would contain $\sigma_1^2, \sigma_2^2, \sigma_3^2$ on the diagonal, and $\mathrm{Cov}(R_1,R_2), \mathrm{Cov}(R_1,R_3), \mathrm{Cov}(R_2,R_3)$ (and their symmetric counterparts) off-diagonally. This matrix representation simplifies multi-asset portfolio calculations.


"""

# ╔═╡ 6277b26f-e10e-4e3a-b20e-a43e0bdc69e6
html"""<br>"""

# ╔═╡ 9a568f85-8250-4fdb-a203-3cceaaa411c6
md"""
## Vector/Matrix Notation for Portfolio Metrics
We can further simplify the notation using vectors and matrices. 
Let $\mathbf{w}$ be the weight vector 

$$\mathbf{w} = (w_1, w_2, \dots, w_n)^T$$ 

and let 

$$\boldsymbol{\mu} = (E[R_1], E[R_2], \dots, E[R_n])^T$$ 

be the vector of expected returns. Using linear algebra:

- **Portfolio expected return:** 
$$E[R_p] = \mathbf{w}^T \boldsymbol{\mu}$$ 
which expands to 
$$\sum_{i=1}^n w_i\,E[R_i]$$.

- **Portfolio variance:** 
$$\mathrm{Var}(R_p) = \mathbf{w}^T \Sigma\, \mathbf{w}$$ 
which equals
$$\sum_{i}\sum_{j} w_i w_j\,\mathrm{Cov}(R_i,R_j)$$. 

- **The covariance of two portfolios** (with weights $v$ and $w$, respectively) can be computed as
$$\text{Cov}(R_q,R_p) = v^T\Sigma w$$

These compact formulas encapsulate the same information more succinctly. (Typically we assume $\sum_i w_i = 1$ for a fully invested portfolio.) 

The volatility is then 

$$\sigma_p = \sqrt{\mathbf{w}^T \Sigma \mathbf{w}}$$ 

Using vector/matrix notation makes it easier to calculate and optimize portfolio risk and return for many assets.


"""

# ╔═╡ bb0d6f17-93ee-4870-a43f-c5ad91b9b2da
html"""<br>"""

# ╔═╡ c6e826df-905c-4d25-8310-d9ad7079c589
md"""
To illustrate this using two assets.

$$R_p = \left[ {\matrix{
   {{w_A}} & {{w_B}}  \cr 

 } } \right]\left[ {\matrix{
   {{r_A}}  \cr 
   {{r_B}}  \cr 

 } } \right] = {\left[ {\matrix{
   {{w_A}}  \cr 
   {{w_B}}  \cr 

 } } \right]^T}\left[ {\matrix{
   {{r_A}}  \cr 
   {{r_B}}  \cr 

 } } \right] = {w^T}R$$


$$ER_p = \left[ {\matrix{
   {{w_A}} & {{w_B}}  \cr 

 } } \right]\left[ {\matrix{
   {{\mu_A}}  \cr 
   {{\mu_B}}  \cr 

 } } \right] = {\left[ {\matrix{
   {{w_A}}  \cr 
   {{w_B}}  \cr 

 } } \right]^T}\left[ {\matrix{
   {{\mu_A}}  \cr 
   {{\mu_B}}  \cr 

 } } \right] = {w^T}\mu$$


$$Var(R_p) = \left[ {\matrix{
   {{w_A}} & {{w_B}}  \cr 

 } } \right]\left[ {\matrix{
   {{\sigma _A^2}} & {\sigma _{A,B}}  \cr 
   {{\sigma _{A,B}}} & {\sigma _B^2}  \cr 

 } } \right]\left[ {\matrix{
   {{w_A}}  \cr 
   {{w_B}}  \cr 

 } } \right] = {w^T}\Sigma w$$

"""

# ╔═╡ b754641c-2ae8-4337-a81a-69ec8a3e4687
html"""<br>"""

# ╔═╡ e2f52055-d104-4c9a-b607-9e51c3b068de
md"""
## Example: Three-Assets in Matrix/Vector Notation



"""

# ╔═╡ 7e1593a7-d275-4d90-9292-fda97f4c6408
md"""
### Asset Data

Let’s assume we have three assets: A, B, and C, with the following expected returns and standard deviations:

- **Asset A**: $E[R_A] = 0.10$ (10%), $\sigma_A = 0.15$ (15%)
- **Asset B**: $E[R_B] = 0.08$ (8%),  $\sigma_B = 0.10$ (10%)
- **Asset C**: $E[R_C] = 0.12$ (12%), $\sigma_C = 0.20$ (20%)

Suppose their correlation matrix is:

$$\begin{pmatrix}
1.00 & 0.30 & 0.10 \\
0.30 & 1.00 & 0.05 \\
0.10 & 0.05 & 1.00
\end{pmatrix}$$

From correlation $\rho_{ij}$ and individual standard deviations, we get covariances:

$$\mathrm{Cov}(R_i, R_j) = \rho_{ij}\,\sigma_i\,\sigma_j.$$


"""

# ╔═╡ 6a634707-ac8b-4a1d-afdf-e4f28055b254
html"""<br>"""

# ╔═╡ 61a56cb1-d489-4d18-8c0f-2acbaaabc081
md"""
#### Covariance Computation

1. $\mathrm{Cov}(R_A, R_B) = 0.30 \times 0.15 \times 0.10 = 0.0045.$
2. $\mathrm{Cov}(R_A, R_C) = 0.10 \times 0.15 \times 0.20 = 0.0030.$
3. $\mathrm{Cov}(R_B, R_C) = 0.05 \times 0.10 \times 0.20 = 0.0010.$

Variances are simply $\sigma_i^2$:

1. $\sigma_A^2 = 0.15^2 = 0.0225.$
2. $\sigma_B^2 = 0.10^2 = 0.0100.$
3. $\sigma_C^2 = 0.20^2 = 0.0400.$

Therefore, the **covariance matrix** $\Sigma$ is:

$$\Sigma = 
\begin{pmatrix}
0.0225 & 0.0045 & 0.0030 \\
0.0045 & 0.0100 & 0.0010 \\
0.0030 & 0.0010 & 0.0400
\end{pmatrix}.$$



"""

# ╔═╡ 0fa7cb0e-dc5a-4eeb-93fc-ec2cf755b310
html"""<br>"""

# ╔═╡ 7eb5da1d-528c-42ff-bdd7-d7be1c4ecf6f
md"""
### Portfolio Weights

Suppose our portfolio allocates:
- $w_A = 0.40 (40\%)$
- $w_B = 0.30 (30\%)$
- $w_C = 0.30 (30\%)$

In **vector form**, the weight vector is:

$$\mathbf{w} = 
\begin{pmatrix}
0.40 \\
0.30 \\
0.30
\end{pmatrix}.$$

The **return vector** $\boldsymbol{\mu}$ is:

$$\boldsymbol{\mu} = 
\begin{pmatrix}
0.10 \\
0.08 \\
0.12
\end{pmatrix}.$$
"""

# ╔═╡ 4ba78e06-a225-46ca-b0e1-6a64bfb52477
html"""<br>"""

# ╔═╡ fa2a0d55-1967-4044-8a0b-3d864ac3f2e7
md"""
## Using the Matrices to Compute Portfolio Return and Variance


"""

# ╔═╡ 5d71a089-37ca-40ef-b2cc-a5d205768d0f
html"""<br>"""

# ╔═╡ 597f1909-af30-444a-ac80-d66c87ee2262
md"""

### 1. Portfolio Expected Return

Using the vector formula: 

$$E[R_p] \;=\; \mathbf{w}^T \boldsymbol{\mu} 
\;=\; \sum_{i=1}^3 w_i \, E[R_i].$$

Numerically:

$$\begin{aligned}
E[R_p] 
&= 0.40 \times 0.10 \;+\; 0.30 \times 0.08 \;+\; 0.30 \times 0.12 \\
&= 0.040 \;+\; 0.024 \;+\; 0.036 \\
&= 0.100 \;=\; 10.0\%.
\end{aligned}$$

So, the portfolio’s expected return is **10%**.


"""

# ╔═╡ 66f23181-2c2a-4119-bf9d-b60f30a416df
html"""<br>"""

# ╔═╡ a4d7bb20-1d05-4b8c-953f-d6dee8064794
md"""
### 2. Portfolio Variance

Recall the matrix formula for portfolio variance:

$$\mathrm{Var}(R_p) \;=\; \mathbf{w}^T \,\Sigma\, \mathbf{w}.$$

Substituting:

$$\Sigma = 
\begin{pmatrix}
0.0225 & 0.0045 & 0.0030 \\
0.0045 & 0.0100 & 0.0010 \\
0.0030 & 0.0010 & 0.0400
\end{pmatrix}, 
\quad
\mathbf{w} = 
\begin{pmatrix}
0.40 \\ 
0.30 \\
0.30
\end{pmatrix}.$$

Compute $\Sigma\, \mathbf{w}$ first:

$$\Sigma\, \mathbf{w} 
=\;
\begin{pmatrix}
0.0225 & 0.0045 & 0.0030 \\
0.0045 & 0.0100 & 0.0010 \\
0.0030 & 0.0010 & 0.0400
\end{pmatrix}
\begin{pmatrix}
0.40 \\ 
0.30 \\
0.30
\end{pmatrix}
=
\begin{pmatrix}
0.0225 \cdot 0.40 + 0.0045 \cdot 0.30 + 0.0030 \cdot 0.30 \\
0.0045 \cdot 0.40 + 0.0100 \cdot 0.30 + 0.0010 \cdot 0.30 \\
0.0030 \cdot 0.40 + 0.0010 \cdot 0.30 + 0.0400 \cdot 0.30
\end{pmatrix}.$$


Let’s do each element:

1. **Top element:** $0.0225 \times 0.40 + 0.0045 \times 0.30 + 0.0030 \times 0.30$
   $$= 0.0090 + 0.00135 + 0.0009
   = 0.01125$$
2. **Middle element:** $0.0045 \times 0.40 + 0.0100 \times 0.30 + 0.0010 \times 0.30$
   $$= 0.0018 + 0.0030 + 0.0003
   = 0.0051$$
3. **Bottom element:** $0.0030 \times 0.40 + 0.0010 \times 0.30 + 0.0400 \times 0.30$
   $$= 0.0012 + 0.0003 + 0.0120
   = 0.0135$$

So,

$$\Sigma \mathbf{w} 
=\;
\begin{pmatrix}
0.01125 \\
0.00510 \\
0.01350
\end{pmatrix}.$$

Next, multiply $\mathbf{w}^T$ by this vector:

$$\mathbf{w}^T \,(\Sigma \mathbf{w}) 
= 
\begin{pmatrix}
0.40 & 0.30 & 0.30
\end{pmatrix}
\begin{pmatrix}
0.01125 \\
0.00510 \\
0.01350
\end{pmatrix}.$$

$$= 0.40 \times 0.01125 + 0.30 \times 0.00510 + 0.30 \times 0.01350 
= 0.0045 + 0.00153 + 0.00405
= 0.01008.$$

Hence,

$$\mathrm{Var}(R_p) = 0.01008.$$

The portfolio’s **standard deviation** is 

$$\sigma_p = \sqrt{0.01008} \approx 0.1004 \quad (\text{or }10.04\%).$$

"""

# ╔═╡ 621078cb-0d1f-423a-ae39-66fb14ad691e
html"""<br>"""

# ╔═╡ 9124a215-06b1-4fde-9af6-e1983f03cbc5
md"""
## Takeaways from the Example

1. **Expected Return**  
   Using $\mathbf{w}^T \boldsymbol{\mu}$ gave us a concise way to get $E[R_p] = 10\%$.

2. **Variance (and Standard Deviation)**  
   Using $\mathbf{w}^T \Sigma \mathbf{w}$ showed how covariances factor into the total risk. The result is $\sigma_p \approx 10.04\%$.

3. **Interpretation of the Weights**  
   - Asset A has moderate risk (15%), B is lower risk (10%), and C is higher risk (20%).  
   - Even though C’s risk is relatively high, its correlation with A and B is fairly low (0.10 and 0.05), which helps limit the overall portfolio’s risk.

4. **Diversification**  
   - If the assets had all been perfectly correlated $(\rho = 1)$, the variance would be much larger.  
   - Because the correlations are small, combining these three assets reduces total variance relative to just picking C alone or A alone, etc.

"""

# ╔═╡ 40b056ac-9219-42aa-9712-d71e313ff01d
html"""<br>"""

# ╔═╡ d395dd66-f070-4e58-aaad-daa5479a810b
md"""
## Takeaways from the Example

1. **Expected Return**  
   Using $\mathbf{w}^T \boldsymbol{\mu}$ gave us a concise way to get $E[R_p] = 10\%$.

2. **Variance (and Standard Deviation)**  
   Using $\mathbf{w}^T \Sigma \mathbf{w}$ showed how covariances factor into the total risk. The result is $\sigma_p \approx 10.04\%$.

3. **Interpretation of the Weights**  
   - Asset A has moderate risk (15%), B is lower risk (10%), and C is higher risk (20%).  
   - Even though C’s risk is relatively high, its correlation with A and B is fairly low (0.10 and 0.05), which helps limit the overall portfolio’s risk.

4. **Diversification**  
   - If the assets had all been perfectly correlated $(\rho = 1)$, the variance would be much larger.  
   - Because the correlations are small, combining these three assets reduces total variance relative to just picking C alone or A alone, etc.

"""

# ╔═╡ f9cb505f-0a37-4176-9086-e90f86ae9971
html"""<br>"""

# ╔═╡ a7fa9015-df03-4998-9fe8-fea3d2c52782
md"""

## Sharpe Ratio: Risk-Adjusted Return
So far we have looked at return and risk separately. The **Sharpe Ratio** combines them to measure risk-adjusted performance. It is defined as the excess return of the portfolio (over a risk-free rate $R_f$) per unit of volatility:

$$\text{Sharpe Ratio} = \frac{E[R_p] - R_f}{\sigma_p}\,.$$

- **Numerator:** $E[R_p] - R_f$ is the portfolio’s expected return above the risk-free rate (often a Treasury bill rate).
- **Denominator:** $\sigma_p$ is the standard deviation of portfolio returns (volatility).

This formula evaluates how much *extra* return the portfolio earns for each unit of risk – i.e. the portfolio is providing more return per unit of volatility compared to a lower-Sharpe portfolio.

"""

# ╔═╡ 85f90476-cfb8-4d4d-a9a2-5680a855008a
html"""<br>"""

# ╔═╡ 840791df-1434-4ffa-bda9-2d3c3aca7a38
md"""
### Sharpe Ratio – Example & Interpretation
Consider two portfolios to illustrate the Sharpe ratio:

- **Portfolio A:** Expected return $E[R_A]=8\%$, volatility $\sigma_A=10\%$, risk-free rate $R_f=2\%$.  
  *Sharpe$_A = \frac{8\% - 2\%}{10\%} = 0.6$.*
- **Portfolio B:** Expected return $E[R_B]=6\%$, volatility $\sigma_B=5\%$, $R_f=2\%$.  
  *Sharpe$_B = \frac{6\% - 2\%}{5\%} = 0.8$.*

Even though Portfolio A has a higher raw return, Portfolio B has a higher Sharpe ratio, meaning B delivers more excess return relative to its risk. In practice, a Sharpe ratio below 1.0 is often considered sub-optimal, while higher values (above 1) indicate a more attractive risk-return tradeoff. Investors use the Sharpe ratio to compare portfolios or funds – a higher Sharpe suggests a more efficient portfolio in risk-adjusted terms.


"""

# ╔═╡ 055ae2d2-0099-4b35-8dac-fdc8595b83b2
vspace

# ╔═╡ c9039280-93c5-481a-936c-f0c3f7f98cfb
md"""
# Portfolio Mathematics in Practice
"""

# ╔═╡ 3575ad64-b633-4384-9c1d-a040a26a23c1
vspace

# ╔═╡ e89ecb62-4c0f-4266-863b-529694cca1c0
# let
# 	w = [0.8,0.2]
# 	R = [10,5]/100          #returns of asset 1 and 2
# 	Rp = 

# 	with_terminal() do 
# 		printred("Portfolio weights:")
# 		printmat(w,rowNames=["asset 1","asset 2"])

# 		printred("Returns:")
# 		printmat(R,rowNames=["asset 1","asset 2"])

# 		printred("Portfolio return: ")
# 		printlnPs(Rp)
# 	end
# end

# ╔═╡ 3d30fa0b-2fcd-4fe8-a258-7efda3b528d2
vspace

# ╔═╡ 3369be71-2a11-4dc8-8d1b-d2b1d7749c5f
# let
# 	μ =                     #\mu[TAB] to get μ
# 	Σ = 

# 	with_terminal() do
# 		printred("expected returns*100: ")
# 		printmat(μ*100,rowNames=["asset 1","asset 2"])

# 		printred("covariance matrix*100^2:")
# 		printmat(Σ*100^2,rowNames=["asset 1","asset 2"],colNames=["asset 1","asset 2"])
# 	end
	
# end

# ╔═╡ 3d9c2bd4-1915-449d-8d79-824b424d4425
vspace

# ╔═╡ 4dece1db-3305-4b94-8a1b-f5c833d67444
# let
# 	w = 
# 	R = #returns of asset 1 and 2
# 	μ =                     #\mu[TAB] to get μ
# 	Σ = 
		
# 	ERp   = 
# 	VarRp = 

# 	with_terminal() do
# 		printlnPs("Expected portfolio return: ",ERp)
# 		printlnPs("Portfolio variance and std:",VarRp,sqrt(VarRp))
# 	end
		
# end

# ╔═╡ c68b9ff3-8948-4478-99ed-5c6606375838
vspace

# ╔═╡ e5318e00-c074-4074-8eb4-3245ceceb4c4
# let
# 	w = [0.8,0.2]
# 	μ = [9,6]/100  
# 	Σb = 

# 	with_terminal() do
# 		printlnPs("Portfolio std if the assets were negatively correlated: ",sqrt(w'Σb*w))
# 	end
# end

# ╔═╡ d9de859c-a0df-4d9e-9918-b6c22c73a4e6
vspace

# ╔═╡ c537a2e6-114f-4a86-9323-cc7e7b94ceb3
md"""
# CRSP Dataset
"""

# ╔═╡ 98083989-a006-4cf3-afd1-0b3495e1d5b6
md"""
To illustrate the concepts, we will be working with the CRSP dataset from WRDS.

> From CANVAS, download the csv file **CRSP_monthly.csv** from the dataset section.
"""

# ╔═╡ e3529bed-ac89-4e5f-a1e2-e2a7d4c7b073
md"""
**Let's first read the data into a dataframe.**
"""

# ╔═╡ ded59ba8-2be9-4641-88e6-a7c205c64da9
vspace

# ╔═╡ 2a18e0ef-4332-4a11-af9f-3efea3f8f69d
 # CRSP = 

# ╔═╡ b0d48d1a-8a41-4382-9627-247e33227ba2
vspace

# ╔═╡ ad26e54b-85b1-4631-b1ed-531873ba712a
md"""
**Let's describe the data to get a sense of the variables and their types**
"""

# ╔═╡ aee2e708-6b13-4609-b60c-a33cbd741023


# ╔═╡ a06f82d6-89b5-4a8f-8a94-122b51875da4
vspace

# ╔═╡ d99160b7-9421-404d-bef4-55f634d6e586
md"""
**Let's consider a set of stocks in the Dow Jones Index**
"""

# ╔═╡ 22073910-f676-4e8b-8b80-38fed57bf399
md"""
Ticker | Company Name
:------|:-------------
AAPL | 	Apple Inc
AMGN | 	Amgen Inc
AXP  | 	American Express Co
BA   | 	Boeing Co/The
CAT  | 	Caterpillar Inc
CRM  | 	salesforce.com Inc
CSCO | 	Cisco Systems Inc/Delaware
CVX  | 	Chevron Corp
DIS  | 	Walt Disney Co/The
DOW  | 	Dow Inc
GS   | 	Goldman Sachs Group Inc/The
HD   | 	Home Depot Inc/The
HON  | 	Honeywell International Inc
IBM  | 	International Business Machines Corp
INTC | 	Intel Corp
JNJ  | 	Johnson & Johnson
JPM  | 	JPMorgan Chase & Co
KO   | 	Coca-Cola Co/The
MCD  | 	McDonald's Corp
MMM  | 	3M Co
MRK  | 	Merck & Co Inc
MSFT | 	Microsoft Corp
NKE  | 	NIKE Inc
PG   | 	Procter & Gamble Co/The
TRV  | 	Travelers Cos Inc/The
UNH  | 	UnitedHealth Group Inc
V    | 	Visa Inc
VZ   | 	Verizon Communications Inc
WBA  | 	Walgreens Boots Alliance Inc
WMT  | 	Walmart Inc
"""

# ╔═╡ 695258ec-d833-4fd7-8d5b-ad8706ecb158
vspace

# ╔═╡ 8980a963-b6c0-48cd-9316-b96df2acf4c6
md"""
**Let's work with a single stock first. We will pick AAPL.**
"""

# ╔═╡ 6a25c898-54b3-4afc-b771-e13c7cda66eb
md"""
#### Apple (AAPL)
"""

# ╔═╡ 456211a1-3828-458c-a597-cb35a88c35ca
md"""
**How can we deal with missing data?**
"""

# ╔═╡ 590799eb-b5e0-4ee0-bdb5-ae4bd01f5576
md"""
If we try to filter out AAPL from the dataset, we get an error message.
>AAPL = filter(:TICKER => (x-> x=="AAPL"),CRSP)

This is because :TICKER has missing data, and we need to give instructions to the `filter` function how `missing` values ought to be dealt with.
"""

# ╔═╡ d86c3764-81fb-4dcc-af04-094356a25216
md"""
**Let's see how to do this.**
"""

# ╔═╡ 043efd52-9dc8-473d-950e-e2bf48f2a666
vspace

# ╔═╡ 6cb63947-6490-4a02-8b74-55eb5e2efa96


# ╔═╡ efbdf76a-b588-46b8-b0ec-7addfa74bdee
md"""
- The code `ismissing(x) ? false : x=="AAPL"` is a shortcut for an `if`-`else` statement.
- Specifically, it is the same as

```
if ismissing(x)
	return false
elseif x=="AAPL"
	return true
else 
	return false
end
```
- In addition, recall that the `filter()` function takes the DataFrame as the last argument. In a `@chain` command, this means that we use the underscore `_` instead of the name of the DataFrame as the last argument.
"""

# ╔═╡ 8e17b00f-7247-4275-a9d8-f19cc5e778e4
md"""
- Alternatively, we could have done this in a much more lengthy manner.
"""

# ╔═╡ c8c78612-f83c-4c62-a3f1-572c8a5fbb60
let
	
end

# ╔═╡ 18675b31-2a97-4b2f-91b9-7c070b396c29
vspace

# ╔═╡ b7597d21-9931-4639-8ffb-cbaabd79e09d
md"""
## Handling duplicate data
"""

# ╔═╡ 12a7aa9d-0bef-4f4e-95e6-147bd3dc3f94
vspace

# ╔═╡ b8051d63-ed26-4e21-8a98-f564a3b8a967
md"""
**Notice that there are two rows in the data for August 2020.**
"""

# ╔═╡ a0cf0361-422a-4bcd-8b9e-943dc00044b3


# ╔═╡ a909cc2f-ac8f-4c29-9daa-c1117bc821f2
vspace

# ╔═╡ 6b720ade-5e4c-4f58-8fcd-f609df29df7b
md"""
**We care about the second row since it has the information about the dividend and the stock split we need.**
"""

# ╔═╡ 0cf85da2-a538-402d-9785-094425260bdb


# ╔═╡ 1861c6a9-1fb1-4332-8c50-3ed5fd429f14
vspace

# ╔═╡ a65fa0ae-1ceb-451e-ab37-08c0d23a508e
md"""
**Next, we adjust the prices for stock splits. This is done via the variable "CFACPR" (cumulative adjustment factor).**
"""

# ╔═╡ 523e0191-237e-4bdb-b9a3-53079b9e92d5


# ╔═╡ e881cd3b-3d9f-4dd9-88cc-b2e1158f2294
md"""
- Notice that in adjusting for stock splits, we use two input columns for the transformation. Hence, the anonymous function takes the form `(x,y) -> ...`
- Note also that we again control for missing data.
  - By using `any(ismissing.([x,y]))` we check whether __any__ of the two input values is missing. If so, we return missing, otherwise we make the adjustment.
"""

# ╔═╡ 5d055fb4-5026-40aa-920d-f39d261e65a2
vspace

# ╔═╡ 8a869ecb-a6ed-499d-873b-131c9bc2e0b1
md"""
**Let's now create a new dataframe with all the changes we want to make.**
"""

# ╔═╡ 446e0db1-8107-4724-b774-561c5d37f87a
# begin
# 	AAPL = @chain CRSP begin
		
# 		#Select Apple stock
# 		filter(:TICKER => (x-> ismissing(x) ? false : x=="AAPL"),_)

# 		#filter Aug 2020
# 		groupby(:date)
# 		combine(_) do sdf
#            if nrow(sdf) == 2 
#                DataFrame(sdf[2,:])
#            else
#                sdf
#            end
#         end

# 		#Adjust for stock splits
# 		transform( [:PRC,:CFACPR] => ByRow(  (x,y) -> x/y) => :PRC,
# 				   [:DIVAMT,:CFACPR] => ByRow(  (x,y) -> any(ismissing.([x,y])) ? missing : x/y) => :DIVAMT)

		
# 		select(:date, :TICKER, :PERMCO, :PERMNO, :PRC, :DIVAMT)

		
# 	    sort(:date)
# 	end
# end

# ╔═╡ 0bd40ffd-8e71-4709-917c-04c9fca25e37
vspace

# ╔═╡ 842ebc61-3212-4309-86ad-6a21657d50cc
md"""
## Calculating returns
"""

# ╔═╡ 45868894-a317-4370-9631-6ef3c31661e3
md"""
**Next, let's calculate monthly returns for AAPL/**
"""

# ╔═╡ 7b666951-b303-4100-8dd2-feb8e2d22b14
md"""
**To do this, we need to add the lagged price.**
>Recall that the `ShiftedArrays` package allows us to do this.
"""

# ╔═╡ 83a3993e-073f-4e84-acfe-61bfc76dde3a


# ╔═╡ 470363be-fe40-40f1-9d53-2b5e2a15f2a0
vspace

# ╔═╡ 4805e8a6-34d6-49f0-8706-88c916e4689f
md"""
**As the next step, we need two functions. One to calculate arithmetic returns, and another to calculate log returns.**
"""

# ╔═╡ 9b816236-f9de-4aad-aea0-b5f8fbfc6b11
# function GetRx(Px_t,Px_tminus,div)
# end

# ╔═╡ d300be65-f494-4181-9924-e69cc6c04f09
# function GetLogRx(Px_t,Px_tminus,div)

# end

# ╔═╡ c0b48b52-0dfb-4553-b1c7-f089e36f893a
vspace

# ╔═╡ 2bd1674d-2254-45a8-9f02-5caa5bd0bd1c
md"""
**Let's now create a new dataframe with the returns for AAPL.**
"""

# ╔═╡ a23a366d-fa73-4672-b59c-e14b2b817ce8
# AAPL_Rx = @chain AAPL begin
	
# end

# ╔═╡ c30fa7dc-3c4c-4332-a724-d24f32cf5cb4
vspace

# ╔═╡ 5baa1a9f-7ad5-4bfc-b468-9e0b40438548
md"""
**Now, we can calculate the cumulative return over the period from January 2000 to December 2020 from investing $1 in AAPL.**
"""

# ╔═╡ 0c821308-45ca-4317-80b3-9e87c6840465


# ╔═╡ 8c58cbc6-cfbd-43de-9e68-bbaf447213fa


# ╔═╡ b4d7b148-6750-4538-9407-bd4ba02bafde
vspace

# ╔═╡ ca0c9ceb-34e1-44bc-891d-06259ce17e11
md"""
## Portfolios of stocks
"""

# ╔═╡ 056562f5-444d-4e09-b5b4-bf4058407782
vspace

# ╔═╡ a488a679-6dc0-4a33-b327-9d0f6e3b9eb2
md"""
**Next, let's work with a portfolio of stocks.**
"""

# ╔═╡ 76adf9cb-db2c-4b76-9614-be12bb9c5764
md"""
Let's pick 5 stocks: AAPL, BA, DIS, GS and JNJ.
"""

# ╔═╡ 99c0ee6b-e040-4261-992c-0f5a0eb8158c
# Portfolio = @chain CRSP begin
	

	
# end

# ╔═╡ 286aadfd-c2f1-428b-babc-943e0a46200d
vspace

# ╔═╡ 0eefd0af-f5dd-4b87-9be0-391d86cf8bf9
md"""
**To form a portfolio, it is more convenient to work with the data in *wide format*. This means that we want to put the five stocks in columns (one for each stock).**
"""

# ╔═╡ fe7f625f-8c50-46ed-84a2-b573bb955fb6
md"""
- This is called `unstacking`. This process is illustrated below.
"""

# ╔═╡ 213f25fe-cb66-4b01-8454-22e8acbdd8a8
LocalResource("unstack_dataframe.svg")

# ╔═╡ 0160a74b-04b6-44ce-9c50-27844697f833
md"""
- Let's now see how we can move the individual stocks to the columns.
  - For more examples, see [DataFrames Documentation](https://dataframes.juliadata.org/stable/lib/functions/#DataFrames.unstack).
"""

# ╔═╡ da35b9a0-5ac8-4608-8dc5-2c08901cc2e3


# ╔═╡ 3a003855-e6cc-4e30-95c3-02cb04435d9c
vspace

# ╔═╡ 6572bd2f-76e8-4735-9dff-d371fe7f69bd
md"""
**Next, let's pick a vector of portfolio weights.**
"""

# ╔═╡ e5c2b68f-4f1e-4bd1-8240-ac52d268304b
# w = [0.2,0.2,0.2,0.2,0.2]


# ╔═╡ 31d90f3b-0699-4c63-9c51-a558a1ee70b1
vspace

# ╔═╡ 9203a7c6-f070-4fdf-8522-eab5933b409a
md"""
## Portfolio returns
"""

# ╔═╡ 16cc7074-d786-4bb5-a735-187465e815e2
md"""
**Then, we calculate the portfolio return in each month.**
"""

# ╔═╡ 87099910-dfde-4fee-8910-1d6bd25d5170
# PortfRx = @chain Portfolio begin
	
# end

# ╔═╡ 775e1297-84ff-4982-99f4-44a85892f936
vspace

# ╔═╡ c63e96e7-0ea0-4daf-a230-26b258f12e79
md"""
**Let's get a sense of the stock returns by using `describe`.**
"""

# ╔═╡ 07e767e6-d6fc-4f52-8b9d-72ca7c633955


# ╔═╡ 42f876a7-4c63-49f8-ae01-5745cdfa8fd8
vspace

# ╔═╡ 5434a8d1-4608-4c89-b77e-bf0bc75798b3
md"""
## Summary statistics
"""

# ╔═╡ fb69d701-e623-443e-b6f0-c75180b9be1b
md"""
**Let's create a table with summary statistics that we are interested in:**
average return, standard deviation of returns, minimum, median, and the maximum of monthly returns.
"""

# ╔═╡ cb78be8c-f039-434e-acbb-9375f3174588
md"""
**To create this table, it is easier to work with the data in `long` format.**
That is we have one column for the TICKER and one column for the return for each date. In this format, it is easier to group the data and to apply a data transformation.
- For additional examples, see [DataFrames Documentation](#https://dataframes.juliadata.org/stable/lib/functions/#DataFrames.stack).
"""

# ╔═╡ cdda5183-46c6-4283-a66f-168ed5790a77


# ╔═╡ e7b781db-dee4-4905-93bd-d5e2be32d0e6
vspace

# ╔═╡ c799f1ad-b82b-4421-bb71-d07cb7b6afd7
md"""
**Let's now make the final table with the summary statistics for the returns.**
"""

# ╔═╡ b1a76909-a53f-492a-bec2-5415d90d5de4
# PortfSummary = @chain PortfRx begin
	
# end

# ╔═╡ ba8d8e35-aef4-458d-ba2d-742714ef4977
vspace

# ╔═╡ f0fbb607-14b0-4ba5-8e0b-04cbe50c0251
md"""
## Calculating the covariance matrix
"""

# ╔═╡ 4cfeda6b-6b12-4ffa-9379-15c00b53a49d
md"""
**Next, let's calculate the covariance matrix of returns.**
"""

# ╔═╡ 80865386-79cf-45b0-836d-e55a1ca64174
# let
# 	returns = 

	
		
# end

# ╔═╡ 7addc4e7-d90f-404c-91dc-375bf93eef95
vspace

# ╔═╡ aa21f05c-1e78-4919-86fa-57ae89d4d633
md"""
**Lastly, let's use what we have learned about portfolio mathematics at the beginning of this lecuture and apply it to our portfolio of stocks.**
"""

# ╔═╡ fa05b130-4ab5-49ea-8a8c-f6d9fcfd1656
# let
# 	assets = 
# 	μ = 
# 	Σ = 

# 	ERp   = 
# 	VarRp = 
	
# 	with_terminal() do
# 		printyellow("expected returns*100: ")
# 		printmat(μ*100,rowNames=assets.TICKER)

# 		printyellow("covariance matrix*100^2:")
# 		printmat(Σ*100^2,rowNames=assets.TICKER,colNames=assets.TICKER)

# 		printlnPs("Expected portfolio return: ",ERp)
# 		printlnPs("Portfolio variance and std:",VarRp,sqrt(VarRp))
		
# 	end

# end

# ╔═╡ f44df415-9970-4501-9e4e-2b2a7db50d6d
vspace

# ╔═╡ 76809cbd-d487-4d7a-acfc-d45cae769573
html"""
<fieldset>      
<legend>Goals for today</legend>      
<br>
  <input type="checkbox" value="" checked>Understand the basics of portfolio mathematics. <br>      
<br>
  <input type="checkbox" value="" checked>Implement functions to calculate portfolio statistics.<br>
<br>
  <input type="checkbox" value="" checked>Be familiar with CRSP data.<br>      
<br>
</fieldset>      
"""

# ╔═╡ 97840d49-e48d-40be-ab09-e3dea866143c
# ╠═╡ show_logs = false
begin

	using PlutoUI, Printf, LaTeXStrings, HypertextLiteral

	
	#Define html elements
	nbsp = html"&nbsp" #non-breaking space
	vspace = html"""<div style="margin-bottom:2cm;"></div>"""
	br = html"<br>"

	#Sets the height of displayed tables
	html"""<style>
		pluto-output.scroll_y {
			max-height: 650px; /* changed this from 400 to 550 */
		}
		"""
	
	#Two-column cell
	struct TwoColumn{A, B}
		left::A
		right::B
	end
	
	function Base.show(io, mime::MIME"text/html", tc::TwoColumn)
		write(io,
			"""
			<div style="display: flex;">
				<div style="flex: 50%;">
			""")
		show(io, mime, tc.left)
		write(io,
			"""
				</div>
				<div style="flex: 50%;">
			""")
		show(io, mime, tc.right)
		write(io,
			"""
				</div>
			</div>
		""")
	end

	#Creates a foldable cell
	struct Foldable{C}
		title::String
		content::C
	end
	
	function Base.show(io, mime::MIME"text/html", fld::Foldable)
		write(io,"<details><summary>$(fld.title)</summary><p>")
		show(io, mime, fld.content)
		write(io,"</p></details>")
	end
	
	html"""<style>
		main {
			max-width: 900px;
		}
	"""
	
	#helper functions
	#round to digits, e.g. 6 digits then prec=1e-6
	roundmult(val, prec) = (inv_prec = 1 / prec; round(val * inv_prec) / inv_prec); 

	using Logging
	global_logger(NullLogger())
	display("")

end

# ╔═╡ e796c131-5a67-4a99-8df2-b7ea52a03056
# ╠═╡ show_logs = false
begin

	
	#import Pkg
	#Pkg.upgrade_manifest()
	#Pkg.update()
	#Pkg.resolve()
	

	
# The following code is by Paul Soederlind
# https://sites.google.com/site/paulsoderlindecon/home
	
	#------------------------------------------------------------------------------
"""
    printmat([fh::IO],x...;colNames=[],rowNames=[],
             width=10,prec=3,NoPrinting=false,StringFmt="",cell00="")

Print all elements of a matrix (or several) with predefined formatting. It can also handle
OffsetArrays. StringFmt = "csv" prints using a csv format.

# Input
- `fh::IO`:            (optional) file handle. If not supplied, prints to screen
- `x::Array(s)`:       (of numbers, dates, strings, ...) to print
- `colNames::Array`:   of strings with column headers
- `rowNames::Array`:   of strings with row labels
- `width::Int`:        (keyword) scalar, minimum width of printed cells
- `prec::Int`:         (keyword) scalar, precision of printed cells
- `NoPrinting::Bool`:  (keyword) bool, true: no printing, just return formatted string [false]
- `StringFmt::String`: (keyword) string, "", "csv"
- `cell00::String`:    (keyword) string, for row 0, column 0

# Output
- str         (if NoPrinting) string, (otherwise nothing)

# Examples
```
x = [11 12;21 22]
printmat(x)
```
```
x = [1 "ab"; Date(2018,10,7) 3.14]
printmat(x,width=20,colNames=["col 1","col 2"])
```
```
printmat([11,12],[21,22])
```
Can also call as
```
opt = Dict(:rowNames=>["1";"4"],:width=>10,:prec=>3,:NoPrinting=>false,:StringFmt=>"")
printmat(x;colNames=["a","b"],opt...)     #notice ; and ...
```
(not all keywords are needed)

# Requires
- fmtNumPs

# Notice
- The prefixN and suffixN could potentially be made function inputs. This would allow
a fairly flexible way to format tables.


Paul.Soderlind@unisg.ch

"""
function printmat(fh::IO,x...;colNames=[],rowNames=[],
                  width=10,prec=3,NoPrinting=false,StringFmt="",cell00="")

  isempty(x) && return nothing                         #do nothing is isempty(x)

  typeTestQ = any(!=(eltype(x[1])),[eltype(z) for z in x])  #test if eltype(x[i]) differs
  if typeTestQ                                      #create matrix from tuple created by x...
    x = hcat(Matrix{Any}(hcat(x[1])),x[2:end]...)   #preserving types of x[i]
  else
    x = hcat(x...)
  end

  (m,n) = (size(x,1),size(x,2))

  (length(rowNames) == 1 < m) && (rowNames = [string(rowNames[1],i) for i = 1:m])  #"ri"
  (length(colNames) == 1 < n) && (colNames = [string(colNames[1],i) for i = 1:n])  #"ci"

  if StringFmt == "csv"
    (prefixN,suffixN)   = (fill("",n),vcat(fill(",",n-1),""))  #prefix and suffix for column 1:n
    (prefixC0,suffixC0) = ("",",")                             #prefix and suffix for column 0
  else
    (prefixN,suffixN) = (fill("",n),fill("",n))
    (prefixC0,suffixC0) = ("","")
  end

  if length(rowNames) == 0                         #width of column 0 (cell00 and rowNames)
    col0Width = 0
  else
    col0Width = maximum(length,vcat(cell00,rowNames)) + length(prefixC0) + length(suffixC0)
  end

  colWidth = [width + length(prefixN[j]) + length(suffixN[j]) for j=1:n]  #widths of column 1:n

  iob = IOBuffer()

  if !isempty(colNames)                                #print (cell00,colNames), if any
    !isempty(cell00) ?  txt0 = string(prefixC0,cell00,suffixC0) : txt0 = ""
    print(iob,rpad(txt0,col0Width))
    for j = 1:n                                #loop over columns
      print(iob,lpad(string(prefixN[j],colNames[j],suffixN[j]),colWidth[j]))
    end
    print(iob,"\n")
  end
                                                       #print rowNames and x
  (i0,j0) = (1 - first(axes(x,1)),1 - first(axes(x,2)))   #i+i0,j+j0 give traditional indices
  for i in axes(x,1)                           #loop over rows
    !isempty(rowNames) && print(iob,rpad(string(prefixC0,rowNames[i+i0],suffixC0),col0Width))
    for j in axes(x,2)                         #loop over columns
      print(iob,fmtNumPs(x[i,j],width,prec,"right",prefix=prefixN[j+j0],suffix=suffixN[j+j0]))
    end
    print(iob,"\n")
  end
  str = String(take!(iob))

  if NoPrinting                              #no printing, just return str
    return str
  else                                       #print, return nothing
    print(fh,str,"\n")
    return nothing
  end

end
                        #when fh is not supplied: printing to screen
printmat(x...;colNames=[],rowNames=[],width=10,prec=3,NoPrinting=false,StringFmt="",cell00="") =
    printmat(stdout::IO,x...;colNames,rowNames,width,prec,NoPrinting,StringFmt,cell00)
#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
"""
    printlnPs([fh::IO],z...;width=10,prec=3)

Subsitute for println, with predefined formatting.


# Input
- `fh::IO`:    (optional) file handle. If not supplied, prints to screen
- `z::String`: string, numbers and arrays to print

Paul.Soderlind@unisg.ch

"""
function printlnPs(fh::IO,z...;width=10,prec=3)

  for x in z                              #loop over inputs in z...
    if isa(x,AbstractArray)
      iob = IOBuffer()
      for i = 1:length(x)
        print(iob,fmtNumPs(x[i],width,prec,"right"))
      end
      print(fh,String(take!(iob)))
    else
      print(fh,fmtNumPs(x,width,prec,"right"))
    end
  end

  print(fh,"\n")

end
                      #when fh is not supplied: printing to screen
printlnPs(z...;width=10,prec=3) = printlnPs(stdout::IO,z...;width,prec)
#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
"""
    fmtNumPs(z,width=10,prec=2,justify="right";prefix="",suffix="")

Create a formatted string of a float (eg, "%10.4f"), nothing (""),
while other values are passed through. Strings are right (or left) justified
and can optionally be given prefix and suffix (eg, ",")

# Notice
- With prec > 0 and isa(z,Integer), then the string is padded with 1+prec spaces
to align with the printing of floats with the same prec.

# Requires
- Printf (for 1.6-), fmtNumPsC (for < 1.6)

"""
function fmtNumPs(z,width=10,prec=2,justify="right";prefix="",suffix="")

  isa(z,Bool) && (z = convert(Int,z))             #Bool -> Int

  if isa(z,AbstractFloat)                         #example: 101.0234, prec=3
    if VERSION < v"1.6-"
      fmt    = "%$(width).$(prec)f"
      zRound = round(z,digits=prec)
      strLR  = fmtNumPsC(fmt,zRound)                #C fallback solution
    else
      fmt   = Printf.Format("%$(width).$(prec)f")
      strLR = Printf.format(fmt,z)
    end
  elseif isa(z,Nothing)
    strLR = ""
  elseif isa(z,Integer) && prec > 0               #integer followed by (1+prec spaces)
    strLR = string(z," "^(1+prec))
  else                                            #Int, String, Date, Missing, etc
    strLR = string(z)
  end

  strLR = string(prefix,strLR,suffix)

  if justify == "left"                            #justification
    strLR = rpad(strLR,width+length(prefix)+length(suffix))
  else
    strLR = lpad(strLR,width+length(prefix)+length(suffix))
  end

  return strLR

end
#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
"""
    fmtNumPsC(fmt,z)

c fallback solution for formatting of floating point number. Used if VERSION < v"1.6-"
"""
function fmtNumPsC(fmt,z)                           #c fallback solution
  if ismissing(z) || isnan(z) || isinf(z)    #asprintf does not work for these cases
    str = string(z)
  else
    strp = Ref{Ptr{Cchar}}(0)
    len = ccall(:asprintf,Cint,(Ptr{Ptr{Cchar}},Cstring,Cdouble...),strp,fmt,z)
    str = unsafe_string(strp[],len)
    Libc.free(strp[])
  end
  return str
end
#------------------------------------------------------------------------------


#------------------------------------------------------------------------------
function printblue(x...)
  foreach(z->printstyled(z,color=:blue,bold=true),x)
  print("\n")
end
function printred(x...)
  foreach(z->printstyled(z,color=:red,bold=true),x)
  print("\n")
end
function printmagenta(x...)
  foreach(z->printstyled(z,color=:magenta,bold=true),x)
  print("\n")
end
function printyellow(x...)
  foreach(z->printstyled(z,color=:yellow,bold=true),x)
  print("\n")
end
#------------------------------------------------------------------------------

	
display("")
	
	#Sets the width of Pluto cells
		#Note: put this last here.
		html"""
			<style>
				main {
					margin: 0 auto;
					max-width: 950px;
			    	padding-left: max(80px, 5%);
			    	padding-right: max(80px, 5%);
				}
			</style>
		"""
	
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
Chain = "8be319e6-bccf-4806-a6f7-6fae938471bc"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Logging = "56ddb016-857b-54e1-b83d-db4d58db5568"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"
ShiftedArrays = "1277b4bf-5013-50f5-be3d-901d8477a67a"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[compat]
CSV = "~0.10.2"
Chain = "~0.6.0"
DataFrames = "~1.6.1"
HypertextLiteral = "~0.9.4"
LaTeXStrings = "~1.3.0"
PlutoUI = "~0.7.49"
ShiftedArrays = "~2.0.0"
Statistics = "~1.11.1"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.2"
manifest_format = "2.0"
project_hash = "3d226be2d74d315495aefb0e894501388e74779b"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "PrecompileTools", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings", "WorkerUtilities"]
git-tree-sha1 = "deddd8725e5e1cc49ee205a1964256043720a6c3"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.15"

[[deps.Chain]]
git-tree-sha1 = "9ae9be75ad8ad9d26395bf625dea9beac6d519f1"
uuid = "8be319e6-bccf-4806-a6f7-6fae938471bc"
version = "0.6.0"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "bce6804e5e6044c6daab27bb533d1295e4a2e759"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.6"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "8ae8d32e09f0dcf42a36b90d4e17f5dd2e4c4215"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.16.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "DataStructures", "Future", "InlineStrings", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrecompileTools", "PrettyTables", "Printf", "REPL", "Random", "Reexport", "SentinelArrays", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "04c738083f29f86e62c8afc341f0967d8717bdb8"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.6.1"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "1d0a14036acb104d9e89698bd408f63ab58cdc82"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.20"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FilePathsBase]]
deps = ["Compat", "Dates"]
git-tree-sha1 = "7878ff7172a8e6beedd1dea14bd27c3c6340d361"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.22"
weakdeps = ["Mmap", "Test"]

    [deps.FilePathsBase.extensions]
    FilePathsBaseMmapExt = "Mmap"
    FilePathsBaseTestExt = "Test"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"
version = "1.11.0"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InlineStrings]]
git-tree-sha1 = "45521d31238e87ee9f9732561bfee12d4eebd52d"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.4.2"

    [deps.InlineStrings.extensions]
    ArrowTypesExt = "ArrowTypes"
    ParsersExt = "Parsers"

    [deps.InlineStrings.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"
    Parsers = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.InvertedIndices]]
git-tree-sha1 = "6da3c4316095de0f5ee2ebd875df8721e7e0bdbe"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.3.1"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OrderedCollections]]
git-tree-sha1 = "12f1439c4f986bb868acda6ea33ebc78e19b95ad"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.7.0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "eba4810d5e6a01f612b948c9fa94f905b49087b0"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.60"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "36d8b4b899628fb92c2749eb488d884a926614d3"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.3"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.PrettyTables]]
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "1101cd475833706e4d0e7b122218257178f48f34"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.4.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "712fb0231ee6f9120e005ccd56297abbc053e7e0"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.8"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.ShiftedArrays]]
git-tree-sha1 = "503688b59397b3307443af35cd953a13e8005c16"
uuid = "1277b4bf-5013-50f5-be3d-901d8477a67a"
version = "2.0.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "a6b1675a536c5ad1a60e5a5153e1fee12eb146e3"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.4.0"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "598cd7c1f68d1e205689b1c2fe65a9f85846f297"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.12.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[deps.Tricks]]
git-tree-sha1 = "7822b97e99a1672bfb1b49b668a6d46d58d8cbcb"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.9"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "b1be2855ed9ed8eac54e5caff2afcdb442d52c23"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.2"

[[deps.WorkerUtilities]]
git-tree-sha1 = "cd1659ba0d57b71a464a29e64dbc67cfe83d54e7"
uuid = "76eceee3-57b5-4d4a-8e66-0e911cebbf60"
version = "1.6.1"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─f5450eab-0f9f-4b7f-9b80-992d3c553ba9
# ╟─2027e83e-ead0-4e05-9bd8-bf157f90778c
# ╟─c62078fa-1047-4b7a-babb-c724f358f136
# ╟─95a3731a-f718-42ce-ae12-aa317a4dc0c6
# ╟─e81bdf26-48fa-4474-8b0d-65c94d499edf
# ╟─a548314b-511d-4319-8f7b-95a3158ba90c
# ╟─0d02bf71-e376-4ac8-bfb5-6ec6330f7b73
# ╟─9f37984d-ef99-4c89-840a-1e6ead25b385
# ╟─0bf6824c-6b69-4eb3-92a2-2eb4ff2f2e4c
# ╠═2a5055b4-2137-447d-bfd2-a26cc4b14735
# ╟─2ff3a933-14ba-43e4-96a8-99667f31811a
# ╟─bd352f2e-3b7f-4b5b-ae43-fd244447347a
# ╟─6334d495-fa91-4428-a203-4d8234324ece
# ╠═6c19fbf2-342d-48ff-97d7-983bb1ae1122
# ╟─40545841-03bc-43d8-af40-8858d5e63bf7
# ╠═1249ca7c-7229-463a-ba80-a9ff82652068
# ╟─5d4fc0ee-e3aa-404a-8983-bdf73cd4abe1
# ╟─75007c57-94e8-49fc-8bbb-3d39d6207fa2
# ╠═c1a5ff0e-ce5e-4390-bed7-af5be140a145
# ╟─5b46d617-14f3-4c85-8e79-76a75c324fc5
# ╟─fe5001e5-4efc-4e2f-9d64-86904573317d
# ╟─3db9060b-3ce5-485a-9b77-840a433a7b6d
# ╟─33ecc1df-9c57-43f3-a500-f2da16a938de
# ╟─cd0af42f-9446-45df-93d1-41f890b800fb
# ╟─3a44e22d-2bc1-4505-81f6-5d0e7867edb5
# ╟─581e2ae5-e453-4681-bb58-2b5116440500
# ╟─aa210848-60fb-4298-931a-5e52748bb1d9
# ╟─0e99fdf8-d81d-4f7b-8b95-f92de9c02d8e
# ╟─33af0342-ffe6-44ef-8862-bca3702fb553
# ╟─d865c030-ebc5-4a9e-8f69-3be70b442da6
# ╟─4f060660-a958-4f76-ad1f-361f55e6d06b
# ╟─36d519a3-7ffe-4f00-9a58-e2611692a3f6
# ╟─6277b26f-e10e-4e3a-b20e-a43e0bdc69e6
# ╟─9a568f85-8250-4fdb-a203-3cceaaa411c6
# ╟─bb0d6f17-93ee-4870-a43f-c5ad91b9b2da
# ╟─c6e826df-905c-4d25-8310-d9ad7079c589
# ╟─b754641c-2ae8-4337-a81a-69ec8a3e4687
# ╟─e2f52055-d104-4c9a-b607-9e51c3b068de
# ╟─7e1593a7-d275-4d90-9292-fda97f4c6408
# ╟─6a634707-ac8b-4a1d-afdf-e4f28055b254
# ╟─61a56cb1-d489-4d18-8c0f-2acbaaabc081
# ╟─0fa7cb0e-dc5a-4eeb-93fc-ec2cf755b310
# ╟─7eb5da1d-528c-42ff-bdd7-d7be1c4ecf6f
# ╟─4ba78e06-a225-46ca-b0e1-6a64bfb52477
# ╟─fa2a0d55-1967-4044-8a0b-3d864ac3f2e7
# ╟─5d71a089-37ca-40ef-b2cc-a5d205768d0f
# ╟─597f1909-af30-444a-ac80-d66c87ee2262
# ╟─66f23181-2c2a-4119-bf9d-b60f30a416df
# ╟─a4d7bb20-1d05-4b8c-953f-d6dee8064794
# ╟─621078cb-0d1f-423a-ae39-66fb14ad691e
# ╟─9124a215-06b1-4fde-9af6-e1983f03cbc5
# ╟─40b056ac-9219-42aa-9712-d71e313ff01d
# ╟─d395dd66-f070-4e58-aaad-daa5479a810b
# ╟─f9cb505f-0a37-4176-9086-e90f86ae9971
# ╟─a7fa9015-df03-4998-9fe8-fea3d2c52782
# ╟─85f90476-cfb8-4d4d-a9a2-5680a855008a
# ╟─840791df-1434-4ffa-bda9-2d3c3aca7a38
# ╟─055ae2d2-0099-4b35-8dac-fdc8595b83b2
# ╟─c9039280-93c5-481a-936c-f0c3f7f98cfb
# ╟─3575ad64-b633-4384-9c1d-a040a26a23c1
# ╠═e89ecb62-4c0f-4266-863b-529694cca1c0
# ╟─3d30fa0b-2fcd-4fe8-a258-7efda3b528d2
# ╠═3369be71-2a11-4dc8-8d1b-d2b1d7749c5f
# ╟─3d9c2bd4-1915-449d-8d79-824b424d4425
# ╠═4dece1db-3305-4b94-8a1b-f5c833d67444
# ╟─c68b9ff3-8948-4478-99ed-5c6606375838
# ╠═e5318e00-c074-4074-8eb4-3245ceceb4c4
# ╟─d9de859c-a0df-4d9e-9918-b6c22c73a4e6
# ╟─c537a2e6-114f-4a86-9323-cc7e7b94ceb3
# ╟─98083989-a006-4cf3-afd1-0b3495e1d5b6
# ╟─e3529bed-ac89-4e5f-a1e2-e2a7d4c7b073
# ╟─ded59ba8-2be9-4641-88e6-a7c205c64da9
# ╠═2a18e0ef-4332-4a11-af9f-3efea3f8f69d
# ╟─b0d48d1a-8a41-4382-9627-247e33227ba2
# ╟─ad26e54b-85b1-4631-b1ed-531873ba712a
# ╠═aee2e708-6b13-4609-b60c-a33cbd741023
# ╟─a06f82d6-89b5-4a8f-8a94-122b51875da4
# ╟─d99160b7-9421-404d-bef4-55f634d6e586
# ╟─22073910-f676-4e8b-8b80-38fed57bf399
# ╟─695258ec-d833-4fd7-8d5b-ad8706ecb158
# ╟─8980a963-b6c0-48cd-9316-b96df2acf4c6
# ╟─6a25c898-54b3-4afc-b771-e13c7cda66eb
# ╟─456211a1-3828-458c-a597-cb35a88c35ca
# ╟─590799eb-b5e0-4ee0-bdb5-ae4bd01f5576
# ╟─d86c3764-81fb-4dcc-af04-094356a25216
# ╟─043efd52-9dc8-473d-950e-e2bf48f2a666
# ╠═6cb63947-6490-4a02-8b74-55eb5e2efa96
# ╟─efbdf76a-b588-46b8-b0ec-7addfa74bdee
# ╟─8e17b00f-7247-4275-a9d8-f19cc5e778e4
# ╠═c8c78612-f83c-4c62-a3f1-572c8a5fbb60
# ╟─18675b31-2a97-4b2f-91b9-7c070b396c29
# ╟─b7597d21-9931-4639-8ffb-cbaabd79e09d
# ╟─12a7aa9d-0bef-4f4e-95e6-147bd3dc3f94
# ╟─b8051d63-ed26-4e21-8a98-f564a3b8a967
# ╠═a0cf0361-422a-4bcd-8b9e-943dc00044b3
# ╟─a909cc2f-ac8f-4c29-9daa-c1117bc821f2
# ╟─6b720ade-5e4c-4f58-8fcd-f609df29df7b
# ╠═0cf85da2-a538-402d-9785-094425260bdb
# ╟─1861c6a9-1fb1-4332-8c50-3ed5fd429f14
# ╟─a65fa0ae-1ceb-451e-ab37-08c0d23a508e
# ╠═523e0191-237e-4bdb-b9a3-53079b9e92d5
# ╟─e881cd3b-3d9f-4dd9-88cc-b2e1158f2294
# ╟─5d055fb4-5026-40aa-920d-f39d261e65a2
# ╟─8a869ecb-a6ed-499d-873b-131c9bc2e0b1
# ╠═446e0db1-8107-4724-b774-561c5d37f87a
# ╟─0bd40ffd-8e71-4709-917c-04c9fca25e37
# ╟─842ebc61-3212-4309-86ad-6a21657d50cc
# ╟─45868894-a317-4370-9631-6ef3c31661e3
# ╟─7b666951-b303-4100-8dd2-feb8e2d22b14
# ╠═83a3993e-073f-4e84-acfe-61bfc76dde3a
# ╟─470363be-fe40-40f1-9d53-2b5e2a15f2a0
# ╟─4805e8a6-34d6-49f0-8706-88c916e4689f
# ╠═9b816236-f9de-4aad-aea0-b5f8fbfc6b11
# ╠═d300be65-f494-4181-9924-e69cc6c04f09
# ╟─c0b48b52-0dfb-4553-b1c7-f089e36f893a
# ╟─2bd1674d-2254-45a8-9f02-5caa5bd0bd1c
# ╠═a23a366d-fa73-4672-b59c-e14b2b817ce8
# ╟─c30fa7dc-3c4c-4332-a724-d24f32cf5cb4
# ╟─5baa1a9f-7ad5-4bfc-b468-9e0b40438548
# ╠═0c821308-45ca-4317-80b3-9e87c6840465
# ╠═8c58cbc6-cfbd-43de-9e68-bbaf447213fa
# ╟─b4d7b148-6750-4538-9407-bd4ba02bafde
# ╟─ca0c9ceb-34e1-44bc-891d-06259ce17e11
# ╟─056562f5-444d-4e09-b5b4-bf4058407782
# ╟─a488a679-6dc0-4a33-b327-9d0f6e3b9eb2
# ╟─76adf9cb-db2c-4b76-9614-be12bb9c5764
# ╠═99c0ee6b-e040-4261-992c-0f5a0eb8158c
# ╟─286aadfd-c2f1-428b-babc-943e0a46200d
# ╟─0eefd0af-f5dd-4b87-9be0-391d86cf8bf9
# ╟─fe7f625f-8c50-46ed-84a2-b573bb955fb6
# ╟─213f25fe-cb66-4b01-8454-22e8acbdd8a8
# ╟─0160a74b-04b6-44ce-9c50-27844697f833
# ╠═da35b9a0-5ac8-4608-8dc5-2c08901cc2e3
# ╟─3a003855-e6cc-4e30-95c3-02cb04435d9c
# ╟─6572bd2f-76e8-4735-9dff-d371fe7f69bd
# ╠═e5c2b68f-4f1e-4bd1-8240-ac52d268304b
# ╟─31d90f3b-0699-4c63-9c51-a558a1ee70b1
# ╟─9203a7c6-f070-4fdf-8522-eab5933b409a
# ╟─16cc7074-d786-4bb5-a735-187465e815e2
# ╠═87099910-dfde-4fee-8910-1d6bd25d5170
# ╟─775e1297-84ff-4982-99f4-44a85892f936
# ╟─c63e96e7-0ea0-4daf-a230-26b258f12e79
# ╠═07e767e6-d6fc-4f52-8b9d-72ca7c633955
# ╟─42f876a7-4c63-49f8-ae01-5745cdfa8fd8
# ╟─5434a8d1-4608-4c89-b77e-bf0bc75798b3
# ╟─fb69d701-e623-443e-b6f0-c75180b9be1b
# ╟─cb78be8c-f039-434e-acbb-9375f3174588
# ╠═cdda5183-46c6-4283-a66f-168ed5790a77
# ╟─e7b781db-dee4-4905-93bd-d5e2be32d0e6
# ╟─c799f1ad-b82b-4421-bb71-d07cb7b6afd7
# ╠═b1a76909-a53f-492a-bec2-5415d90d5de4
# ╟─ba8d8e35-aef4-458d-ba2d-742714ef4977
# ╟─f0fbb607-14b0-4ba5-8e0b-04cbe50c0251
# ╟─4cfeda6b-6b12-4ffa-9379-15c00b53a49d
# ╠═80865386-79cf-45b0-836d-e55a1ca64174
# ╟─7addc4e7-d90f-404c-91dc-375bf93eef95
# ╟─aa21f05c-1e78-4919-86fa-57ae89d4d633
# ╠═fa05b130-4ab5-49ea-8a8c-f6d9fcfd1656
# ╟─f44df415-9970-4501-9e4e-2b2a7db50d6d
# ╟─76809cbd-d487-4d7a-acfc-d45cae769573
# ╟─97840d49-e48d-40be-ab09-e3dea866143c
# ╟─e796c131-5a67-4a99-8df2-b7ea52a03056
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
