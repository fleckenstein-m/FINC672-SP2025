### A Pluto.jl notebook ###
# v0.19.9

using Markdown
using InteractiveUtils

# ╔═╡ e86c095f-b440-4935-9f60-9cdcd54ffb43
html"""
	<p align=left style="font-size:32px; font-family:family:Georgia"> <b> FINC 672: Workshop in Finance - Empirical Methods</b> <p>
	"""

# ╔═╡ ce1be57b-3d94-4f28-a307-8bafc01d9651
	html"""
	<p style="padding-bottom:1cm"> </p>
	<div align=center style="font-size:25px; font-family:family:Georgia"> FINC-672: Workshop in Finance - Empirical Methods </div>
	<p style="padding-bottom:1cm"> </p>
	<p align=center style="font-size:25px; font-family:family:Georgia"> <b> Assignment 01 - Julia Fundamentals </b> <p>
	<p style="padding-bottom:1cm"> </p>
	<p align=center style="font-size:25px; font-family:family:Georgia"> Spring 2024 <p>
	<p style="padding-bottom:0.5cm"> </p>
	<div align=center style="font-size:20px; font-family:family:Georgia"> Prof. Matt Fleckenstein </div>
	<p style="padding-bottom:0.05cm"> </p>
	<div align=center style="font-size:20px; font-family:family:Georgia"> University of Delaware, 
	Lerner College of Business and Economics </div>
	<p style="padding-bottom:0.5cm"> </p>
	"""

# ╔═╡ 83806080-8c00-11ec-0f46-01e9cff3af6f
vspace

# ╔═╡ 99902ed5-59aa-4984-a2d0-f31bfa28da34
md"""
*Note: The exercises below are adapted from Kamiński, Bogumił (2023). Julia for Data Analysis. [https://www.manning.com/books/julia-for-data-analysis](https://www.manning.com/books/julia-for-data-analysis)*
"""

# ╔═╡ df2605a4-7651-403b-9d1d-8b1fd4b42df1
vspace

# ╔═╡ c65aee9d-4d71-41f4-b381-b2ccb7d2572b
md"""
Below is a matrix with two time series of monthly returns for the period from January 2010 to November 2022. The first column is the monthly returns on a global equity index (excluding the U.S.). The second column shows the monthly returns of the portfolio of U.S. stocks. The unit of the returns data is in percent. Use this matrix in the following questions. *The data are from 
[AQR](https://www.aqr.com/Insights/Datasets/Betting-Against-Beta-Equity-Factors-Monthly)*.
"""

# ╔═╡ b0f0701e-221e-4d9f-b601-0d0d6a3d0f87
AQR = [
		-4.09	-3.96
		-0.19	3.76
		6.24	6.59
		-0.56	2.15
		-10.47	-7.93
		-0.76	-5.34
		8.54	7.16
		-2.84	-4.20
		9.92	9.31
		3.52	4.02
		-3.82	0.78
		7.73	7.01
		1.80	1.85
		2.93	4.19
		-1.03	0.25
		5.01	2.70
		-2.50	-1.65
		-1.74	-2.07
		-1.24	-2.17
		-8.45	-5.80
		-10.69	-9.18
		9.63	11.62
		-5.33	-0.85
		-1.11	0.24
		6.19	5.52
		5.87	4.20
		-1.11	1.96
		-1.33	-0.62
		-11.11	-7.06
		5.54	3.68
		0.85	1.10
		2.56	2.85
		3.62	2.78
		0.92	-1.41
		1.88	0.46
		3.12	1.30
		5.07	5.23
		-0.92	0.65
		0.44	3.44
		4.31	1.27
		-2.00	1.87
		-3.94	-1.76
		5.18	5.47
		-0.76	-2.49
		7.18	3.80
		3.25	3.99
		0.74	2.37
		1.28	2.63
		-3.37	-3.09
		5.13	4.70
		-0.37	0.48
		0.78	0.31
		1.79	1.92
		1.55	3.13
		-1.26	-2.00
		0.14	3.98
		-4.40	-2.86
		-1.29	1.81
		0.88	2.04
		-2.80	-0.39
		-0.08	-3.27
		5.53	5.80
		-1.01	-1.17
		5.67	1.27
		-0.60	0.74
		-2.54	-1.93
		0.20	0.79
		-7.04	-6.09
		-4.17	-3.53
		7.16	7.26
		-1.60	0.14
		-1.11	-2.58
		-7.24	-5.76
		-1.09	0.34
		7.52	7.32
		2.77	1.56
		-0.88	1.17
		-2.86	0.28
		4.93	3.87
		0.40	0.25
		1.59	0.33
		-1.92	-2.18
		-1.87	4.22
		2.38	1.86
		3.40	2.27
		1.38	2.95
		2.41	0.16
		2.30	0.64
		3.65	0.72
		0.28	1.13
		3.33	2.01
		0.49	0.04
		2.30	2.46
		1.60	1.70
		1.01	2.62
		1.86	1.27
		5.36	4.70
		-4.64	-4.27
		-1.46	-1.98
		1.56	0.52
		-1.37	2.53
		-1.87	0.41
		1.33	2.93
		-1.83	2.82
		0.44	-0.06
		-8.97	-7.69
		0.50	1.52
		-5.25	-9.47
		6.66	9.07
		2.29	3.25
		0.52	0.98
		2.47	3.58
		-5.18	-6.36
		5.27	6.78
		-1.27	0.93
		-2.88	-2.23
		2.22	1.46
		3.13	1.63
		1.10	3.46
		3.89	2.81
		-2.56	-0.34
		-7.96	-8.12
		-13.34	-14.94
		7.45	13.51
		4.07	5.42
		4.08	2.72
		3.64	5.64
		5.47	6.98
		-2.43	-3.58
		-2.26	-2.25
		12.86	12.79
		4.63	4.63
		0.18	-0.21
		2.13	3.01
		1.45	3.23
		3.35	4.82
		2.73	0.88
		-1.05	2.36
		-1.27	1.00
		1.46	2.58
		-2.98	-4.12
		2.45	6.62
		-4.67	-1.94
		3.68	3.39
		-4.77	-5.94
		-1.99	-2.13
		0.25	3.32
		-6.24	-8.96
		0.69	-0.29
		-8.12	-8.78
		3.50	8.95
		-4.17	-3.75
		-10.34	-9.46
		2.63	7.79
		11.60	4.79
		]

# ╔═╡ f420bee2-67b7-4303-aeea-e9a3f4a4a30d
vspace

# ╔═╡ 1c14adad-358d-469a-9f8a-697710ae9e0e
md"""
### Exercise 1
"""

# ╔═╡ 9609264e-b4ce-4390-adc0-7821175b7e60
md"""
Suppose you would like to calculate the highest and the lowest stock return from a time-series of stock returns. Write a function `highlow(x)` that takes any vector and returns the largest the smallest element in this vector. Use this function to calculate the minimum and the maximum of the global equity index returns.
"""

# ╔═╡ f499ea41-c1ce-4ad1-9579-1aae4a535a58
let
#Type your solution here

	
end

# ╔═╡ 669f5626-f17f-4b58-abb8-0dcb25c14895
vspace

# ╔═╡ 3580b62d-fe8a-499c-8551-cac1a81d1b55
md"""
### Exercise 2
"""

# ╔═╡ f6c7b4fa-ec5d-4f16-816f-0c0327bf76b7
md"""
Next, you would like to calculate the average, median, and the standard deviation of returns of the global equity index. Write a function `summarystats(x)` that accepts a vector and returns the mean, median, and the standard deviation of the elements in the vector. Use this function to calculate the average, median, and the standard deviations of returns of the global equity index. 
- Note: Recall that we need to load the Statistics model by executing `using Statistics`. The function for the average, median, and standard deviation are `mean(x)`, `median(x)`, and `maximum(x)`.
"""

# ╔═╡ 0370fa97-a539-4f44-b8f5-155e8c430e74
let
#Type your solution here

using Statistics
	

	
end

# ╔═╡ 14422ed6-189b-4c88-aa9d-a6798ca25138
vspace

# ╔═╡ c6fcd024-9691-42cc-964e-b027ba211b37
md""" 
### Exercise 3
"""

# ╔═╡ c75cb5d1-d0d3-488c-8199-c5f75b11bb83
md"""
Write a function `equallength(x,y)` that accepts two vectors (of stock returns, for instance) and returns true if they have equal length and otherwise returns false. Use your function to test if the number of monthly returns in the portfolio of U.S. stocks from the AQR dataset matches the number of returns in index portfolio `Portfolio` given below.
"""

# ╔═╡ a6b29f5d-b817-49c0-a3a0-e71a6f2e8065
Portfolio = 
[-3.9925
2.7725
6.5025
1.4725
-8.565
-4.195
7.505
-3.86
9.4625
3.895
-0.37
7.19
1.8375
3.875
-0.07
3.2775
-1.8625
-1.9875
-1.9375
-6.4625
-9.5575
11.1225
-1.97
-0.0975
5.6875
4.6175
1.1925
-0.7975
-8.0725
4.145
1.0375
2.7775
2.99
-0.8275
0.815
1.755
5.19
0.2575
2.69
2.03
0.9025
-2.305
5.3975
-2.0575
4.645
3.805
1.9625
2.2925
-3.16
4.8075
0.2675
0.4275
1.8875
2.735
-1.815
3.02
-3.245
1.035
1.75
-0.9925
-2.4725
5.7325
-1.13
2.37
0.405
-2.0825
0.6425
-6.3275
-3.69
7.235
-0.295
-2.2125
-6.13
-0.0175
7.37
1.8625
0.6575
-0.505
4.135
0.2875
0.645
-2.115
2.6975
1.99
2.5525
2.5575
0.7225
1.055
1.4525
0.9175
2.34
0.1525
2.42
1.675
2.2175
1.4175
4.865
-4.3625
-1.85
0.78
1.555
-0.16
2.53
1.6575
0.065
-8.01
1.265
-8.415
8.4675
3.01
0.865
3.3025
-6.065
6.4025
0.38
-2.3925
1.65
2.005
2.87
3.08
-0.895
-8.08
-14.54
11.995
5.0825
3.06
5.14
6.6025
-3.2925
-2.2525
12.8075
4.63
-0.1125
2.79
2.785
4.4525
1.3425
1.5075
0.4325
2.3
-3.835
5.5775
-2.6225
3.4625
-5.6475
-2.095
2.5525
-8.28
-0.045
-8.615
7.5875
-3.855
-9.68]


# ╔═╡ 1fc81663-edaf-46f1-ab94-bf4960a84648
let
#Type your solution here


end

# ╔═╡ 994a949e-8139-422b-8d63-09f38d6341a1
vspace

# ╔═╡ 590427f3-22e9-4027-aca2-8b4627330807
vspace

# ╔═╡ 11eec2ac-ceb9-4a00-b0c0-b7670c9fdf18
md"""
### Exercise 4
"""

# ╔═╡ eccd3fe4-42e3-4f7d-a2da-8e1287c1f11a
md"""
Suppose you are given a vector with call option prices: `p = ["1.5", "2.5", missing, "4.5", "5.5", missing]`. You notice that numbers are stored as strings, and there are missing values. Convert the strings to Float64, while keeping missing values unchanged.

*Hint: use `passmissing` from the Missings.jl package and `parse`.*
"""

# ╔═╡ b73de587-ae67-4613-acbc-c8584a9b530f
let
using Missings
	
p = ["1.5", "2.5", missing, "4.5", "5.5", missing]

#Type your solution here	

end

# ╔═╡ 355ecb67-878d-4960-bec0-af9855aaedf2
vspace

# ╔═╡ 35e6b686-2daa-40f6-b348-6987406ba95b
# ╠═╡ show_logs = false
begin
using PlutoUI, Printf, LaTeXStrings, HypertextLiteral

	using Pkg
	#Pkg.upgrade_manifest()
	#Pkg.update()
	#Pkg.resolve()
	
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

# ╔═╡ bafa86e5-b340-4b99-b3d6-c31908824eaa
# ╠═╡ show_logs = false
begin
	
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

display("Custom Printing functions")
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Logging = "56ddb016-857b-54e1-b83d-db4d58db5568"
Missings = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
Pkg = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[compat]
HypertextLiteral = "~0.9.4"
LaTeXStrings = "~1.3.0"
Missings = "~1.1.0"
PlutoUI = "~0.7.49"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.0"
manifest_format = "2.0"
project_hash = "cb4b1a6541f1dc030097b78f2b668e01acfa591e"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "c278dfab760520b8bb7e9511b968bf4ba38b7acc"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.2.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+1"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

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

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

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
git-tree-sha1 = "68723afdb616445c6caaef6255067a8339f91325"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.55"

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

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

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
# ╟─e86c095f-b440-4935-9f60-9cdcd54ffb43
# ╟─ce1be57b-3d94-4f28-a307-8bafc01d9651
# ╟─83806080-8c00-11ec-0f46-01e9cff3af6f
# ╟─99902ed5-59aa-4984-a2d0-f31bfa28da34
# ╟─df2605a4-7651-403b-9d1d-8b1fd4b42df1
# ╟─c65aee9d-4d71-41f4-b381-b2ccb7d2572b
# ╟─b0f0701e-221e-4d9f-b601-0d0d6a3d0f87
# ╟─f420bee2-67b7-4303-aeea-e9a3f4a4a30d
# ╟─1c14adad-358d-469a-9f8a-697710ae9e0e
# ╟─9609264e-b4ce-4390-adc0-7821175b7e60
# ╠═f499ea41-c1ce-4ad1-9579-1aae4a535a58
# ╟─669f5626-f17f-4b58-abb8-0dcb25c14895
# ╟─3580b62d-fe8a-499c-8551-cac1a81d1b55
# ╟─f6c7b4fa-ec5d-4f16-816f-0c0327bf76b7
# ╠═0370fa97-a539-4f44-b8f5-155e8c430e74
# ╟─14422ed6-189b-4c88-aa9d-a6798ca25138
# ╟─c6fcd024-9691-42cc-964e-b027ba211b37
# ╟─c75cb5d1-d0d3-488c-8199-c5f75b11bb83
# ╟─a6b29f5d-b817-49c0-a3a0-e71a6f2e8065
# ╠═1fc81663-edaf-46f1-ab94-bf4960a84648
# ╟─994a949e-8139-422b-8d63-09f38d6341a1
# ╟─590427f3-22e9-4027-aca2-8b4627330807
# ╟─11eec2ac-ceb9-4a00-b0c0-b7670c9fdf18
# ╟─eccd3fe4-42e3-4f7d-a2da-8e1287c1f11a
# ╠═b73de587-ae67-4613-acbc-c8584a9b530f
# ╟─355ecb67-878d-4960-bec0-af9855aaedf2
# ╟─35e6b686-2daa-40f6-b348-6987406ba95b
# ╟─bafa86e5-b340-4b99-b3d6-c31908824eaa
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
