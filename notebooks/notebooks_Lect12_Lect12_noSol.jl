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
	<p align=center style="font-size:25px; font-family:family:Georgia"> Spring 2024 <p>
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
TableOfContents(aside=true, depth=1)

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
let
	
		P = [100,108,109]                     #prices (after dividends) for t=1,2,3
		D = [0,2,0]                           #dividends, could also use [0;2;0]
	
		R = zeros(length(P))                  #where to store the results
		
		for t = 2:length(P)                   #P[2] is the 2nd element of P  
			R[t] = (P[t] + D[t])/P[t-1] - 1
		end
		
		popfirst!(R)                          #get rid of R[1] since we have no return there

	with_terminal() do 
		printmat(R*100,colNames=["return, %"],rowNames=2:3,cell00="period",width=15)
	end
	
end

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
let
	R    = [20,-35,25]/100                #returns for t=1,2,3
	V   = cumprod(1.0 .+ R)              #V(t) = V(t-1)*(1+R(t)), starting at 1 in t=0
	lnV = cumsum(log.(1.0 .+ R))         #lnV(t) = lnV(t-1) + r(t) 
	expLnV = exp.(lnV)
		
	#Display results
	with_terminal() do
		printmat(R,V,lnV,expLnV,colNames=["R","V","lnV","ExpLnV"],rowNames=1:3,cell00="period")
	end
end

# ╔═╡ 5b46d617-14f3-4c85-8e79-76a75c324fc5
vspace

# ╔═╡ e6c198f4-5abd-468c-841c-8a7b032f1dc2
md"""
# Portfolio Returns
Recall from Investments that the return of a portfolio of two stocks (let's call them stock A and B) is

$R_p = w_A \times R_A + w_B \times R_B$

The expected return is 

$$\text{E}R_p = w_A \times \mu_A + w_B \times \mu_B $$ 

and the portfolio variance is

$$\text{Var}(R_p) = w_A^2 \times \sigma_A^2 + w_B^2 \times \sigma_B^2 + 2\times w_A \times w_B \times \sigma_{A,B}$$

"""

# ╔═╡ 6751abe5-ef25-4d89-bed7-7cf7811fa2d8
vspace

# ╔═╡ 1cfe8c37-83ce-42fb-b4ad-c9ccb20bff52
md"""
You might also recall that we can use matrix algebra to write the above as

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

# ╔═╡ 82a86a66-53de-46d4-837c-2dce5b1f1f44
vspace

# ╔═╡ b65a5a50-b811-41c2-b136-a2b98797f05a
md"""
We form a portfolio by combining $n$ assets: $w$ is the vector of $n$ portfolio weights, $R$ is a vector of returns, $\mu$ a vector of expected expected (average) returns and $\Sigma$ the $n \times n$ covariance matrix.

The portfolio return, the expected portfolio return and the portfolio variance can be computed as:

$$R_p = w^TR,$$

$$\text{E}R_p = w^T\mu$$ and

$$\text{Var}(R_p) = w^T\Sigma w$$

The covariance of two portfolios (with weights $v$ and $w$, respectively) can be computed as

$$\text{Cov}(R_q,R_p) = w^T\Sigma w$$.
"""

# ╔═╡ 3575ad64-b633-4384-9c1d-a040a26a23c1
vspace

# ╔═╡ e89ecb62-4c0f-4266-863b-529694cca1c0
let
	w = [0.8,0.2]
	R = [10,5]/100          #returns of asset 1 and 2
	Rp = w'R

	with_terminal() do 
		printred("Portfolio weights:")
		printmat(w,rowNames=["asset 1","asset 2"])

		printred("Returns:")
		printmat(R,rowNames=["asset 1","asset 2"])

		printred("Portfolio return: ")
		printlnPs(Rp)
	end
end

# ╔═╡ 3d30fa0b-2fcd-4fe8-a258-7efda3b528d2
vspace

# ╔═╡ 3369be71-2a11-4dc8-8d1b-d2b1d7749c5f
let
	μ = [9,6]/100                    #\mu[TAB] to get μ
	Σ = [256 96;                     #\Sigma[TAB]
		 96 144]/100^2

	with_terminal() do
		printred("expected returns*100: ")
		printmat(μ*100,rowNames=["asset 1","asset 2"])

		printred("covariance matrix*100^2:")
		printmat(Σ*100^2,rowNames=["asset 1","asset 2"],colNames=["asset 1","asset 2"])
	end
	
end

# ╔═╡ 3d9c2bd4-1915-449d-8d79-824b424d4425
vspace

# ╔═╡ 4dece1db-3305-4b94-8a1b-f5c833d67444
let
	w = [0.8,0.2]
	R = [10,5]/100 #returns of asset 1 and 2
	μ = [9,6]/100                    #\mu[TAB] to get μ
	Σ = [256 96;                     #\Sigma[TAB]
		 96 144]/100^2
	ERp   = w'μ
	VarRp = w'Σ*w

	with_terminal() do
		printlnPs("Expected portfolio return: ",ERp)
		printlnPs("Portfolio variance and std:",VarRp,sqrt(VarRp))
	end
		
end

# ╔═╡ c68b9ff3-8948-4478-99ed-5c6606375838
vspace

# ╔═╡ e5318e00-c074-4074-8eb4-3245ceceb4c4
let
	w = [0.8,0.2]
	μ = [9,6]/100  
	Σb = [256 -96;                #another covariance matrix
          -96 144]/100^2

	with_terminal() do
		printlnPs("Portfolio std if the assets were negatively correlated: ",sqrt(w'Σb*w))
	end
end

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
 #CRSP = CSV.read("CRSP_monthly.csv",DataFrame)

# ╔═╡ b0d48d1a-8a41-4382-9627-247e33227ba2
vspace

# ╔═╡ ad26e54b-85b1-4631-b1ed-531873ba712a
md"""
**Let's describe the data to get a sense of the variables and their types**
"""

# ╔═╡ aee2e708-6b13-4609-b60c-a33cbd741023
describe(CRSP)

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
# let
	
# df = @chain CRSP begin
# 	filter(:TICKER => (x-> ismissing(x) ? false :  x=="AAPL"),_)
# end
	
# end

# ╔═╡ 18675b31-2a97-4b2f-91b9-7c070b396c29
vspace

# ╔═╡ b8051d63-ed26-4e21-8a98-f564a3b8a967
md"""
**Notice that there are two rows in the data for August 2020.**
"""

# ╔═╡ a0cf0361-422a-4bcd-8b9e-943dc00044b3
# @chain CRSP begin
	
# 	filter(:TICKER => (x-> ismissing(x) ? false : x=="AAPL"),_)
	
# 	groupby(:date)
# 	# combine(_) do sdf
# 	# 	if nrow(sdf) == 1
# 	# 		DataFrame()
# 	# 	else
# 	# 		sdf
# 	# 	end
# 	# end

# 	combine(_) do sdf
# 		if nrow(sdf)>1
# 			sdf
# 		else
# 			DataFrame()
# 		end

		
# 	end
	
# end

# ╔═╡ a909cc2f-ac8f-4c29-9daa-c1117bc821f2
vspace

# ╔═╡ 6b720ade-5e4c-4f58-8fcd-f609df29df7b
md"""
**We care about the second row since it has the information about the dividend and the stock split we need.**
"""

# ╔═╡ 0cf85da2-a538-402d-9785-094425260bdb
# @chain CRSP begin
	
# 	#Apple stock
# 	filter(:TICKER => (x-> ismissing(x) ? false : x=="AAPL"),_)

# 	groupby(:date)
# 	combine(_) do sdf
# 		if nrow(sdf)>=2
# 			DataFrame(sdf[2,:])
# 		else
# 			sdf
# 		end
# 	end

# end

# ╔═╡ 1861c6a9-1fb1-4332-8c50-3ed5fd429f14
vspace

# ╔═╡ a65fa0ae-1ceb-451e-ab37-08c0d23a508e
md"""
**Next, we adjust the prices for stock splits. This is done via the variable "CFACPR" (cumulative adjustment factor).**
"""

# ╔═╡ 523e0191-237e-4bdb-b9a3-53079b9e92d5
# begin
# 	df = @chain CRSP begin
		
# 		#Apple stock
# 		filter(:TICKER => (x-> ismissing(x) ? false : x=="AAPL"),_)

# 		groupby(:date)
# 		combine(_) do sdf
# 			if nrow(sdf)>=2
# 				DataFrame(sdf[2,:])
# 			else
# 				sdf
# 			end
# 		end

# 		#Adjust for stock splits
# 		transform( [:PRC, :CFACPR] => ByRow( (p,c)->p/c ) => :PRC,
# 		           [:DIVAMT, :CFACPR]  => ByRow( (d,c)->d/c ) => :DIVAMT)
		
# 	end
# end

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

# 		groupby(:date)
# 		combine(_) do sdf
# 			if nrow(sdf)>=2
# 				DataFrame(sdf[2,:])
# 			else
# 				sdf
# 			end
# 		end

# 		#Adjust for stock splits
# 		transform( [:PRC, :CFACPR] => ByRow( (p,c)->p/c ) => :PRC,
# 		           [:DIVAMT, :CFACPR]  => ByRow( (d,c)->d/c ) => :DIVAMT)

# 		select(:date, :TICKER, :PERMCO, :PERMNO, :PRC, :DIVAMT)
# 		sort(:date)

# 	end

# end

# ╔═╡ 0bd40ffd-8e71-4709-917c-04c9fca25e37
vspace

# ╔═╡ 45868894-a317-4370-9631-6ef3c31661e3
md"""
**Next, let's calculate monthly returns for AAPL/**
"""

# ╔═╡ 7b666951-b303-4100-8dd2-feb8e2d22b14
md"""
**To do this, we need to add the lagged price.**
>The `ShiftedArrays` package allows us to do this.
"""

# ╔═╡ 83a3993e-073f-4e84-acfe-61bfc76dde3a
# @chain AAPL begin

# 	sort(:date)
# 	groupby(:TICKER)
# 	transform( :PRC => (x-> ShiftedArrays.lag(x)) => :PRC_L)
	
# end

# ╔═╡ 470363be-fe40-40f1-9d53-2b5e2a15f2a0
vspace

# ╔═╡ 4805e8a6-34d6-49f0-8706-88c916e4689f
md"""
**As the next step, we need two functions. One to calculate arithmetic returns, and another to calculate log returns.**
"""

# ╔═╡ 9b816236-f9de-4aad-aea0-b5f8fbfc6b11
function GetRx(Px_t,Px_tminus,div)

	divAmt = 0.0
	if !ismissing(div)
		divAmt = div
	end

	if any( ismissing.([Px_t,Px_tminus])  )
		return missing
	else
		return (Px_t + divAmt - Px_tminus)/Px_tminus
	end
	
end

# ╔═╡ d300be65-f494-4181-9924-e69cc6c04f09
function GetLogRx(Px_t,Px_tminus,div)


	divAmt = 0.0
	if !ismissing(div)
		divAmt = div
	end

	if any( ismissing.([Px_t,Px_tminus])  )
		return missing
	else
		return log( (Px_t + divAmt) / Px_tminus )
	end
	
	
	
end

# ╔═╡ c0b48b52-0dfb-4553-b1c7-f089e36f893a
vspace

# ╔═╡ 2bd1674d-2254-45a8-9f02-5caa5bd0bd1c
md"""
**Let's now create a new dataframe with the returns for AAPL.**
"""

# ╔═╡ a23a366d-fa73-4672-b59c-e14b2b817ce8
# AAPL_Rx = @chain AAPL begin

# 	sort(:date)
# 	groupby(:TICKER)
# 	transform( :PRC => (x-> ShiftedArrays.lag(x)) => :PRC_L)

# 	#calculate the return
# 	transform( [:PRC, :PRC_L, :DIVAMT] => ByRow( (p,pl,d) -> GetRx(p,pl,d) ) => :Rx ) 

# 	#calculate log return
# 	transform( [:PRC, :PRC_L, :DIVAMT] => ByRow( (p,pl,d) -> GetLogRx(p,pl,d) ) => :LogRx ) 
	
# 	dropmissing(:Rx)
	
# end

# ╔═╡ c30fa7dc-3c4c-4332-a724-d24f32cf5cb4
vspace

# ╔═╡ 5baa1a9f-7ad5-4bfc-b468-9e0b40438548
md"""
**Now, we can calculate the cumulative return over the period from January 2000 to December 2020 from investing $1 in AAPL.**
"""

# ╔═╡ 0c821308-45ca-4317-80b3-9e87c6840465
# @chain AAPL_Rx begin
# 	combine(:Rx => (rx-> prod( 1 .+ rx)) => :V_T)	
# end

# ╔═╡ 8c58cbc6-cfbd-43de-9e68-bbaf447213fa
# @chain AAPL_Rx begin
# 	combine(:LogRx => (rx -> exp(sum(rx))) => :V_T )
# end

# ╔═╡ b4d7b148-6750-4538-9407-bd4ba02bafde
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
	
# 	dropmissing(:TICKER)
# 	filter(:TICKER => (x-> x ∈ ["AAPL","BA","DIS","GS","JNJ"]),_)
	

# 	groupby([:date,:TICKER])
# 	combine(_) do sdf
#        if nrow(sdf) == 2 
#             DataFrame(sdf[2,:])
#        else
#             sdf
#        end
#     end

	
# 	#Adjust for stock splits
# 	transform( [:PRC,:CFACPR] => ByRow(  (x,y) -> x/y) => :PRC,
# 	 		   [:DIVAMT,:CFACPR] => ByRow(  (x,y) -> any(ismissing.([x,y])) ? missing             : x/y) => :DIVAMT)	

	
# 	select(:date, :TICKER, :PERMCO, :PERMNO, :PRC, :DIVAMT)

# 	sort([:TICKER,:date])
	
# 	groupby([:TICKER])
# 	transform(:PRC => (x-> ShiftedArrays.lag(x)) => :PRC_L)
	
# 	transform([:PRC, :PRC_L, :DIVAMT] => ByRow((Px_t,Px_tminus,div) -> GetRx(Px_t,Px_tminus,div)) => :Rx,
# 			  [:PRC, :PRC_L, :DIVAMT] => ByRow((Px_t,Px_tminus,div) -> GetLogRx(Px_t,Px_tminus,div)) => :LogRx)
	
# 	dropmissing(:Rx)
# 	select(:date, :TICKER, :PERMCO, :PERMNO, :PRC, :PRC_L, :DIVAMT, :Rx, :LogRx)
	
# end

# ╔═╡ 286aadfd-c2f1-428b-babc-943e0a46200d
vspace

# ╔═╡ 0eefd0af-f5dd-4b87-9be0-391d86cf8bf9
md"""
**To form a portfolio, it is more convenient to work with the data in *wide format*. This means that we want to put the five stocks in columns (one for each stock).**
"""

# ╔═╡ da35b9a0-5ac8-4608-8dc5-2c08901cc2e3
# @chain Portfolio begin

# end

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
# describe(PortfRx)

# ╔═╡ 42f876a7-4c63-49f8-ae01-5745cdfa8fd8
vspace

# ╔═╡ fb69d701-e623-443e-b6f0-c75180b9be1b
md"""
**Let's create a table with summary statistics that we are interested in:**
average return, standard deviation of returns, minimum, median, and the maximum of monthly returns.
"""

# ╔═╡ cb78be8c-f039-434e-acbb-9375f3174588
md"""
**To create this table, it is easier to work with the data in `long` format.**
That is we have one column for the TICKER and one column for the return for each date. In this format, it is easier to group the data and to apply a data transformation.
"""

# ╔═╡ cdda5183-46c6-4283-a66f-168ed5790a77
# @chain PortfRx begin

# end

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

# ╔═╡ 4cfeda6b-6b12-4ffa-9379-15c00b53a49d
md"""
**Next, let's calculate the covariance matrix of returns.**
"""

# ╔═╡ 80865386-79cf-45b0-836d-e55a1ca64174
# cov(Matrix(PortfRx[:,Not(:date)]))

# ╔═╡ 7addc4e7-d90f-404c-91dc-375bf93eef95
vspace

# ╔═╡ aa21f05c-1e78-4919-86fa-57ae89d4d633
md"""
**Lastly, let's use what we have learned about portfolio mathematics at the beginning of this lecuture and apply it to our portfolio of stocks.**
"""

# ╔═╡ fa05b130-4ab5-49ea-8a8c-f6d9fcfd1656
# let
# 	assets = filter(:TICKER => (x->x!="PortfRx"), PortfSummary)
# 	μ = 
# 	Σ = 

# 	ERp   = 
# 	VarRp = 
	
# 	with_terminal() do
# 		printyellow("expected returns*100: ")


# 		printyellow("covariance matrix*100^2:")


# 		printlnPs("Expected portfolio return: ",ERp)

		
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
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.0"
manifest_format = "2.0"
project_hash = "4c558f4fb79e6f7af92f1c1dee28e0ed29afa0eb"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "0f748c81756f2e5e6854298f11ad8b2dfae6911a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "PrecompileTools", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings", "WorkerUtilities"]
git-tree-sha1 = "a44910ceb69b0d44fe262dd451ab11ead3ed0be8"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.13"

[[deps.Chain]]
git-tree-sha1 = "9ae9be75ad8ad9d26395bf625dea9beac6d519f1"
uuid = "8be319e6-bccf-4806-a6f7-6fae938471bc"
version = "0.6.0"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "59939d8a997469ee05c4b4944560a820f9ba0d73"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.4"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "c955881e3c981181362ae4088b35995446298b80"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.14.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+1"

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
git-tree-sha1 = "0f4b5d62a88d8f59003e43c25a8a90de9eb76317"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.18"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FilePathsBase]]
deps = ["Compat", "Dates", "Mmap", "Printf", "Test", "UUIDs"]
git-tree-sha1 = "9f00e42f8d99fdde64d40c8ea5d14269a2e2c1aa"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.21"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

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
git-tree-sha1 = "8b72179abc660bfab5e28472e019392b97d0985c"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.4"

[[deps.InlineStrings]]
deps = ["Parsers"]
git-tree-sha1 = "9cc2baf75c6d09f9da536ddf58eb2f29dedaf461"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.4.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InvertedIndices]]
git-tree-sha1 = "0dc7b50b8d436461be01300fd8cd45aa0274b038"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.3.0"

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
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+2"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "71a22244e352aa8c5f0f2adde4150f62368a3f2e"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.58"

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
git-tree-sha1 = "88b895d13d53b5577fd53379d913b9ab9ac82660"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.3.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "0e7508ff27ba32f26cd459474ca2ede1bc10991f"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.ShiftedArrays]]
git-tree-sha1 = "503688b59397b3307443af35cd953a13e8005c16"
uuid = "1277b4bf-5013-50f5-be3d-901d8477a67a"
version = "2.0.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "a04cabe79c5f01f4d723cc6704070ada0b9d46d5"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.3.4"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

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
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "cb76cf677714c095e535e3501ac7954732aeea2d"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.11.1"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
git-tree-sha1 = "a09c933bebed12501890d8e92946bbab6a1690f1"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.10.5"
weakdeps = ["Random", "Test"]

    [deps.TranscodingStreams.extensions]
    TestExt = ["Test", "Random"]

[[deps.Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

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
version = "5.8.0+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

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
# ╟─5d4fc0ee-e3aa-404a-8983-bdf73cd4abe1
# ╟─75007c57-94e8-49fc-8bbb-3d39d6207fa2
# ╠═c1a5ff0e-ce5e-4390-bed7-af5be140a145
# ╟─5b46d617-14f3-4c85-8e79-76a75c324fc5
# ╟─e6c198f4-5abd-468c-841c-8a7b032f1dc2
# ╟─6751abe5-ef25-4d89-bed7-7cf7811fa2d8
# ╟─1cfe8c37-83ce-42fb-b4ad-c9ccb20bff52
# ╟─82a86a66-53de-46d4-837c-2dce5b1f1f44
# ╟─b65a5a50-b811-41c2-b136-a2b98797f05a
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
# ╟─18675b31-2a97-4b2f-91b9-7c070b396c29
# ╟─b8051d63-ed26-4e21-8a98-f564a3b8a967
# ╠═a0cf0361-422a-4bcd-8b9e-943dc00044b3
# ╟─a909cc2f-ac8f-4c29-9daa-c1117bc821f2
# ╟─6b720ade-5e4c-4f58-8fcd-f609df29df7b
# ╠═0cf85da2-a538-402d-9785-094425260bdb
# ╟─1861c6a9-1fb1-4332-8c50-3ed5fd429f14
# ╟─a65fa0ae-1ceb-451e-ab37-08c0d23a508e
# ╠═523e0191-237e-4bdb-b9a3-53079b9e92d5
# ╟─5d055fb4-5026-40aa-920d-f39d261e65a2
# ╟─8a869ecb-a6ed-499d-873b-131c9bc2e0b1
# ╠═446e0db1-8107-4724-b774-561c5d37f87a
# ╟─0bd40ffd-8e71-4709-917c-04c9fca25e37
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
# ╟─a488a679-6dc0-4a33-b327-9d0f6e3b9eb2
# ╟─76adf9cb-db2c-4b76-9614-be12bb9c5764
# ╠═99c0ee6b-e040-4261-992c-0f5a0eb8158c
# ╟─286aadfd-c2f1-428b-babc-943e0a46200d
# ╟─0eefd0af-f5dd-4b87-9be0-391d86cf8bf9
# ╠═da35b9a0-5ac8-4608-8dc5-2c08901cc2e3
# ╟─3a003855-e6cc-4e30-95c3-02cb04435d9c
# ╟─6572bd2f-76e8-4735-9dff-d371fe7f69bd
# ╠═e5c2b68f-4f1e-4bd1-8240-ac52d268304b
# ╟─31d90f3b-0699-4c63-9c51-a558a1ee70b1
# ╟─16cc7074-d786-4bb5-a735-187465e815e2
# ╠═87099910-dfde-4fee-8910-1d6bd25d5170
# ╟─775e1297-84ff-4982-99f4-44a85892f936
# ╟─c63e96e7-0ea0-4daf-a230-26b258f12e79
# ╠═07e767e6-d6fc-4f52-8b9d-72ca7c633955
# ╟─42f876a7-4c63-49f8-ae01-5745cdfa8fd8
# ╟─fb69d701-e623-443e-b6f0-c75180b9be1b
# ╟─cb78be8c-f039-434e-acbb-9375f3174588
# ╠═cdda5183-46c6-4283-a66f-168ed5790a77
# ╟─e7b781db-dee4-4905-93bd-d5e2be32d0e6
# ╟─c799f1ad-b82b-4421-bb71-d07cb7b6afd7
# ╠═b1a76909-a53f-492a-bec2-5415d90d5de4
# ╟─ba8d8e35-aef4-458d-ba2d-742714ef4977
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
