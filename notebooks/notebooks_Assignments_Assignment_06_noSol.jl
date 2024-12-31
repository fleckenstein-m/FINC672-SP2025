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
	<p align=center style="font-size:25px; font-family:family:Georgia"> <b> Assignment 06</b> <p>
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

# ╔═╡ 2a5055b4-2137-447d-bfd2-a26cc4b14735
#Load Packages
#using Chain, CSV, DataFrames, Dates, ShiftedArrays, Statistics

# ╔═╡ 2ff3a933-14ba-43e4-96a8-99667f31811a
vspace

# ╔═╡ b8d464a5-7110-4260-86b6-f7d5d4f4f529
md"""
# CRSP Data
- Download the CRSP Monthly Stock File from January 2000 through December 2023.
- You find this dataset on WRDS under the section `CRSP.` In the subsection `Annual Update`, click on `Stock/Security Files` and then on `Monthly Stock File.`
- To download the dataset, set the date range in `Step 1`. Then, under `Step 2`  select `Ticker` and check the box `Search Entire Database`. In `Step 3`, select all query variables. In `Step 4`, select `.csv` as the output file format.
- Save this dataset using the filename `CRSP_monthly.csv` in the same folder as this Pluto notebook.
"""

# ╔═╡ 298855fe-89ba-446a-ae07-39a1d59ed23a
md"""
__1.__ Load the CRSP dataset into a DataFrame with the name `CRSP`.
"""

# ╔═╡ 42846d81-97f9-4d01-bd1c-622f0e9d2cfb
 

# ╔═╡ f925da7e-fc9d-4478-9f98-a96fffa791c7
vspace

# ╔═╡ e8bcbdc8-5b7b-4885-8b1b-e9d87fd3477e
md"""
__2.__ Select a stock of your choice that has monthly data going back to January 2000.
Also, select the variables `date`, `TICKER`, `PERMCO`, `PERMNO`, `PRC`, `DIVAMT`). Make sure that you have only one price observations for each month.
"""

# ╔═╡ e8a41300-2ec7-4cb9-a23c-e0e65ddbf09f


# ╔═╡ 690ef0be-8bda-40e0-8f94-c454fd7257d1
vspace

# ╔═╡ 2a18e0ef-4332-4a11-af9f-3efea3f8f69d
md"""
__3.__ Define a function that takes as input $P_t$, $D_t$, and $P_{t-1}$ and calculates the return $R_t$. Also define a function that calculates the log return.
"""

# ╔═╡ 6cd7bf55-f557-4d43-a40e-018c264e9e8c


# ╔═╡ a237c0af-9e34-47ce-8464-ea6167fa357b


# ╔═╡ a0623095-25c4-4ed5-9189-e61c39e9fe85
vspace

# ╔═╡ 676cde59-609d-4312-b5a5-ff2aac79d655
md"""
__4.__ Use the functions defined in __3.__ above to calculate monthly returns (log returns) for the stock you selected. 
"""

# ╔═╡ c0cb6da5-2946-47b5-9924-ed27e10e2387


# ╔═╡ 5d4fc0ee-e3aa-404a-8983-bdf73cd4abe1
vspace

# ╔═╡ 25a6efe4-fffb-49a7-95fe-7f8fccb7dbf0
md"""
__5.__ Calculate the cumulative return from holding your stock over the 2000-2023 period (using monthly returns) assuming you invest one dollar in January 2000.
"""

# ╔═╡ 3bd5235e-5d49-4e66-b2d5-5d8879609e6b


# ╔═╡ 5b46d617-14f3-4c85-8e79-76a75c324fc5
vspace

# ╔═╡ 3ed09455-2ff5-4061-a7ce-ce412d2e04a3
md"""
__6.__ Select 5 stocks of your choice to form a portfolio. For each of the stocks, calculate its monthly returns (log returns). Make sure that you have only one observation for each month (and each stock) in the dataset.
"""

# ╔═╡ e89ecb62-4c0f-4266-863b-529694cca1c0


# ╔═╡ 3d30fa0b-2fcd-4fe8-a258-7efda3b528d2
vspace

# ╔═╡ d257a6f1-6695-47f3-a97b-2d342434aa7a
md"""
__7.__ Reshape the dataset so that each stock is in a separate column. In the resulting dataset, the dates should be in the leftmost column.
"""

# ╔═╡ 099cb146-9be3-4bd9-bc1f-cd4d518e11b9


# ╔═╡ 7276d164-7202-4905-9cf9-adbd8082e469
vspace

# ╔═╡ ccb6bb81-cda6-43de-a342-3ea48420b8d5
md"""
__8.__ Pick a  portfolio weight vector.
"""

# ╔═╡ dcf072dd-1bc7-4dc5-ac83-6a5a57477b51


# ╔═╡ 9b75cebc-986c-479b-ae46-9e06706bda14
vspace

# ╔═╡ 5356063c-e54d-42f1-be6c-1531cb25705c
md"""
__9.__ Using the portfolio weights, calculate monthly returns for your portfolio.
"""

# ╔═╡ 9b232808-dc23-410a-999b-5e1223e80e65


# ╔═╡ 2df7f460-4acb-4bc9-8e43-6984c3f97038
vspace

# ╔═╡ 2be8d4f8-2646-4516-b1d8-5982b5b9e990
md"""
__10.__ Create a table showing the average monthly return for each stock and for your stock portfolio. Also show the standard deviation of returns, the minimum, the median, and the maximum monthly returns.
"""

# ╔═╡ 7fcee75d-2031-4515-bc88-155cbbc11b39


# ╔═╡ 3d9c2bd4-1915-449d-8d79-824b424d4425
vspace

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
	#Pkg.resolve()
	#Pkg.update()

	
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
	
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Logging = "56ddb016-857b-54e1-b83d-db4d58db5568"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[compat]
HypertextLiteral = "~0.9.4"
LaTeXStrings = "~1.3.0"
PlutoUI = "~0.7.49"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.2"
manifest_format = "2.0"
project_hash = "fde4819cc39136b7b8ab39e68b38535ecaf5dde0"

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

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.0+0"

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
version = "0.3.23+4"

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
# ╟─2027e83e-ead0-4e05-9bd8-bf157f90778c
# ╟─c62078fa-1047-4b7a-babb-c724f358f136
# ╟─95a3731a-f718-42ce-ae12-aa317a4dc0c6
# ╠═2a5055b4-2137-447d-bfd2-a26cc4b14735
# ╟─2ff3a933-14ba-43e4-96a8-99667f31811a
# ╟─b8d464a5-7110-4260-86b6-f7d5d4f4f529
# ╟─298855fe-89ba-446a-ae07-39a1d59ed23a
# ╠═42846d81-97f9-4d01-bd1c-622f0e9d2cfb
# ╟─f925da7e-fc9d-4478-9f98-a96fffa791c7
# ╟─e8bcbdc8-5b7b-4885-8b1b-e9d87fd3477e
# ╠═e8a41300-2ec7-4cb9-a23c-e0e65ddbf09f
# ╟─690ef0be-8bda-40e0-8f94-c454fd7257d1
# ╟─2a18e0ef-4332-4a11-af9f-3efea3f8f69d
# ╠═6cd7bf55-f557-4d43-a40e-018c264e9e8c
# ╠═a237c0af-9e34-47ce-8464-ea6167fa357b
# ╟─a0623095-25c4-4ed5-9189-e61c39e9fe85
# ╟─676cde59-609d-4312-b5a5-ff2aac79d655
# ╠═c0cb6da5-2946-47b5-9924-ed27e10e2387
# ╟─5d4fc0ee-e3aa-404a-8983-bdf73cd4abe1
# ╟─25a6efe4-fffb-49a7-95fe-7f8fccb7dbf0
# ╠═3bd5235e-5d49-4e66-b2d5-5d8879609e6b
# ╟─5b46d617-14f3-4c85-8e79-76a75c324fc5
# ╟─3ed09455-2ff5-4061-a7ce-ce412d2e04a3
# ╠═e89ecb62-4c0f-4266-863b-529694cca1c0
# ╟─3d30fa0b-2fcd-4fe8-a258-7efda3b528d2
# ╟─d257a6f1-6695-47f3-a97b-2d342434aa7a
# ╠═099cb146-9be3-4bd9-bc1f-cd4d518e11b9
# ╟─7276d164-7202-4905-9cf9-adbd8082e469
# ╟─ccb6bb81-cda6-43de-a342-3ea48420b8d5
# ╠═dcf072dd-1bc7-4dc5-ac83-6a5a57477b51
# ╟─9b75cebc-986c-479b-ae46-9e06706bda14
# ╟─5356063c-e54d-42f1-be6c-1531cb25705c
# ╠═9b232808-dc23-410a-999b-5e1223e80e65
# ╟─2df7f460-4acb-4bc9-8e43-6984c3f97038
# ╟─2be8d4f8-2646-4516-b1d8-5982b5b9e990
# ╠═7fcee75d-2031-4515-bc88-155cbbc11b39
# ╟─3d9c2bd4-1915-449d-8d79-824b424d4425
# ╟─97840d49-e48d-40be-ab09-e3dea866143c
# ╟─e796c131-5a67-4a99-8df2-b7ea52a03056
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
