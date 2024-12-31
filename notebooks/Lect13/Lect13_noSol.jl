### A Pluto.jl notebook ###
# v0.19.40

using Markdown
using InteractiveUtils

# ╔═╡ 3d731294-71d0-4b34-85e2-96d29bd8a7ca
begin
	using CSV, Chain, DataFrames, Dates, LinearAlgebra, ShiftedArrays, Statistics
	
	using Plots
	
end

# ╔═╡ c43df4a3-a1d8-433e-9a1c-f7c0984be879
# ╠═╡ show_logs = false
begin

	
	using Pkg
	#Pkg.upgrade_manifest()
	#Pkg.update()
	#Pkg.resolve()
	
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
#helper functions
#round to digits, e.g. 6 digits then prec=1e-6
roundmult(val, prec) = (inv_prec = 1 / prec; round(val * inv_prec) / inv_prec)

	
using Logging
global_logger(NullLogger())
	
display("")
	
end

# ╔═╡ 49fdad82-e563-4e4c-88a1-33166e9ddee4
begin
	using JuMP
	import Ipopt
end

# ╔═╡ 81404cf5-bd49-4dda-8471-fc1c8417199b
begin
	using Convex
	import SCS 
end

# ╔═╡ 5247cc42-643c-4cb1-9169-df5846bef2da
html"""
	<p align=left style="font-size:32px; font-family:family:Georgia"> <b> FINC 672: Workshop in Finance - Empirical Methods</b> <p>
	"""

# ╔═╡ 036e21fc-88bc-4e7a-be2b-752aaa1e978a
begin 
	html"""
	<p style="padding-bottom:1cm"> </p>
	<div align=center style="font-size:25px; font-family:family:Georgia"> FINC-672: Workshop in Finance - Empirical Methods </div>
	<p style="padding-bottom:1cm"> </p>
	<p align=center style="font-size:25px; font-family:family:Georgia"> <b> Mean-Variance Analysis </b> <p>
	<p style="padding-bottom:1cm"> </p>
	<p align=center style="font-size:25px; font-family:family:Georgia"> Spring 2024 <p>
	<p style="padding-bottom:0.5cm"> </p>
	<div align=center style="font-size:20px; font-family:family:Georgia"> Prof. Matt Fleckenstein </div>
	<p style="padding-bottom:0.05cm"> </p>
	<div align=center style="font-size:20px; font-family:family:Georgia"> University of Delaware, 
	Lerner College of Business and Economics </div>
	<p style="padding-bottom:0.5cm"> </p>
	"""
end

# ╔═╡ afb78391-4719-4049-8aad-f210142ec27b
vspace

# ╔═╡ 42e56e7e-79dc-4823-9145-2bd2e0caa14f
html"""
<fieldset>      
<legend>Goals for today</legend>      
<br>
  <input type="checkbox" value="">Implement Mean-Variance Analysis in Julia. <br>      
<br>
</fieldset>      
"""

# ╔═╡ c432c113-2bb2-4852-bc08-80aba4cff440
vspace

# ╔═╡ 5fc44a1a-2c5c-4cdf-b2da-4cbc17c8f8a3
TableOfContents(aside=true, depth=1)

# ╔═╡ 9e3d6627-1924-4f07-8438-d61b12619db7
vspace

# ╔═╡ ed64f108-1b86-4db3-8e37-2043cf9b4887
md"""
# Mean-Variance Frontier
"""

# ╔═╡ 6c641b4c-0f38-4e8c-aa5e-01461352a302
md"""
- Mean-Variance analysis starts by providing the vector of expected returns $\mu$ and the covariance matrix $\Sigma$ of the investable assets.

- Then, it plots the "mean variance" frontier: it is a scatter plot showing the lowest possible portfolio standard deviation $\textrm{Std}(R_p)$ on the horizontal axis at a required average return $\textrm{E}R_p=\mu^*$ on the vertical axis. 

- We consider many different values to create the scatter. In most figures we connect the dots to form a curve.

- Remember: to calculate the expected return and the variance of a portfolio with portfolio weights $w$ in the vector use

$$\textrm{E}R_p = w^T\mu$$
$$\textrm{Var}(R_p) = w^T\Sigma\,w$$

- Also, the sum of the portfolio weights should equal 1.
"""

# ╔═╡ bad43e5e-bc0b-4d0c-99e2-bdc6a9d4a1e2
vspace

# ╔═╡ 70564b11-4360-48a8-80da-adcaa451b5b2
md"""
# Case of Two Assets
"""

# ╔═╡ 2a934e16-74c7-4dc2-bbd0-f47006331422
md"""
- With only two investable assets, all portfolios of them are on the MV frontier. 
- We can therefore trace out the entire MV frontier by calculating the means and standard deviations of a range of portfolios with different weights $(w_1,1-w_1)$ on the two assets.
"""

# ╔═╡ 48ae81d0-a594-4b9a-8d1f-4785576e1184
let

μ = [11.5, 6]/100            #expected returns
Σ = [166   58;               #covariance matrix
      58  100]/100^2

printyellow("expected returns, %:")
printmat(μ*100,rowNames=["asset 1","asset 2"])

printyellow("covariance matrix, bp:")
printmat(Σ*100^2,rowNames=["asset 1","asset 2"],colNames=["asset 1","asset 2"])

end

# ╔═╡ 35d2fe96-69cd-4b1d-aa5b-675dc24031cf
vspace

# ╔═╡ b3a7702e-b5a0-4921-9205-1715c13ee7c9
md"""
- Next, let's draw the MV frontier.
"""

# ╔═╡ a5c28138-8f15-4636-908f-0a43ca9321e3
begin
	
μ_2 = [11.5, 6]/100            #expected returns
Σ_2 = [166   58;               #covariance matrix
       58  100]/100^2
	
L_2        = 41
w₁_range_2 = range(1.5,-0.5,length=L_2)           #different possible weights on asset 1

(ERₚ_2,StdRₚ_2) = (fill(NaN,L_2),fill(NaN,L_2))   #to put the results in
	
for i = 1:L_2
    w_2        = [w₁_range_2[i];1-w₁_range_2[i]]  #weights on asset 1 and 2
    ERₚ_2[i]   = w_2'μ_2
    StdRₚ_2[i] = sqrt(w_2'Σ_2*w_2)
end

p_2 = plot( StdRₚ_2*100,ERₚ_2*100,
           legend = nothing,
           linecolor = :red,
           xlim = (0,15),
           ylim = (0,15),
           title = "Mean vs standard deviation",
           xlabel = "Std(Rₚ), %",
           ylabel = "ERₚ, %" )

scatter!(sqrt.(diag(Σ_2))*100,μ_2*100,markercolor=:red)

p_2
	
end

# ╔═╡ bc3df0e8-1f74-456a-9e2a-8a69279a78c9
vspace

# ╔═╡ 72c219a7-1c04-4678-988c-8f17674d9d75
md"""
# Case of Three Assets
- Suppose we estimate the average returns and the covariance matrix of returns for three assets (A, B, and C).
- Let the riskfree rate be $r_f=0.03$.
"""

# ╔═╡ 652dc6ae-6f9d-4ebd-9251-00821a8ee09d
begin
μ_3 = [0.115, 0.095, 0.06]    #expected returns
Σ_3 = [166  34  58;           #covariance matrix
	    34  64   4;
	    58   4 100]/100^2
Rf_3 = 0.03

assetNames_3 = ["A","B","C"]

	
printyellow("μ and Rf in %:")
printmat(μ_3*100,rowNames=assetNames_3)
printmat(Rf_3*100)

printyellow("Σ in bp:")
printmat(Σ_3*100^2;rowNames=assetNames_3,colNames=assetNames_3)
	
end

# ╔═╡ ebc5f144-20ff-4451-a241-f4c046520b98
vspace

# ╔═╡ 8e80ef11-e81d-40f1-a04d-aaa857b27376
md"""
- Let's create a few portfolios.
"""

# ╔═╡ 3259e4c6-4275-497d-9831-da7bcf767e3d
begin

w_3 = [0 0.22 0.02 0.25;            #different portfolios (one in each column)
        1 0.30 0.63 0.68;
        0 0.48 0.35 0.07]
K_3 = size(w_3,2)                     #number of different portfolios

(ERₚ_3,StdRₚ_3) = (fill(NaN,K_3),fill(NaN,K_3))
for i = 1:K_3
    ERₚ_3[i]   = w_3[:,i]'μ_3
    StdRₚ_3[i] = sqrt(w_3[:,i]'Σ_3*w_3[:,i])
end

printyellow("mean and std (in %) of portfolio: ")
printmat([ERₚ_3';StdRₚ_3']*100,colNames=["A","1","2","3"],rowNames=["mean","std"])
	
end

# ╔═╡ b4da6bba-d8a0-4d50-bc0d-fc31566e07a5
vspace

# ╔═╡ 0b82837f-4a25-41d5-9ee7-e1cb49110980
md"""
- Let's plot the portfolios.
"""

# ╔═╡ a599bc02-5a02-4b31-b75d-2c3e6a732b13
begin
	
p_3 = scatter( sqrt.(diag(Σ_3))*100,μ_3*100,
              markercolor = :red,
              label = "original assets",
              xlim = (0,15),
              ylim = (0,15),
              title = "Mean vs standard deviation",
              xlabel = "Std(Rₚ), %",
              ylabel = "ERₚ, %",
              legend = :topleft )

scatter!(StdRₚ_3*100,ERₚ_3*100,marker=:xcross,markercolor=:blue,label="some portfolios")

p_3

end

# ╔═╡ 29da3b0b-b027-4da2-a31c-d3c7c0bfceb0
vspace

# ╔═╡ d558b927-2cea-45ef-b50b-0f53640e49d4
md"""
# MV Frontier of Risky Assets
"""

# ╔═╡ fae8140d-9eea-432b-a858-ec12d3728ef2
md"""
- We define a function to implement the approach discussed in `Reading_MVAnalysis_Main.pdf` available on Canvas.
"""

# ╔═╡ 038a6edf-979a-49b3-8058-8c91118bd9ef
md"""
- To find the MV frontier with 3 or more assets we have to solve the optimization problem

$$\textrm{min} \textrm{Var}R_p \textrm{ s.t. } \textrm{E}R_p = \mu^*$$

and clearly also that the sum of portfolio weights equals 1.

- This can be done with a numerical minimization routine or by linear algebra (at least when we do not put any further restrictions on the portfolio weights). 
- The next cells use the linear algebra approach: it solves for $w$ from the linear equations (first order conditions).

$$\left[ {\begin{array}{*{20}{c}}
\Sigma &\mu &{{1_n}}\\
{\mu '}&0&0\\
{1_n^1}&0&0
\end{array}} \right]\left[ {\begin{array}{*{20}{c}}
w\\
\lambda \\
\delta 
\end{array}} \right] = \left[ {\begin{array}{*{20}{c}}
{{0_n}}\\
{{\mu ^*}}\\
1
\end{array}} \right]$$

"""

# ╔═╡ bba52baa-08a6-4dca-9bbf-467ff2340df6
vspace

# ╔═╡ 3fca5d0e-c342-4520-867c-917116495ac2
"""
    MVCalc(μstar,μ,Σ)

Calculate the std and weights of a portfolio (with mean return μstar) on MVF of risky assets.

- Remark
  - Only (λ,δ) and thus (w,stdRp) depend on μstar. We could therefore speed up the computations a bit by doing the loop over different μstar values inside the function (and thus not recalculate Σ_1,a,b,c).
  - See p. 60 of lecture notes `lecture_10_Reading.pdf` available on Canvas.
"""
function MVCalc(μstar,μ,Σ)
    n    = length(μ)
    Σ_1  = inv(Σ)
    a    = μ'Σ_1*μ
    b    = μ'Σ_1*ones(n)
    c    = ones(n)'Σ_1*ones(n)
    λ    = (c*μstar - b)/(a*c-b^2)
    δ    = (a-b*μstar)/(a*c-b^2)
    w    = Σ_1 *(μ*λ.+δ)
    StdRp = sqrt(w'Σ*w)
    return StdRp,w
end

# ╔═╡ f6ccdc25-091b-4205-b6df-46fa49427e34
vspace

# ╔═╡ 18130d75-5c5d-4178-99e0-160f7caee2f6
md"""
- Let's test our function.
"""

# ╔═╡ dc66ea04-4cad-4f47-9435-f7448394169d
begin

(StdAt10,wAt10) = MVCalc(0.1,μ_3,Σ_3)
printyellow("Testing: the portfolio with a mean return of 10%")
printlnPs("\nstd: ",StdAt10)

printlnPs("\nw and its sum: ")
printmat([wAt10;sum(wAt10)],rowNames=[assetNames_3;"sum"])

	
end

# ╔═╡ d31feaf5-97f1-41c3-a13e-36d410ed97fc
vspace

# ╔═╡ b16ecff8-2dc1-4827-b33c-5eb0af4a6961
md"""
- Let's pick a range of values for $\mu$ and plot the mean-variance frontier.
"""

# ╔═╡ 95a13699-95b4-4f7b-baaa-80627f33841f
begin
	
	μstar_range_MV = range(Rf_3,0.15,length=101)
	L_MV           = length(μstar_range_MV)
	
	StdRₚ_MV  = fill(NaN,L_MV)  #loop over different required average returns, (μstar_range)

	for i = 1:L_MV
	    StdRₚ_MV[i] = MVCalc(μstar_range_MV[i],μ_3,Σ_3)[1]   #[1] picks out the first function output
	end
	
	p_MV = plot( StdRₚ_MV*100,μstar_range_MV*100,
	           legend = nothing,
	           linecolor = :red,
	           xlim = (0,15),
	           ylim = (0,15),
	           title = "Mean vs standard deviation",
	           xlabel = "Std(Rₚ), %",
	           ylabel = "ERₚ, %" )
	
	
end

# ╔═╡ 0994b91b-0048-41ca-a485-836f267300c4
vspace

# ╔═╡ 63c6b02c-4674-45b4-a96a-2545959d9d7c
md"""
- Let's add the individual assets.
"""

# ╔═╡ c40dc723-1169-4826-941d-ba162d2bf7b8
begin
	
	#Add Asset A
	p_MV2 = scatter!(p_MV,[sqrt.(Σ_3[1,1])*100],[μ_3[1]*100], markershape=:circle,markersize=6, markerstrokewidth=1, markercolor=:red,label="")
	annotate!(p_MV2,[sqrt.(Σ_3[1,1])*100+1],[μ_3[1]*100],"A")
	
	#Add Asset B
	scatter!(p_MV2,[sqrt.(Σ_3[2,2])*100],[μ_3[2]*100], markershape=:circle,markersize=6, markerstrokewidth=1, markercolor=:red,label="")
	annotate!(p_MV2,[sqrt.(Σ_3[2,2])*100+1],[μ_3[2]*100],"B")
	
	#Add Asset C
	scatter!(p_MV2,[sqrt.(Σ_3[3,3])*100],[μ_3[3]*100], markershape=:circle,markersize=6, markerstrokewidth=1, markercolor=:red,label="")
	annotate!(p_MV2,[sqrt.(Σ_3[3,3])*100+1],[μ_3[3]*100],"C")
	
end

# ╔═╡ 33845c97-5df5-403c-996c-7d9583b6a0ba
vspace

# ╔═╡ ef313c73-14bd-42d9-a1d4-c35709dec26c
md"""
- Let's add other portfolios.
Portfolio weights

Portfolio weights	|  B     |   1     |   2     |   3
:---|:-------|:--------|:--------|:-------
A   |  0.00  |   0.72  |   0.02  |   0.05
B   |  1.00  |   0.08  |   0.63  |   0.15
C   |  0.00  |   0.20  |   0.35  |   0.80

"""

# ╔═╡ a6847628-d355-4d57-a97f-c981b246eca5
vspace

# ╔═╡ 69f5983a-5e47-4331-9518-6c8c30340b24
md"""
- Let's make a table with the means and standard deviations of Portfolio 1, 2, and 3.
"""

# ╔═╡ 212685c3-9049-42e9-b535-6e515f19153b
begin
	
 df_MV = DataFrame(P1=[0.72,0.08,0.20],P2=[0.15,0.35,0.60],P3=[0.05,0.15,0.8])
	
 df_MV_μ = combine(df_MV, [:P1,:P2,:P3] .=> (x->x'μ_3*100), renamecols=false)
	
 df_MV_σ = combine(df_MV, [:P1,:P2,:P3] .=> (x->sqrt(x'Σ_3*x)*100), renamecols=false)	

 df_MV_μσ = vcat(df_MV_μ,df_MV_σ)
	
end

# ╔═╡ 62d63384-ce4b-4bc0-9fb7-b25d4b276d99
vspace

# ╔═╡ 77a08244-548c-4a7a-be3e-cdc8c6e29622
md"""
- Now, we add the portfolios to the plots.
"""

# ╔═╡ f3f52640-d079-4d6c-8c2a-63f89c53b061
begin
	
	#add other portfolios
	
	#1
	p_MV3 = scatter!(p_MV2,[df_MV_μσ[2,:P1]], [df_MV_μσ[1,:P1]], markershape=:diamond,markersize=3, label="")
	annotate!(p_MV3,[df_MV_μσ[2,:P1]+0.2],[df_MV_μσ[1,:P1]],("1",12,:green))
	
	#2
	scatter!(p_MV3,[df_MV_μσ[2,:P2]], [df_MV_μσ[1,:P2]], markershape=:diamond,markersize=3, label="")
	annotate!(p_MV3,[df_MV_μσ[2,:P2]+0.2],[df_MV_μσ[1,:P2]],("2",12,:green))
	
	#3
	scatter!(p_MV3,[df_MV_μσ[2,:P3]], [df_MV_μσ[1,:P3]], markershape=:diamond,markersize=3, label="")
	annotate!(p_MV3,[df_MV_μσ[2,:P3]+0.2],[df_MV_μσ[1,:P3]],("3",12,:green))
	
end

# ╔═╡ c383ce27-b36a-4742-9213-d167c10fafd9
vspace

# ╔═╡ fa8d6069-e8da-4bba-8475-d20c5c6dc090
md"""
# MV Frontier of Riskfree and Risky Assets
"""

# ╔═╡ e1264493-cd70-487c-b2c5-ced6a1594ea7
md"""
All portfolios on the MV frontier of both risky and riskfree assets have (a vector of) portfolio weights on the risky assets as in

$$w=\frac{\mu^{*} - R_f}{\mu^{e} \\' \, \Sigma\,\mu^{e}} \, \Sigma^{-1} \mu^e$$

where $\mu^{*}$ is the required average return.

- The weight of the riskfree asset is $\mathbf{1} - \mathbf{1}' \, w$.

"""

# ╔═╡ ca56d3a7-3e25-4dc3-a92a-0ad040c853b0
vspace

# ╔═╡ 33fe5282-db49-4732-9c80-cc1537c120c5
md"""
We define a function to implement the approach discussed in `lecture_10_Reading.pdf` available on Canvas.
"""

# ╔═╡ ecf84238-b03d-4036-8fd3-88bcb394c925
"""
    MVCalcRf(μstar,μ,Σ,Rf)

Calculate the std and portfolio weights of a portfolio (with a given mean, μstar) on MVF of (risky assets,riskfree). See p. 62 of lecture notes `lecture_10_Reading.pdf` available on Canvas.
"""
function MVCalcRf(μstar,μ,Σ,Rf)
    μe    = μ .- Rf
    Σ_1   = inv(Σ)
    w     = (μstar-Rf)/(μe'Σ_1*μe) * Σ_1*μe
    StdRp = sqrt(w'Σ*w)
    return StdRp,w                    #std and portfolio weights
end

# ╔═╡ 9b9170a8-cfcc-45e1-aa4d-57a4ccca9c31
vspace

# ╔═╡ 23c73d39-6e64-4718-87a4-4ea2937af09a
md"""
- Let's test our function.
"""

# ╔═╡ 9eccf04c-f202-4c23-ac85-1b5773501e0f
let
	
(Std,w) = MVCalcRf(0.1,μ_3,Σ_3,Rf_3)

printyellow("Testing: the portfolio with a mean return of 10%")
printlnPs("\nstd: ",Std)

printlnPs("\nw and its sum: ")
printmat([w;sum(w)],rowNames=[assetNames_3;"sum"])

printlnPs("weight on riskfree:",1-sum(w))
	
end

# ╔═╡ 7be5e54c-346b-434f-97a2-4f35ff251ddf
vspace

# ╔═╡ 2e082d7a-7fec-44e9-8697-78a1328e7d3d
md"""
- Let's plot the efficient frontier with a riskfree asset.
"""

# ╔═╡ e1ac8d53-000e-44d7-8090-334468a6d2ad
begin

StdRpRf  = fill(NaN,L_MV)                 #loop over required average returns (μstar)
for i = 1:L_MV                            #too bad that R\_f[Tab] is not defined 
    StdRpRf[i] = MVCalcRf(μstar_range_MV[i],μ_3,Σ_3,Rf_3)[1]
end


pMVRf = plot( StdRpRf*100,μstar_range_MV*100,
           legend = nothing,
           linecolor = :blue,
           xlim = (0,15),
           ylim = (0,15),
           title = "Mean vs standard deviation",
           xlabel = "Std(Rₚ), %",
           ylabel = "ERₚ, %" )
	
plot!(pMVRf, [StdRₚ_MV StdRpRf]*100,μstar_range_MV*100,
           legend = nothing,
           linecolor = [:red :blue],
           xlim = (0,15),
           ylim = (0,15),
           title = "Mean vs standard deviation",
           xlabel = "Std(Rₚ), %",
           ylabel = "ERₚ, %" )

	
scatter!(pMVRf, sqrt.(diag(Σ_3))*100,μ_3*100,markercolor=:red)
	
pMVRf

end

# ╔═╡ 26c13abf-c870-469d-a952-d62c12762e5b
vspace

# ╔═╡ 74e6c915-5dca-4c84-a890-0b829ba6cd92
md"""
# The Tangency Portfolio
"""

# ╔═╡ 9d28d905-5c73-4cff-a321-c88a6d4c854a
md"""
The tangency portfolio is a particular portfolio on the MV frontier of risky and riskfree assets, where the weights on the risky assets sum to 1. 
- It is therefore also on the MV frontier of risky assets only. 
- The vector of portfolio weights is

$$w_T = \frac{\Sigma^{-1}\, \mu^{e}}{\mathbf{1}' \Sigma^{-1} \, \mu^{e}}$$

"""

# ╔═╡ 68d41a8a-0c52-4044-818d-b0e2a0c01f62
vspace

# ╔═╡ 5be9cfce-89e0-4ad7-9aef-dd3252829c18
md"""
- We define a function to implement the approach discussed in `lecture_10_Reading.pdf` available on Canvas.
"""

# ╔═╡ fe44f447-72db-4c05-ba03-6c26e1573bd6

"""
    MVTangencyP(μ,Σ,Rf)

Calculate the tangency portfolio. See p. 65 of lecture notes `lecture_10_Reading.pdf` available on Canvas.
"""
function MVTangencyP(μ,Σ,Rf)           #calculates the tangency portfolio
    n    = length(μ)
    μe   = μ .- Rf                    #expected excess returns
    Σ_1  = inv(Σ)
    w    = Σ_1 *μe/(ones(n)'Σ_1*μe)
    muT  = w'μ + (1-sum(w))*Rf
    StdT = sqrt(w'Σ*w)
    return w,muT,StdT                  #portolio weights, mean and std
end


# ╔═╡ 3652b806-8991-47d4-ad82-e8affde497f6
md"""
- Let's collect the tangency portfolio weights, and the expected return and standard deviation of the returns of the tangency portfolio.
"""

# ╔═╡ fc304ff1-e4ff-4047-a8d3-353816202724
begin
	(wT,μT,σT) = MVTangencyP(μ_3,Σ_3,Rf_3)
		
	println("Tangency portfolio: ")
	printmat(wT,rowNames=assetNames_3)
	printlnPs("mean and std of tangency portfolio, %: ",[μT σT]*100)
	printlnPs("sum(w)",sum(wT))
end

# ╔═╡ 391fa810-47bf-41f5-aa20-ff65a25a3f27
vspace

# ╔═╡ d8f38fb7-f84c-4266-b32e-7111701d4b5a
md"""
By mixing the tangency portfolio and the riskfree, we can create any point on the MV frontier of risky and riskfree (also called the Capital Market Line, CML).

The code below shows the expected return and standard deviation of several portfolio (different  values) of the form

$$R_v = v \, R_T + (1-v) \, R_f$$

where $R_T = w_T'\,R$.
"""

# ╔═╡ 0b30896b-d6da-4391-a2dc-e9e0bcbe2fa2
md"""
- Let's add the tangency portfolio to the mean-variance frontier.
"""

# ╔═╡ 83a1fb1d-221b-4f26-8e65-e319ea9b899d
begin
	
v_range = [0;0.44;1;1.41]      #try different mixes of wT and Rf

ERᵥ   = v_range*μT + (1.0.-v_range)*Rf_3                 
StdRᵥ = abs.(v_range)*σT

pRᵥ = plot( [StdRₚ_MV StdRpRf]*100,μstar_range_MV*100,
           legend= nothing,
           linecolor = [:red :blue],
           xlim = (0,15),
           ylim = (0,15),
           title = "Mean vs standard deviation",
           xlabel = "Std(Rₚ), %",
           ylabel = "ERₚ, %" )
scatter!(StdRᵥ*100,ERᵥ*100)

pRᵥ

end

# ╔═╡ 2c31fd4e-9cc7-43ff-9771-bb154a181d82
vspace

# ╔═╡ 9b95ee4b-96c2-4173-a2b2-315f21c11a30
md"""
## Examples of Tangency Portfolios
"""

# ╔═╡ 82c61b57-ee82-44db-b430-022e3b116d63
let

μb = [9; 6]/100                     #means
Σb = [ 256  0;
      0    144]/100^2
Rfb = 1/100
wT, = MVTangencyP(μb,Σb,Rfb)
printmat(wT,rowNames=["asset 1","asset 2"])

wT, = MVTangencyP([13; 6]/100,Σb,Rfb)
printmat(wT,rowNames=["asset 1","asset 2"])

Σb = [ 1  -0.8;
      -0.8    1]
wT, = MVTangencyP(μb,Σb,Rfb)
printmat(wT,rowNames=["asset 1","asset 2"])

Σb = [ 1  0.8;
      0.8    1]
wT, = MVTangencyP(μb,Σb,Rfb)
printmat(wT,rowNames=["asset 1","asset 2"])
	
end

# ╔═╡ fe28e36c-c8c9-4c3b-a23e-8d15baf33827
vspace

# ╔═╡ 3f73b5cf-fe07-4bd5-8306-e319024f4bb9
md"""
# Mean Variance Analysis using CRSP Data
"""

# ╔═╡ dff92924-af65-444c-9ac6-62c0449f7c41
md"""
- Let's pick six stocks from CRSP: AAPL BA CAT GS PG WMT.
"""

# ╔═╡ e0bffa07-2db9-4ec1-a116-474d71050df6
md"""
Ticker | Company Name
:------|:-------------
AAPL | 	Apple Inc
AXP	 |  American Express Co
CAT  | 	Caterpillar Inc
GS   | 	Goldman Sachs Group Inc/The
MRK	 |  Merck & Co Inc
WMT  | 	Walmart Inc
"""

# ╔═╡ 296b85d2-2dac-4cf4-aa86-b33f0ca13650
# StockTicker = ["AAPL","AXP","CAT","GS","MRK","WMT"]

# ╔═╡ 322112e3-3aee-4e70-8203-6a1227a448de
md"""
- Let's load the CRSP data into a dataframe.
"""

# ╔═╡ 624bfb0a-3336-448d-982a-511f9743202c
# CRSP = CSV.read("CRSP_monthly.csv",DataFrame)

# ╔═╡ e2e22821-c6c1-4e98-a5f4-725595c3f250
md"""
- In addition to the stock returns, we need an estimate of the riskfree interest rate.
- We will use the widely-used Fama-French dataset available on the [website of Kenneth French](https://mba.tuck.dartmouth.edu/pages/faculty/ken.french/data_library.html).
- The monthly dataset is available on Canvas under the datasets section. Download it from there (file name `F-F_Research_Data_Factors.csv`).
"""

# ╔═╡ b3ac63b0-aebd-4fff-9e98-82d0f4bbb8dc
# FF = CSV.read("F-F_Research_Data_Factors.csv", DataFrame; header=4,skipto=5)

# ╔═╡ d751ef72-7ab1-45f0-8375-7831175f075f
md"""
- Next, let's estimate the riskfree interest rate.
"""

# ╔═╡ 7465eeed-9af0-4504-9154-be22c8160a4b
# RF = @chain FF begin
	
# 	transform(:Date => ByRow(x-> lastdayofmonth( Date( string(x), dateformat"yyyymm"))), 
# 		      :RF =>(x-> x./100), renamecols=false)
	
# 	select(:Date,:RF)
	
# end

# ╔═╡ f07348bf-2ec1-4a83-9f1d-6af7787bd42d
md"""
- Next, let's define function to calculate stock returns (simple returns and log returns).
"""

# ╔═╡ a53c4108-7ee7-4547-afee-dfaacf87d944
# function GetRx(Px_t,Px_tminus,div)
# 	divAmt = 0.0
# 	if !ismissing(div)
# 		divAmt = div
# 	end
		
# 	if any(ismissing.([Px_t,Px_tminus]))
# 		return missing
# 	else
# 		return (Px_t + divAmt - Px_tminus)/Px_tminus
# 	end
# end

# ╔═╡ 3d053364-5a63-41b1-b654-9d99e00cc6c3
# function GetLogRx(Px_t,Px_tminus,div)
# 	divAmt = 0.0
# 	if !ismissing(div)
# 		divAmt = div
# 	end
		
# 	if any(ismissing.([Px_t,Px_tminus]))
# 		return missing
# 	else
# 		return log((Px_t + divAmt)) - log(Px_tminus)
# 	end
# end

# ╔═╡ db15e7a8-6912-49ae-81b4-c22abc40aac5
md"""
- Next, we filter the CRSP dataset to our set of stocks and calculate returns. We also convert the dates to Julia dates.
"""

# ╔═╡ 5deea522-f60b-4242-8c9f-26ee7c243677
# df = @chain CRSP begin
	
# 	dropmissing(:TICKER)
	
# 	filter(:TICKER => (x-> x ∈ StockTicker),_)
	
# 	select(:date, :TICKER, :PERMCO, :PERMNO, :PRC, :DIVAMT, :CFACPR)

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
# 			   [:DIVAMT,:CFACPR] => ByRow(  (x,y) -> any(ismissing.([x,y])) ? missing : x/y) => :DIVAMT)

	
	
	
#     sort([:TICKER,:date])
# 	groupby([:TICKER])
# 	transform(:PRC => (x-> lag(x)) => :PRC_L)
	
# 	transform([:PRC, :PRC_L, :DIVAMT] => ByRow((Px_t,Px_tminus,div) -> GetRx(Px_t,Px_tminus,div)) => :Rx,
# 			  [:PRC, :PRC_L, :DIVAMT] => ByRow((Px_t,Px_tminus,div) -> GetLogRx(Px_t,Px_tminus,div)) => :LogRx)
# 	dropmissing(:Rx)

# 	select(:date, :TICKER, :PERMCO, :PERMNO, :PRC, :PRC_L, :DIVAMT, :Rx, :LogRx)
	
# end

# ╔═╡ b26bf12b-f377-4228-9ac6-9af67eaf6880
md"""
- To work with the data, we unstack it and put it into wide format (i.e. we have the stocks in the columns and a single dates column).
"""

# ╔═╡ 3f2eb8f8-b30f-487d-a915-bcfa6ebd0954
# Stocks = @chain df begin
	
# 	select(:date,:TICKER,:Rx) 
	
# 	unstack(:date,:TICKER,:Rx)
	
# end

# ╔═╡ b4a689de-eb5a-42a0-b7f1-274bb81884f4
md"""
- Now, we can estimate expected returns and the covariance matrix of stock returns.
"""

# ╔═╡ 201bdaf1-bcb4-4e9e-8b38-fba457527ba6
# begin
	
# 	μ_Stocks = @chain Stocks begin
		
# 		combine(StockTicker .=> (x-> mean(x)), renamecols=false)
		
# 	end

# 	μ_Stocks = Array(μ_Stocks[1,:])
	
# end

# ╔═╡ 1af038cd-1f76-4473-9abb-ca25efd5ef5b
# Σ_Stocks= cov(Matrix(Stocks[:,Not(:date)]))

# ╔═╡ b10c5e71-2cd7-46ff-9a49-c749312becc9
md"""
- We are now all set to calculate the mean-variance frontier for our set of stocks and also to get the tangency portfolio.
"""

# ╔═╡ 9583fcde-ddc0-4463-b9e1-7c8f69921f17
# begin
# 	Rf_Stocks = @chain RF begin
# 		
# 		
# 		
# 	end
		
# 	with_terminal() do
# 		printred("riskfree rate:")
# 		printmat(Rf_Stocks,rowNames="RF")
# 		printred("expected returns:")
# 		printmat(μ_Stocks,rowNames=StockTicker)
# 		printred("covariance matrix:")
# 		printmat(Σ_Stocks,colNames=StockTicker,rowNames=StockTicker)
# 	end
# end

# ╔═╡ 63e089e7-19da-4b22-b4f8-93c7dcf3fffd
md"""
- Let's plot the mean-variance frontier for our set of stocks.
"""

# ╔═╡ 41b4f432-2218-427b-b9b0-c882e3e4c0f0
# begin
# 	μ_MVStocks = collect(0.0010:0.0001:0.15)
# 	σ_MVStocks = Array{Float64}(undef,length(μ_MVStocks))
	
# 	for (i,mu) in enumerate(μ_MVStocks)
# 		σ_MVStocks[i] = 
# 	end
	
# 	p_MVStocks = plot(σ_MVStocks,μ_MVStocks, color=:blue, xlim=(0,0.10), ylim=(0,0.03), xlabel=L"\sigma", ylabel=L"\mu", label="MV Frontier", legend=:topleft)
# end

# ╔═╡ 0d2c744c-cfbc-4ee7-b50f-56fa5f2faef6
md"""
- Let's add the individual assets.
"""

# ╔═╡ 68c13c22-274b-4e9b-ba45-6cd7054b1642
# begin
# 	p_MVStocks2 = plot(σ_MVStocks,μ_MVStocks, color=:blue, xlim=(0,0.15), ylim=(0,0.03), xlabel=L"\sigma", ylabel=L"\mu", label="MV Frontier", legend=:topleft)	
	
# 	for i=1:length(StockTicker)
# 		scatter!(p_MVStocks2,[sqrt.((Σ_Stocks[i,i]))],[μ_Stocks[i]], markershape=:cross,markersize=4, markerstrokewidth=1, markercolor=:red,label="")
# 		annotate!(p_MVStocks2,[sqrt.((Σ_Stocks[i,i]))+0.01],[μ_Stocks[i]],(StockTicker[i],10))
# 	end
# 	p_MVStocks2
# end

# ╔═╡ 66b6a673-8a3f-46e6-ad02-43451c6b75f2
md"""
- Let's visualize the mean-variance frontier with a riskfree asset.
"""

# ╔═╡ 28059fe1-7051-4846-83c4-4dc6a3a0217c
# begin
	
# 	μ_MVRfStocks = collect(Rf_Stocks:0.0001:0.10)
	
# 	σ_MVRfStocks = Array{Float64}(undef,length(μ_MVRfStocks))
	
# 	w_MVRfStocks = Array{Float64}(undef,length(μ_MVRfStocks))
	
# 	for (i,mu) in enumerate(μ_MVRfStocks)
# 		σ_MVRfStocks[i] = 
# 	end
	
# 	p_MVRfStocks = plot(σ_MVRfStocks,μ_MVRfStocks, color=:blue, xlim=(0,0.20), ylim=(0,0.05), xlabel=L"\sigma", ylabel=L"\mu", label="MV/Rf Frontier", legend=:topleft)
	
# end

# ╔═╡ f652f235-ea75-4498-b1a7-e2d8d6a9839a
md"""
- We also add the mean-variance frontier of (only) risky assets.
"""

# ╔═╡ dbc7a54a-2010-4ece-9f5c-830ca732bc2e
# begin
	
# 	p_MVRfStocks2 = p_MVRfStocks
	
# 	plot!(p_MVRfStocks2,σ_MVStocks,μ_MVStocks, label="MV Frontier", color=:red)
	
# end

# ╔═╡ 46e17e2e-6b1f-459f-8586-409f84a1e70d
md"""
- Next, we calculate the tangency portfolio.
"""

# ╔═╡ 1f75311f-7311-4b1a-bdf7-b904645f3433
# begin
# 	wTStocks,muTStocks,stdTStocks = 

# 	df_TStocks = 
# end

# ╔═╡ ed6bd06e-91ca-4904-b419-9224c506ba06
# with_terminal() do
# 		printred("Expected Return Tangency Portfolio:")
# 		printmat(muTStocks,rowNames="μ")
# 		printred("Standard Deviation Tangency Portfolio:")
# 		printmat(stdTStocks,rowNames="σ")
# 		printred("Portfolio Weights:")
# 		printmat(wTStocks,colNames="w",rowNames=StockTicker)
# 	end

# ╔═╡ e0c5b290-48ab-44ad-9623-2d17660bf863
vspace

# ╔═╡ 7bc6b7af-3734-4bbd-9fd1-918b809ac824
md"""
# Portfolio Optimization using Julia Libraries
"""

# ╔═╡ 368f33fe-3efb-48ed-ab41-67c6f9afe51c
md"""
- We will now consider how we can add investment constraints to a portfolio choice problem (e.g. we cannot invest more than a certain fraction of the portfolio in a single stock).
- In general, as we add constraints  these types of optimizations become more complex and we will learn how we can use an optimization algorithm to set up the portfolio choice problem.
- Specifically, we will use the JuMP Package ([Link](https://jump.dev/JuMP.jl/stable/)) and Ipopt ([Link](https://github.com/jump-dev/Ipopt.jl)).
"""

# ╔═╡ a7ba3e82-7035-4eb0-8d0c-dfad466628d9
md"""

Suppose we are considering investing \$1000 in the six stocks "AAPL", "AXP", "CAT", "GS", "MRK", and "WMT" from the previous examples.

We will use the \$1000 initial money to buy shares of the three stocks, hold these for one month, and sell the shares off at the prevailing market prices at the end of the month.

Our goal is to invest in such a way that the expected end-of-month return is at least \$10 or 1%. Furthermore, given the target return we want to minimize the risk “risk” of not achieving our target return.

We make the following assumptions:
1. We can trade any continuum of shares.
2. No short-selling is allowed.
3. There are no transaction costs.

We model this problem by taking decision variables $x_{i}, i=1,2,3,4,6$ denoting
the dollars invested in each of the 6 stocks.

Let us denote by $\tilde{r}_{i}$ the random variable corresponding to the
monthly return (increase in the stock price) per dollar for stock $i$.

Then, the return (or profit) on $x_{i}$ dollars invested in stock $i$ is
$\tilde{r}_{i} x_{i},$ and the total (random) return on our investment is
$\sum_{i=1}^{6} \tilde{r}_{i} x_{i}.$ The expected return on our investment is
then $\mathbb{E}\left[\sum_{i=1}^{6} \tilde{r}_{i} x_{i}\right]=\sum_{i=1}^{6} \overline{r}_{i} x_{i},$
where $\overline{r}_{i}$ is the expected value of the $\tilde{r}_{i}.$

Our goal is to minimize the variance of the return of the investment portfolio. 
This variance is given by:

```math
\operatorname{Var}\left[\sum_{i=1}^{6} \tilde{r}_{i} x_{i}\right] = \sum_{i=1}^{6} \sum_{j=1}^{6} x_{i} x_{j} \sigma_{i j}
```

where $\sigma_{i j}$ is the covariance of the return of stock $i$ with stock $j$.

We can also write this equation as:

```math
\operatorname{Var}\left[\sum_{i=1}^{6} \tilde{r}_{i} x_{i}\right] =x^{T} Q x
```

Where $Q$ is the covariance matrix for the random vector $\tilde{r}$.

Finally, we can write the model as:

```math
\begin{aligned}
\min x^{T} Q x \\
\text { s.t. } \sum_{i=1}^{6} x_{i} \leq 1000.00 \\
\overline{r}^{T} x \geq 10.00 \\
x \geq 0
\end{aligned}
```

let's now use JuMP to solve the portfolio optimization problem.
"""

# ╔═╡ 530de26b-4ef0-4985-b2b5-c173848554bf
md"""
- We import the JuMP and the Ipopt packages.
"""

# ╔═╡ 20e2e63b-a815-48e1-8c9b-fc58c37fc7f4
md"""
- Next, we set up the constrained optimization problem as follows:
"""

# ╔═╡ 3f1f9312-5aa7-4659-a9cd-a6087325db6f
begin
	
end

# ╔═╡ 032fa9cd-59a0-4a8d-a11f-035185b4a68d


# ╔═╡ 2a1d3f42-4a6a-4463-a7e8-1d42faeef67e
md"""
- Let's get the portfolio weights in the optimal solution.
"""

# ╔═╡ cf0f4d47-b2a5-4068-9bb4-8a7d92b220a5
# df_JuMP = 

# ╔═╡ 65762150-2f01-483f-a71f-b05a29ace8a1
vspace

# ╔═╡ 66f01e97-7b13-430c-ac17-9a790d54b9bc
md"""
#  Portfolio Optimization with Constraints

In this problem, we will find the unconstrained portfolio allocation where we 
introduce the weighting parameter $\lambda \;(0 \leq \lambda \leq$ 1) and minimize $\lambda * \text{risk} - (1-\lambda)* \text{expected return}$. By varying the values of $\lambda$, we trace out the efficient frontier.

We will use a convex optimization package [Convex.jl](https://jump.dev/Convex.jl/stable/) and [SCS](https://github.com/jump-dev/SCS.jl) (splitting conic solver) which is a numerical optimization package for solving large-scale convex cone problems.

Suppose that we know the mean returns $\mu \in \mathbf{R}^n$ of each asset and the covariance $\Sigma \in \mathbf{R}^{n \times n}$ between the assets. Our objective is to find a portfolio allocation that minimizes the *risk* (which we measure as the variance $w^T \Sigma w$) and maximizes the *expected return* ($w^T \mu$) of the portfolio of the simulataneously. We require $w \in \mathbf{R}^n$ and $\sum_i w_i = 1$.

This problem can be written as

$$\begin{array}{ll}
    \text{minimize}   & \lambda*w^T \Sigma w - (1-\lambda)*w^T \mu \\
    \text{subject to} & \sum_i w_i = 1
\end{array}$$
 where $w \in \mathbf{R}^n$ is the vector containing weights allocated to each asset.
"""

# ╔═╡ 2f70bd24-6b2f-4dab-895d-3a58759e42bc
md"""
- We import the Convex and the SCS packages.
"""

# ╔═╡ 069eb48b-ef05-45e3-9415-db5e083d59aa
md"""
- Next, we set up the optimization problem and solve it.
"""

# ╔═╡ deab3f39-c1df-40ca-b8be-4f069fd9bd96
# begin
# 	N = 
# 	λ_vals = 

# 	n = 
# 	w = 
# 	ret = 
# 	risk = 
	
# 	MeanVarA = zeros(N, 2)
# 	for i in 1:N
# 	    λ = λ_vals[i]
# 	    p = 
	    
# 	    MeanVarA[i, :] = [evaluate(ret), evaluate(risk)]
# 	end
# end

# ╔═╡ a6de58d1-40a3-445a-8e4d-9629ef44b5ad
md"""
- Next, let's solve with the bounds $0\le w_i \le 1$.
"""

# ╔═╡ 683643a3-fbb9-4971-ad24-38df63a1e8b4
# begin
# 	w_lower = 
# 	w_upper = 
	
# 	MeanVarB = zeros(N, 2)   #repeat, but with 0<w[i]<1
# 	for i in 1:N
# 	    λ = 
# 	    p = 


# 	    MeanVarB[i, :] = [evaluate(ret), evaluate(risk)]
# 	end
# end

# ╔═╡ 9a9c7a6c-1ec2-41b7-917a-fc5fb6455302
md"""
- Let's visualize the differences in the unconstrained and the constrained solutions.
"""

# ╔═╡ f6c08155-4fa8-453e-b030-f3fd1a848762
# let
# 	pOpt = plot(
# 	    sqrt.([MeanVarA[:, 2] MeanVarB[:, 2]]),
# 	    [MeanVarA[:, 1] MeanVarB[:, 1]],
# 	    xlim = (0, 0.15),
# 	    ylim = (0, 0.04),
# 	    title = "Markowitz Efficient Frontier",
# 	    xlabel = "Standard deviation",
# 	    ylabel = "Expected return",
# 	    label = ["no bounds on w" "with 0<w<1"],
# 		legend = :topleft
# 	)
# 	for i=1:length(StockTicker)
# 		scatter!(pOpt,[sqrt.((Σ_Stocks[i,i]))],[μ_Stocks[i]], markershape=:cross,markersize=4, markerstrokewidth=1, markercolor=:red,label="")
# 		annotate!(pOpt,[sqrt.((Σ_Stocks[i,i]))+0.01],[μ_Stocks[i]],(StockTicker[i],10))
# 	end
# 	pOpt
# end

# ╔═╡ c68a311d-a336-48ec-80da-4d26556d8041
md"""
We now instead impose a restriction on  $\sum_i |w_i| - 1$, allowing for varying degrees of "leverage".
"""

# ╔═╡ bd01048f-4c5b-4bfb-b0c3-d6eb09aa6cd6
# begin
# 	Lmax = 
	
# 	MeanVarC = zeros(N, 2)   #repeat, but with restriction on Sum(|w[i]|)
# 	for i in 1:N
# 	    λ = 
# 	    p = 

# 	    MeanVarC[i, :] = [evaluate(ret), evaluate(risk)]
# 	end
# end

# ╔═╡ 1d9b10c4-f5e8-4992-b7f2-8f10cce049e2
md"""
- Let's add the optimal solution with leverage to the previous graph.
"""

# ╔═╡ 6b8170eb-9f1f-4e65-8681-fc6f7018bfd5
# let
# 	pOpt = plot(
# 	    sqrt.([MeanVarA[:, 2] MeanVarB[:, 2] MeanVarC[:, 2]]),
# 	    [MeanVarA[:, 1] MeanVarB[:, 1] MeanVarC[:, 1]],
# 	    xlim = (0, 0.15),
# 	    ylim = (0, 0.04),
# 	    title = "Markowitz Efficient Frontier",
# 	    xlabel = "Standard deviation",
# 	    ylabel = "Expected return",
# 	    label = ["no bounds on w" "with 0<w<1" "restriction on sum(|w|)"],
# 		legend=:topleft
# 	)
# 	for i=1:length(StockTicker)
# 		scatter!(pOpt,[sqrt.((Σ_Stocks[i,i]))],[μ_Stocks[i]], markershape=:cross,markersize=4, markerstrokewidth=1, markercolor=:red,label="")
# 		annotate!(pOpt,[sqrt.((Σ_Stocks[i,i]))+0.01],[μ_Stocks[i]],(StockTicker[i],10))
# 	end
# 	pOpt
# end

# ╔═╡ 76499990-b3b1-4090-8f30-f82d1e6f238d
vspace

# ╔═╡ 10f0edd8-157e-43e5-a64a-40fdcf1d9dd4
md"""
#  Portfolio Optimization with Target Return

Let's see how we can set up portfolio choice problem with a target expected return and bounds on the portfolio shares of the stocks. Specifically, in this problem, we will find the portfolio allocation that minimizes risk while achieving a given expected return $R_\text{target}$.

Suppose that we know the mean returns $\mu \in \mathbf{R}^n$ and the covariance $\Sigma \in \mathbf{R}^{n \times n}$ of the $n$ assets. We would like to find a portfolio allocation $w \in \mathbf{R}^n$, $\sum_i w_i = 1$, minimizing the *risk* of the portfolio, which we measure as the variance $w^T \Sigma w$ of the portfolio. The requirement that the portfolio allocation achieve the target expected return can be expressed as $w^T \mu >= R_\text{target}$. We suppose further that our portfolio allocation must comply with some lower and upper bounds on the allocation, $w_\text{lower} \leq w \leq w_\text{upper}$.

This problem can be written as

$$\begin{array}{ll}
    \text{minimize}   & w^T \Sigma w \\
    \text{subject to} & w^T \mu >= R_\text{target} \\
                      & \sum_i w_i = 1 \\
                      & w_\text{lower} \leq w \leq w_\text{upper}
\end{array}$$

where $w \in \mathbf{R}^n$ is our optimization variable.
"""

# ╔═╡ 6d6972a5-40c2-46be-9a2d-a12cd0a60e68
md"""
- We set up the optimization problem as follows.
"""

# ╔═╡ 2113af57-bc73-4351-bc87-12ce3e17b7bc
# let
# 	R_target = 
# 	w_lower = 
# 	w_upper = 
	
# 	w    = 
# 	ret  = 
# 	risk = 
	
# 	p = 
	
# 	
	
# 	with_terminal() do
# 		printred("Portfolio Weights:")
# 		printmat(evaluate(w),colNames="w",rowNames=StockTicker)
# 	end
	
# end

# ╔═╡ da4b1fae-647b-4e83-8428-01e6d0664cc7
vspace

# ╔═╡ dccf0402-130c-43c3-b673-de032354ce74
md"""
# Wrap-Up
"""

# ╔═╡ bbfd8858-0c37-459b-99a6-fa58fe5ea0b3
html"""
<fieldset>      
<legend>Goals for today</legend>      
<br>
  <input type="checkbox" value="" checked>Implement Mean-Variance Analysis in Julia. <br>      
<br>
</fieldset>      
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
Chain = "8be319e6-bccf-4806-a6f7-6fae938471bc"
Convex = "f65535da-76fb-5f13-bab9-19810c17039a"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
Ipopt = "b6b21f68-93f8-5de0-b562-5493be1d77c9"
JuMP = "4076af6c-e467-56ae-b986-b466b2749572"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Logging = "56ddb016-857b-54e1-b83d-db4d58db5568"
Pkg = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"
SCS = "c946c3f1-0d1f-5ce8-9dea-7daa1f7e2d13"
ShiftedArrays = "1277b4bf-5013-50f5-be3d-901d8477a67a"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[compat]
CSV = "~0.10.2"
Chain = "~0.4.10"
Convex = "~0.15.0"
DataFrames = "~1.3.2"
HypertextLiteral = "~0.9.4"
Ipopt = "~1.0.2"
JuMP = "~0.23.1"
LaTeXStrings = "~1.3.0"
Plots = "~1.26.0"
PlutoUI = "~0.7.35"
SCS = "~1.1.0"
ShiftedArrays = "~1.0.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.2"
manifest_format = "2.0"
project_hash = "e956fcdb35ea957e722df8429dbc884c0301c07f"

[[deps.AMD]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse_jll"]
git-tree-sha1 = "45a1272e3f809d36431e57ab22703c6896b8908f"
uuid = "14f7f29c-3bd6-536c-9a0b-7339e30b5a3e"
version = "0.5.3"

[[deps.ASL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6252039f98492252f9e47c312c8ffda0e3b9e78d"
uuid = "ae81ac8f-d209-56e5-92de-9978fef736f9"
version = "0.1.3+0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "793501dcd3fa7ce8d375a2c878dca2296232686e"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.2.2"

[[deps.AbstractTrees]]
git-tree-sha1 = "faa260e4cb5aba097a73fab382dd4b5819d8ec8c"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.4.4"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "cde29ddf7e5726c9fb511f340244ea3481267608"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.7.2"
weakdeps = ["StaticArrays"]

    [deps.Adapt.extensions]
    AdaptStaticArraysExt = "StaticArrays"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "f1f03a9fa24271160ed7e73051fba3c1a759b53f"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.4.0"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "PrecompileTools", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings", "WorkerUtilities"]
git-tree-sha1 = "679e69c611fff422038e9e21e270c4197d49d918"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.12"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[deps.Chain]]
git-tree-sha1 = "339237319ef4712e6e5df7758d0bccddf5c237d9"
uuid = "8be319e6-bccf-4806-a6f7-6fae938471bc"
version = "0.4.10"

[[deps.CodecBzip2]]
deps = ["Bzip2_jll", "Libdl", "TranscodingStreams"]
git-tree-sha1 = "c0ae2a86b162fb5d7acc65269b469ff5b8a73594"
uuid = "523fee87-0ab8-5b00-afb7-3ecf72e48cfd"
version = "0.8.1"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "cd67fc487743b2f0fd4380d4cbd3a24660d0eec8"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.3"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "67c1f244b991cad9b0aa4b7540fb758c2488b129"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.24.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "a1f44953f2382ebb937d60dafbe2deea4bd23249"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.10.0"
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.CommonSubexpressions]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "7b8a93dba8af7e3b42fecabf646260105ac373f7"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.0"

[[deps.Compat]]
deps = ["UUIDs"]
git-tree-sha1 = "886826d76ea9e72b35fcd000e535588f7b60f21d"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.10.1"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.0+0"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "c53fc348ca4d40d7b371e71fd52251839080cbc9"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.4"

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseStaticArraysExt = "StaticArrays"

    [deps.ConstructionBase.weakdeps]
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[deps.Convex]]
deps = ["AbstractTrees", "BenchmarkTools", "LDLFactorizations", "LinearAlgebra", "MathOptInterface", "OrderedCollections", "SparseArrays", "Test"]
git-tree-sha1 = "e84e371b9206bdd678fe7a8cf809c7dec949e88f"
uuid = "f65535da-76fb-5f13-bab9-19810c17039a"
version = "0.15.4"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "8da84edb865b0b5b0100c0666a9bc9a0b71c553c"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.15.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "db2a9cb664fcea7836da4b414c3278d71dd602d2"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.3.6"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3dbd312d370723b6bb43ba9d02fc36abade4518d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.15"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "23163d55f885173722d1e4cf0f6110cdbaf7e272"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.15.1"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e3290f2d49e661fbd94046d7e3726ffcb2d41053"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.4+0"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8e9441ee83492030ace98f9789a654a6d0b1f643"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4558ab818dcceaab612d1bb8c19cee87eda2b83c"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.5.0+0"

[[deps.Extents]]
git-tree-sha1 = "2140cd04483da90b2da7f99b2add0750504fc39c"
uuid = "411431e0-e8b7-467b-b5e0-f676ba4f2910"
version = "0.1.2"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

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

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions"]
git-tree-sha1 = "cf0fe81336da9fb90944683b8c41984b08793dad"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.36"
weakdeps = ["StaticArrays"]

    [deps.ForwardDiff.extensions]
    ForwardDiffStaticArraysExt = "StaticArrays"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d8db6a5a2fe1381c1ea4ef2cab7c69c2de7f9ea0"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.1+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "ff38ba61beff76b8f4acad8ab0c97ef73bb670cb"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.9+0"

[[deps.GPUArraysCore]]
deps = ["Adapt"]
git-tree-sha1 = "2d6ca471a6c7b536127afccfa7564b5b39227fe0"
uuid = "46192b85-c4d5-4398-a991-12ede77f4527"
version = "0.1.5"

[[deps.GR]]
deps = ["Base64", "DelimitedFiles", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Printf", "Random", "RelocatableFolders", "Serialization", "Sockets", "Test", "UUIDs"]
git-tree-sha1 = "c98aea696662d09e215ef7cda5296024a9646c75"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.64.4"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "bc9f7725571ddb4ab2c4bc74fa397c1c5ad08943"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.69.1+0"

[[deps.GeoInterface]]
deps = ["Extents"]
git-tree-sha1 = "d4f85701f569584f2cff7ba67a137d03f0cfb7d0"
uuid = "cf35fbd7-0cd7-5166-be24-54bfbe79505f"
version = "1.3.3"

[[deps.GeometryBasics]]
deps = ["EarCut_jll", "Extents", "GeoInterface", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "424a5a6ce7c5d97cca7bcc4eac551b97294c54af"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.9"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "e94c92c7bf4819685eb80186d51c43e71d4afa17"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.76.5+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "0fa77022fe4b511826b39c894c90daf5fce3334a"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.17"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "d75853a0bdbfb1ac815478bacd89cd27b550ace6"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.3"

[[deps.IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[deps.InlineStrings]]
deps = ["Parsers"]
git-tree-sha1 = "9cc2baf75c6d09f9da536ddf58eb2f29dedaf461"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.4.0"

[[deps.IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ad37c091f7d7daf900963171600d7c1c5c3ede32"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2023.2.0+0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InvertedIndices]]
git-tree-sha1 = "0dc7b50b8d436461be01300fd8cd45aa0274b038"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.3.0"

[[deps.Ipopt]]
deps = ["Ipopt_jll", "MathOptInterface"]
git-tree-sha1 = "6d4c0cec91619b7c44ed9d4f9d021ce053019e15"
uuid = "b6b21f68-93f8-5de0-b562-5493be1d77c9"
version = "1.0.4"

[[deps.Ipopt_jll]]
deps = ["ASL_jll", "Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "MUMPS_seq_jll", "OpenBLAS32_jll", "Pkg"]
git-tree-sha1 = "e3e202237d93f18856b6ff1016166b0f172a49a8"
uuid = "9cc047cb-c261-5740-88fc-0cf96f7bdcc7"
version = "300.1400.400+0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IterTools]]
git-tree-sha1 = "42d5f897009e7ff2cf88db414a389e5ed1bdd023"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.10.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7e5d6779a1e09a36db2a7b6cff50942a0a7d0fca"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.5.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "60b1194df0a3298f460063de985eae7b01bc011a"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.0.1+0"

[[deps.JuMP]]
deps = ["Calculus", "DataStructures", "ForwardDiff", "LinearAlgebra", "MathOptInterface", "MutableArithmetics", "NaNMath", "OrderedCollections", "Printf", "SparseArrays", "SpecialFunctions"]
git-tree-sha1 = "c48de82c5440b34555cb60f3628ebfb9ab3dc5ef"
uuid = "4076af6c-e467-56ae-b986-b466b2749572"
version = "0.23.2"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LDLFactorizations]]
deps = ["AMD", "LinearAlgebra", "SparseArrays", "Test"]
git-tree-sha1 = "70f582b446a1c3ad82cf87e62b878668beef9d13"
uuid = "40e66cde-538c-5869-a4ad-c39174c6795b"
version = "0.10.1"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d986ce2d884d49126836ea94ed5bfb0f12679713"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "15.0.7+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "8c57307b5d9bb3be1ff2da469063628631d4d51e"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.21"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    DiffEqBiologicalExt = "DiffEqBiological"
    ParameterizedFunctionsExt = "DiffEqBase"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    DiffEqBase = "2b5f629d-d688-5b77-993f-72d75c75574e"
    DiffEqBiological = "eb300fae-53e8-50a0-950c-e21f52c2b7e0"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

[[deps.LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

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

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f9557a255370125b405568f9767d6d195822a175"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "7d6dd4e9212aebaeed356de34ccf262a3cd415aa"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.26"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.METIS_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "1fd0a97409e418b78c53fac671cf4622efdf0f21"
uuid = "d00139f3-1899-568f-a2f0-47f597d42d70"
version = "5.1.2+0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "Pkg"]
git-tree-sha1 = "2ce8695e1e699b68702c03402672a69f54b8aca9"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2022.2.0+0"

[[deps.MUMPS_seq_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "METIS_jll", "OpenBLAS32_jll", "Pkg"]
git-tree-sha1 = "29de2841fa5aefe615dea179fcde48bb87b58f57"
uuid = "d7ed1dd3-d0ae-5e8e-bfb4-87a502085b8d"
version = "5.4.1+0"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "b211c553c199c111d998ecdaf7623d1b89b69f93"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.12"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MathOptInterface]]
deps = ["BenchmarkTools", "CodecBzip2", "CodecZlib", "DataStructures", "ForwardDiff", "JSON", "LinearAlgebra", "MutableArithmetics", "NaNMath", "OrderedCollections", "PrecompileTools", "Printf", "SparseArrays", "SpecialFunctions", "Test", "Unicode"]
git-tree-sha1 = "d2a140e551c9ec9028483e3c7d1244f417567ac0"
uuid = "b8f27783-ece8-5eb3-8dc8-9495eed66fee"
version = "1.24.0"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

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

[[deps.MutableArithmetics]]
deps = ["LinearAlgebra", "SparseArrays", "Test"]
git-tree-sha1 = "806eea990fb41f9b36f1253e5697aa645bf6a9f8"
uuid = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"
version = "1.4.0"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS32_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "2fb9ee2dc14d555a6df2a714b86b7125178344c2"
uuid = "656ef2d0-ae68-5445-9ca0-591084a874a2"
version = "0.3.21+0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a12e56c72edee3ce6b96667745e6cbbe5498f200"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.23+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "64779bc4c9784fee475689a1752ef4d5747c5e87"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.42.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Requires", "Statistics"]
git-tree-sha1 = "a3a964ce9dc7898193536002a6dd892b1b5a6f1d"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "2.0.1"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "862942baf5663da528f66d24996eb6da85218e76"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.0"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "2f041202ab4e47f4a3465e3993929538ea71bd48"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.26.1"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "bd7c69c7f7173097e7b5e1be07cee2b8b7447f51"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.54"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "36d8b4b899628fb92c2749eb488d884a926614d3"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.3"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "03b4c25b43cb84cee5c90aa9b5ea0a78fd848d2f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00805cd429dcb4870060ff49ef443486c262e38e"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.1"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "dfb54c4e414caa595a1f2ed759b160f5a3ddcba5"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.3.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "0c03844e2231e12fda4d0086fd7cbe4098ee8dc5"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+2"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase"]
git-tree-sha1 = "dc1e451e15d90347a7decc4221842a022b011714"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.5.2"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "cdbd3b1338c72ce29d9584fdbe9e9b70eeb5adca"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "0.1.3"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SCS]]
deps = ["MathOptInterface", "Requires", "SCS_GPU_jll", "SCS_MKL_jll", "SCS_jll", "SparseArrays"]
git-tree-sha1 = "05c1ed62a8d78827d0dd1a9fa04040a4a254bf08"
uuid = "c946c3f1-0d1f-5ce8-9dea-7daa1f7e2d13"
version = "1.1.4"

[[deps.SCS_GPU_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "OpenBLAS32_jll"]
git-tree-sha1 = "6a61274837cfa050bd996910d347e876bef3a6b3"
uuid = "af6e375f-46ec-5fa0-b791-491b0dfa44a4"
version = "3.2.3+1"

[[deps.SCS_MKL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "MKL_jll"]
git-tree-sha1 = "1ca6e41193c08fb345b58a05a6cfa8e309939313"
uuid = "3f2553a9-4106-52be-b7dd-865123654657"
version = "3.2.3+1"

[[deps.SCS_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "OpenBLAS32_jll"]
git-tree-sha1 = "e4902566d6207206c27fe6f45e8c2d28c34889df"
uuid = "f4f2fc5b-1d94-523c-97ea-2ab488bedf4b"
version = "3.2.3+0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "0e7508ff27ba32f26cd459474ca2ede1bc10991f"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.ShiftedArrays]]
git-tree-sha1 = "22395afdcf37d6709a5a0766cc4a5ca52cb85ea0"
uuid = "1277b4bf-5013-50f5-be3d-901d8477a67a"
version = "1.0.0"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

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

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "e2cfc4012a19088254b3950b85c3c1d8882d864d"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.3.1"

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

    [deps.SpecialFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "4e17a790909b17f7bf1496e3aec138cf01b60b3b"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.0"

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

    [deps.StaticArrays.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StaticArraysCore]]
git-tree-sha1 = "36b3d696ce6366023a0ea192b4cd442268995a0d"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.2"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

[[deps.StructArrays]]
deps = ["Adapt", "ConstructionBase", "DataAPI", "GPUArraysCore", "StaticArraysCore", "Tables"]
git-tree-sha1 = "0a3db38e4cce3c54fe7a71f831cd7b6194a54213"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.16"

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

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
git-tree-sha1 = "1fbeaaca45801b4ba17c251dd8603ef24801dd84"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.10.2"
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

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "34db80951901073501137bdbc3d5a8e7bbd06670"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.1.2"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "7558e29847e99bc3f04d6569e82d0f5c54460703"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+1"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "93f43ab61b16ddfb2fd3bb13b3ce241cafb0e6c9"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.31.0+0"

[[deps.WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "b1be2855ed9ed8eac54e5caff2afcdb442d52c23"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.2"

[[deps.WorkerUtilities]]
git-tree-sha1 = "cd1659ba0d57b71a464a29e64dbc67cfe83d54e7"
uuid = "76eceee3-57b5-4d4a-8e66-0e911cebbf60"
version = "1.6.1"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "801cbe47eae69adc50f36c3caec4758d2650741b"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.12.2+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "afead5aba5aa507ad5a3bf01f58f82c8d1403495"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6035850dcc70518ca32f012e46015b9beeda49d8"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "34d526d318358a859d7de23da945578e8e8727b7"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8fdda4c692503d44d04a0603d9ac0982054635f9"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "b4bfde5d5b652e22b9c790ad00af08b6d042b97d"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.15.0+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "730eeca102434283c50ccf7d1ecdadf521a765a4"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.2+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "330f955bc41bb8f5270a369c473fc4a5a4e4d3cb"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.6+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "691634e5453ad362044e2ad653e79f3ee3bb98c3"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.39.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e92a1a012a10506618f10b7047e478403a046c77"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "49ce682769cd5de6c72dcf1b94ed7790cd08974c"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.5+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "93284c28274d9e75218a416c65ec49d0e0fcdf3d"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.40+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9c304562909ab2bab0262639bd4f444d7bc2be37"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+1"
"""

# ╔═╡ Cell order:
# ╟─c43df4a3-a1d8-433e-9a1c-f7c0984be879
# ╟─5247cc42-643c-4cb1-9169-df5846bef2da
# ╟─036e21fc-88bc-4e7a-be2b-752aaa1e978a
# ╟─afb78391-4719-4049-8aad-f210142ec27b
# ╟─42e56e7e-79dc-4823-9145-2bd2e0caa14f
# ╟─c432c113-2bb2-4852-bc08-80aba4cff440
# ╠═3d731294-71d0-4b34-85e2-96d29bd8a7ca
# ╟─5fc44a1a-2c5c-4cdf-b2da-4cbc17c8f8a3
# ╟─9e3d6627-1924-4f07-8438-d61b12619db7
# ╟─ed64f108-1b86-4db3-8e37-2043cf9b4887
# ╟─6c641b4c-0f38-4e8c-aa5e-01461352a302
# ╟─bad43e5e-bc0b-4d0c-99e2-bdc6a9d4a1e2
# ╟─70564b11-4360-48a8-80da-adcaa451b5b2
# ╟─2a934e16-74c7-4dc2-bbd0-f47006331422
# ╠═48ae81d0-a594-4b9a-8d1f-4785576e1184
# ╟─35d2fe96-69cd-4b1d-aa5b-675dc24031cf
# ╟─b3a7702e-b5a0-4921-9205-1715c13ee7c9
# ╠═a5c28138-8f15-4636-908f-0a43ca9321e3
# ╟─bc3df0e8-1f74-456a-9e2a-8a69279a78c9
# ╟─72c219a7-1c04-4678-988c-8f17674d9d75
# ╠═652dc6ae-6f9d-4ebd-9251-00821a8ee09d
# ╟─ebc5f144-20ff-4451-a241-f4c046520b98
# ╟─8e80ef11-e81d-40f1-a04d-aaa857b27376
# ╠═3259e4c6-4275-497d-9831-da7bcf767e3d
# ╟─b4da6bba-d8a0-4d50-bc0d-fc31566e07a5
# ╟─0b82837f-4a25-41d5-9ee7-e1cb49110980
# ╠═a599bc02-5a02-4b31-b75d-2c3e6a732b13
# ╟─29da3b0b-b027-4da2-a31c-d3c7c0bfceb0
# ╟─d558b927-2cea-45ef-b50b-0f53640e49d4
# ╟─fae8140d-9eea-432b-a858-ec12d3728ef2
# ╟─038a6edf-979a-49b3-8058-8c91118bd9ef
# ╟─bba52baa-08a6-4dca-9bbf-467ff2340df6
# ╠═3fca5d0e-c342-4520-867c-917116495ac2
# ╟─f6ccdc25-091b-4205-b6df-46fa49427e34
# ╟─18130d75-5c5d-4178-99e0-160f7caee2f6
# ╠═dc66ea04-4cad-4f47-9435-f7448394169d
# ╟─d31feaf5-97f1-41c3-a13e-36d410ed97fc
# ╟─b16ecff8-2dc1-4827-b33c-5eb0af4a6961
# ╠═95a13699-95b4-4f7b-baaa-80627f33841f
# ╟─0994b91b-0048-41ca-a485-836f267300c4
# ╟─63c6b02c-4674-45b4-a96a-2545959d9d7c
# ╠═c40dc723-1169-4826-941d-ba162d2bf7b8
# ╟─33845c97-5df5-403c-996c-7d9583b6a0ba
# ╟─ef313c73-14bd-42d9-a1d4-c35709dec26c
# ╟─a6847628-d355-4d57-a97f-c981b246eca5
# ╟─69f5983a-5e47-4331-9518-6c8c30340b24
# ╠═212685c3-9049-42e9-b535-6e515f19153b
# ╟─62d63384-ce4b-4bc0-9fb7-b25d4b276d99
# ╟─77a08244-548c-4a7a-be3e-cdc8c6e29622
# ╠═f3f52640-d079-4d6c-8c2a-63f89c53b061
# ╟─c383ce27-b36a-4742-9213-d167c10fafd9
# ╟─fa8d6069-e8da-4bba-8475-d20c5c6dc090
# ╟─e1264493-cd70-487c-b2c5-ced6a1594ea7
# ╟─ca56d3a7-3e25-4dc3-a92a-0ad040c853b0
# ╟─33fe5282-db49-4732-9c80-cc1537c120c5
# ╠═ecf84238-b03d-4036-8fd3-88bcb394c925
# ╟─9b9170a8-cfcc-45e1-aa4d-57a4ccca9c31
# ╟─23c73d39-6e64-4718-87a4-4ea2937af09a
# ╠═9eccf04c-f202-4c23-ac85-1b5773501e0f
# ╟─7be5e54c-346b-434f-97a2-4f35ff251ddf
# ╟─2e082d7a-7fec-44e9-8697-78a1328e7d3d
# ╠═e1ac8d53-000e-44d7-8090-334468a6d2ad
# ╟─26c13abf-c870-469d-a952-d62c12762e5b
# ╟─74e6c915-5dca-4c84-a890-0b829ba6cd92
# ╟─9d28d905-5c73-4cff-a321-c88a6d4c854a
# ╟─68d41a8a-0c52-4044-818d-b0e2a0c01f62
# ╟─5be9cfce-89e0-4ad7-9aef-dd3252829c18
# ╠═fe44f447-72db-4c05-ba03-6c26e1573bd6
# ╟─3652b806-8991-47d4-ad82-e8affde497f6
# ╠═fc304ff1-e4ff-4047-a8d3-353816202724
# ╟─391fa810-47bf-41f5-aa20-ff65a25a3f27
# ╟─d8f38fb7-f84c-4266-b32e-7111701d4b5a
# ╟─0b30896b-d6da-4391-a2dc-e9e0bcbe2fa2
# ╠═83a1fb1d-221b-4f26-8e65-e319ea9b899d
# ╟─2c31fd4e-9cc7-43ff-9771-bb154a181d82
# ╟─9b95ee4b-96c2-4173-a2b2-315f21c11a30
# ╠═82c61b57-ee82-44db-b430-022e3b116d63
# ╟─fe28e36c-c8c9-4c3b-a23e-8d15baf33827
# ╟─3f73b5cf-fe07-4bd5-8306-e319024f4bb9
# ╟─dff92924-af65-444c-9ac6-62c0449f7c41
# ╟─e0bffa07-2db9-4ec1-a116-474d71050df6
# ╠═296b85d2-2dac-4cf4-aa86-b33f0ca13650
# ╟─322112e3-3aee-4e70-8203-6a1227a448de
# ╠═624bfb0a-3336-448d-982a-511f9743202c
# ╟─e2e22821-c6c1-4e98-a5f4-725595c3f250
# ╠═b3ac63b0-aebd-4fff-9e98-82d0f4bbb8dc
# ╟─d751ef72-7ab1-45f0-8375-7831175f075f
# ╠═7465eeed-9af0-4504-9154-be22c8160a4b
# ╟─f07348bf-2ec1-4a83-9f1d-6af7787bd42d
# ╠═a53c4108-7ee7-4547-afee-dfaacf87d944
# ╠═3d053364-5a63-41b1-b654-9d99e00cc6c3
# ╟─db15e7a8-6912-49ae-81b4-c22abc40aac5
# ╠═5deea522-f60b-4242-8c9f-26ee7c243677
# ╟─b26bf12b-f377-4228-9ac6-9af67eaf6880
# ╠═3f2eb8f8-b30f-487d-a915-bcfa6ebd0954
# ╟─b4a689de-eb5a-42a0-b7f1-274bb81884f4
# ╠═201bdaf1-bcb4-4e9e-8b38-fba457527ba6
# ╠═1af038cd-1f76-4473-9abb-ca25efd5ef5b
# ╟─b10c5e71-2cd7-46ff-9a49-c749312becc9
# ╠═9583fcde-ddc0-4463-b9e1-7c8f69921f17
# ╟─63e089e7-19da-4b22-b4f8-93c7dcf3fffd
# ╠═41b4f432-2218-427b-b9b0-c882e3e4c0f0
# ╟─0d2c744c-cfbc-4ee7-b50f-56fa5f2faef6
# ╠═68c13c22-274b-4e9b-ba45-6cd7054b1642
# ╟─66b6a673-8a3f-46e6-ad02-43451c6b75f2
# ╠═28059fe1-7051-4846-83c4-4dc6a3a0217c
# ╟─f652f235-ea75-4498-b1a7-e2d8d6a9839a
# ╠═dbc7a54a-2010-4ece-9f5c-830ca732bc2e
# ╟─46e17e2e-6b1f-459f-8586-409f84a1e70d
# ╠═1f75311f-7311-4b1a-bdf7-b904645f3433
# ╠═ed6bd06e-91ca-4904-b419-9224c506ba06
# ╟─e0c5b290-48ab-44ad-9623-2d17660bf863
# ╟─7bc6b7af-3734-4bbd-9fd1-918b809ac824
# ╟─368f33fe-3efb-48ed-ab41-67c6f9afe51c
# ╟─a7ba3e82-7035-4eb0-8d0c-dfad466628d9
# ╟─530de26b-4ef0-4985-b2b5-c173848554bf
# ╠═49fdad82-e563-4e4c-88a1-33166e9ddee4
# ╟─20e2e63b-a815-48e1-8c9b-fc58c37fc7f4
# ╠═3f1f9312-5aa7-4659-a9cd-a6087325db6f
# ╠═032fa9cd-59a0-4a8d-a11f-035185b4a68d
# ╟─2a1d3f42-4a6a-4463-a7e8-1d42faeef67e
# ╠═cf0f4d47-b2a5-4068-9bb4-8a7d92b220a5
# ╟─65762150-2f01-483f-a71f-b05a29ace8a1
# ╟─66f01e97-7b13-430c-ac17-9a790d54b9bc
# ╟─2f70bd24-6b2f-4dab-895d-3a58759e42bc
# ╠═81404cf5-bd49-4dda-8471-fc1c8417199b
# ╟─069eb48b-ef05-45e3-9415-db5e083d59aa
# ╠═deab3f39-c1df-40ca-b8be-4f069fd9bd96
# ╟─a6de58d1-40a3-445a-8e4d-9629ef44b5ad
# ╠═683643a3-fbb9-4971-ad24-38df63a1e8b4
# ╟─9a9c7a6c-1ec2-41b7-917a-fc5fb6455302
# ╠═f6c08155-4fa8-453e-b030-f3fd1a848762
# ╟─c68a311d-a336-48ec-80da-4d26556d8041
# ╠═bd01048f-4c5b-4bfb-b0c3-d6eb09aa6cd6
# ╟─1d9b10c4-f5e8-4992-b7f2-8f10cce049e2
# ╠═6b8170eb-9f1f-4e65-8681-fc6f7018bfd5
# ╟─76499990-b3b1-4090-8f30-f82d1e6f238d
# ╟─10f0edd8-157e-43e5-a64a-40fdcf1d9dd4
# ╟─6d6972a5-40c2-46be-9a2d-a12cd0a60e68
# ╠═2113af57-bc73-4351-bc87-12ce3e17b7bc
# ╟─da4b1fae-647b-4e83-8428-01e6d0664cc7
# ╟─dccf0402-130c-43c3-b673-de032354ce74
# ╟─bbfd8858-0c37-459b-99a6-fa58fe5ea0b3
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
