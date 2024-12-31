### A Pluto.jl notebook ###
# v0.19.9

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 99b44d29-ae23-4011-a108-42bfd71b22e5
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
	
	#helper functions
	#round to digits, e.g. 6 digits then prec=1e-6
	roundmult(val, prec) = (inv_prec = 1 / prec; round(val * inv_prec) / inv_prec); 

	using Logging
	global_logger(NullLogger())
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

# ╔═╡ 9e980f1f-3897-493d-99ef-7883eaf174d6
html"""
	<p align=left style="font-size:32px; font-family:family:Georgia"> <b> FINC 672: Workshop in Finance - Empirical Methods</b> <p>
	"""

# ╔═╡ 4fc37f0c-c84d-4451-8ab1-76e37cbc1eb1
begin 
	html"""
	<p style="padding-bottom:1cm"> </p>
	<div align=center style="font-size:25px; font-family:family:Georgia"> FINC-672: Workshop in Finance - Empirical Methods </div>
	<p style="padding-bottom:1cm"> </p>
	<p align=center style="font-size:25px; font-family:family:Georgia"> <b> Interactive Data Visualization </b> <p>
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

# ╔═╡ 133a4585-23ab-4c55-a97b-f841cbe672b6
vspace

# ╔═╡ 4f637ab6-b490-4651-8c2d-85b148694a9a
begin
html"""
<fieldset>      
<legend>Goals for today</legend>      
<br>
  <input type="checkbox" value="">Interactive components in Pluto. <br>      
  <input type="checkbox" value="">Interactive Data Visualization with PlotlyJS. <br>     <br> 
"""
end

# ╔═╡ a6dfa529-f1e1-46a1-84bc-43c68e931dde
vspace

# ╔═╡ dc060870-4a03-4fa8-8d27-c4bde0ab0a9c
md"""
- We begin by loading the `PlutoPlotly.jl` and `YFinance.jl` packages.
"""

# ╔═╡ 2ff2be70-af14-11ee-3d58-9b67f9c734c7
using YFinance, DataFrames, Statistics, Dates

# ╔═╡ 2acfb967-e2ad-4772-a81d-d0cc98dd7355
vspace

# ╔═╡ 20ceda13-98fb-41c8-a853-7a55de45e65e
md"""
- Next, we define interactive elements, allowing us to select a stock ticker and start/end dates for the stock price data.
"""

# ╔═╡ f2cb8ae6-6bcf-4d17-bbd7-12b07565fd52
# using PlutoPlotly

# ╔═╡ 904559d5-5a0c-4c6c-9175-23aae545e55f
# @bind symbols Select(["AAPL","MSFT"])

# ╔═╡ 8a07bf20-fdc8-4867-a781-3b19f1ce6436
# @bind start_date TextField(default="2012-01-01")

# ╔═╡ bf514c3e-1f3b-460e-9f43-e924e6eb8280
# @bind end_date TextField(default="2024-01-01")

# ╔═╡ 593af85e-e1a9-4ab1-bc70-31188111b5ab
vspace

# ╔═╡ 4ec54437-d86c-43ce-b132-f86baaad61bc
md"""
- Let's define a function to collect stock price data from Yahoo Finance.
"""

# ╔═╡ 6413c68f-84ed-47e8-b62e-e900e83b51e1
# function get_symbol_prices(symbols::Vector{String}, start_date::String, end_date::String)
# 	prices_dict = get_prices.(symbols, startdt= start_date, enddt=end_date)
# 	vcat([DataFrame(i) for i in prices_dict]...)
# end

# ╔═╡ 30be2eb0-bf49-4951-be28-f0f577667281
vspace

# ╔═╡ 792ae644-7230-4225-b862-5b8cb94cbb12
md"""
- Next, we use the interactive element for the stock ticker and the previous function to collect stock price data from the start to the end date set in the boxes above.
"""

# ╔═╡ 0cdc0c2b-4990-448b-be62-e83b01080cf1
# prices = get_symbol_prices([symbols], start_date, end_date)

# ╔═╡ d7f05838-c922-44ba-b2cd-29cae6a063c3
vspace

# ╔═╡ 2be5e70a-f766-4d98-b2ac-5647a43cbe19
md"""
- Next, we set up a Layout object for plotting stock prices.
"""

# ╔═╡ 6a41b8b1-f492-43f0-9a1a-74da21b1a03f
# ╠═╡ skip_as_script = true
#=╠═╡
# function plot_layout(title="") 
    
# 	l =  Layout(
#         title_text = "<b>$(title)</b>",
#         paper_bgcolor =:white,
#         plot_bgcolor =:white,
# 		width=600,height=500,
#         yaxis = attr(
#             gridcolor=:lightgrey,
#             griddash="dot",
#             zerolinecolor=:lightgrey),
#         xaxis=attr(
#             gridcolor=:lightgrey,
#             griddash="dot",
#             zerolinecolor=:lightgrey,
#             rangeslider_visible=true,
#             rangeselector=attr(
#                 buttons=[
#                     attr(count=1, label="1m", step="month", stepmode="backward"),
#                     attr(count=6, label="6m", step="month", stepmode="backward"),
#                     attr(count=1, label="YTD", step="year", stepmode="todate"),
#                     attr(count=1, label="1y", step="year", stepmode="backward"),
#                     attr(step="all")
#                     ]))) 
#     return l

# end;
  ╠═╡ =#

# ╔═╡ ca4150d7-9fe6-4e61-960c-5eb5c7077008
vspace

# ╔═╡ 631faf4e-25a0-48bf-9713-d102915ee447
md"""
- Next, let's use the layout to plot stock price paths.
"""

# ╔═╡ 4a43fd49-66a8-48c5-a011-991af53fb969


# ╔═╡ ceed3b68-2e2b-430b-8c1b-86deb703a589
vspace

# ╔═╡ 49360a56-1619-4385-b2d5-13cc5971dfd5
md"""
- One commonly-used technique is to use a moving average of past prices to show trends.
"""

# ╔═╡ ae736349-ef84-4bc5-a448-f1735ce4ef23


# ╔═╡ c0ca7327-7c14-4af7-a9df-55839aa4d11e
vspace

# ╔═╡ 4c098de4-d683-4432-b132-2ffb4a7c6570
md"""
- Let's add a 20-day moving average to the stock price data.
"""

# ╔═╡ e787069d-3eb2-425f-af42-6103c2fcc8cb


# ╔═╡ c39592ae-974f-4d99-ab8f-c955e1e54897
vspace

# ╔═╡ a23bb40a-9546-409a-9f5d-58e717195003
md"""
- Let's check the results of the computation.
"""

# ╔═╡ d99aa509-3d27-40fd-8ecc-8c2a15468b5e


# ╔═╡ e3366414-3335-421e-83b1-e2c7fdbbd368
vspace

# ╔═╡ 0c53f037-bcf3-4c9c-830d-9341be294639
md"""
- Let's plot the moving average stock price.
"""

# ╔═╡ 14fcee89-199e-48b4-8a13-ac8ca9931dc0


# ╔═╡ e42ab2aa-1242-41f8-882e-b5ba3ed27e57
vspace

# ╔═╡ 7e0e9f32-cfad-4594-9aa2-b067130aaf63
md"""
- Lastly, let's display both the actual and the moving-average stock price.
"""

# ╔═╡ 09d3292b-caca-4bff-b7cc-48ede0a0aa9d


# ╔═╡ be920cd2-cd8f-4b5c-85a9-5b9641f4b53d
vspace

# ╔═╡ 1c2b32bd-b91e-4cbe-b841-8630666f9898
md"""
## ESG Scores
"""

# ╔═╡ 25db0861-4063-45a5-95f7-be9f28654e8f
md"""
- To illustrate other types of plots, let's take a look at ESG ratings.
- [Guide to ESG Ratings](https://finance.yahoo.com/news/guide-understanding-esg-ratings-151501443.html)
"""

# ╔═╡ 1f5d1018-3418-46b7-b8c0-5623254c6c5c


# ╔═╡ 21a68cf1-b5ca-4448-849d-4a2ed232d13b
vspace

# ╔═╡ 9063bb97-844f-4ab0-8e60-962d5f7c0ada
md"""
- Let's define a function to create bar charts.
"""

# ╔═╡ a238d349-b9fc-4c7b-b8f7-8ab89711069c
# function create_barplot()
	


#     layout = Layout(barmode="group",
# 		width=600,
#         height=600,
#         legend=attr(
#             x=1,
#             y=52.02,
#             yanchor="bottom",
#             xanchor="right",
#             orientation="h"),
#             paper_bgcolor =:white,
#             plot_bgcolor =:white)


# end

# ╔═╡ 15a03116-4372-4138-a7b7-d8a63305d111
vspace

# ╔═╡ f2eea4f2-98d0-43cc-bf3f-bbe836bc4ce9
md"""
- Let's use this function to create a bar chart of ESG scores.
"""

# ╔═╡ a72b989b-d8ff-4529-8ee3-46770dc0fd80


# ╔═╡ b8646508-525b-49df-b770-2cfa2806c12b
vspace

# ╔═╡ 0ef68cda-bd96-4619-a1d2-64cf267877d4
md"""
# Wrap-Up
"""

# ╔═╡ 33c2f57f-a9f8-43ef-b8fd-274500dc0d36
begin
html"""
<fieldset>      
<legend>Goals for today</legend>      
<br>
  <input type="checkbox" value="" checked>Interactive components in Pluto. <br>      
  <input type="checkbox" value="" checked>Interactive Data Visualization with PlotlyJS. <br>     <br> 

"""
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Logging = "56ddb016-857b-54e1-b83d-db4d58db5568"
Pkg = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
YFinance = "e4b3b0a2-f9a3-42f3-aabb-32142cceaf77"

[compat]
DataFrames = "~1.6.1"
HypertextLiteral = "~0.9.5"
LaTeXStrings = "~1.3.1"
PlutoUI = "~0.7.58"
YFinance = "~0.1.4"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.0"
manifest_format = "2.0"
project_hash = "6d8994e5f480ee817ab6781d70e32c30bf04ff78"

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

[[deps.BitFlags]]
git-tree-sha1 = "2dc09997850d68179b69dafb58ae806167a32b1b"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.8"

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

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "9c4708e3ed2b799e6124b5673a712dda0b596a9b"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.3.1"

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
git-tree-sha1 = "1fb174f0d48fe7d142e1109a10636bc1d14f5ac2"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.17"

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

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "dcb08a0d93ec0b1cdc4af184b26b591e9695423a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.10"

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

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "ac7b73d562b8f4287c3b67b4c66a5395a19c1ae8"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.2"

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

[[deps.JSON3]]
deps = ["Dates", "Mmap", "Parsers", "PrecompileTools", "StructTypes", "UUIDs"]
git-tree-sha1 = "eb3edce0ed4fa32f75a0a11217433c31d56bd48b"
uuid = "0f8b85d8-7281-11e9-16c2-39a750bddbf1"
version = "1.14.0"

    [deps.JSON3.extensions]
    JSON3ArrowExt = ["ArrowTypes"]

    [deps.JSON3.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"

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

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "c1dd6d7978c12545b4179fb6153b9250c96b0075"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.3"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

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

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "51901a49222b09e3743c65b8847687ae5fc78eb2"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "60e3045590bd104a16fefb12836c00c0ef8c7f8c"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.0.13+0"

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
git-tree-sha1 = "03b4c25b43cb84cee5c90aa9b5ea0a78fd848d2f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00805cd429dcb4870060ff49ef443486c262e38e"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.1"

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

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

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

[[deps.StructTypes]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "ca4bccb03acf9faaf4137a9abc1881ed1841aa70"
uuid = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"
version = "1.10.0"

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
git-tree-sha1 = "54194d92959d8ebaa8e26227dbe3cdefcdcd594f"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.10.3"
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

[[deps.YFinance]]
deps = ["Base64", "Dates", "HTTP", "JSON3", "OrderedCollections"]
git-tree-sha1 = "f0876e222bd18f7ea2da2fd07b8c867112e584e0"
uuid = "e4b3b0a2-f9a3-42f3-aabb-32142cceaf77"
version = "0.1.4"

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
# ╟─99b44d29-ae23-4011-a108-42bfd71b22e5
# ╟─9e980f1f-3897-493d-99ef-7883eaf174d6
# ╟─4fc37f0c-c84d-4451-8ab1-76e37cbc1eb1
# ╟─133a4585-23ab-4c55-a97b-f841cbe672b6
# ╟─4f637ab6-b490-4651-8c2d-85b148694a9a
# ╟─a6dfa529-f1e1-46a1-84bc-43c68e931dde
# ╟─dc060870-4a03-4fa8-8d27-c4bde0ab0a9c
# ╠═2ff2be70-af14-11ee-3d58-9b67f9c734c7
# ╟─2acfb967-e2ad-4772-a81d-d0cc98dd7355
# ╟─20ceda13-98fb-41c8-a853-7a55de45e65e
# ╠═f2cb8ae6-6bcf-4d17-bbd7-12b07565fd52
# ╠═904559d5-5a0c-4c6c-9175-23aae545e55f
# ╠═8a07bf20-fdc8-4867-a781-3b19f1ce6436
# ╠═bf514c3e-1f3b-460e-9f43-e924e6eb8280
# ╟─593af85e-e1a9-4ab1-bc70-31188111b5ab
# ╟─4ec54437-d86c-43ce-b132-f86baaad61bc
# ╠═6413c68f-84ed-47e8-b62e-e900e83b51e1
# ╟─30be2eb0-bf49-4951-be28-f0f577667281
# ╟─792ae644-7230-4225-b862-5b8cb94cbb12
# ╠═0cdc0c2b-4990-448b-be62-e83b01080cf1
# ╟─d7f05838-c922-44ba-b2cd-29cae6a063c3
# ╟─2be5e70a-f766-4d98-b2ac-5647a43cbe19
# ╠═6a41b8b1-f492-43f0-9a1a-74da21b1a03f
# ╟─ca4150d7-9fe6-4e61-960c-5eb5c7077008
# ╟─631faf4e-25a0-48bf-9713-d102915ee447
# ╠═4a43fd49-66a8-48c5-a011-991af53fb969
# ╟─ceed3b68-2e2b-430b-8c1b-86deb703a589
# ╟─49360a56-1619-4385-b2d5-13cc5971dfd5
# ╠═ae736349-ef84-4bc5-a448-f1735ce4ef23
# ╟─c0ca7327-7c14-4af7-a9df-55839aa4d11e
# ╟─4c098de4-d683-4432-b132-2ffb4a7c6570
# ╠═e787069d-3eb2-425f-af42-6103c2fcc8cb
# ╟─c39592ae-974f-4d99-ab8f-c955e1e54897
# ╟─a23bb40a-9546-409a-9f5d-58e717195003
# ╠═d99aa509-3d27-40fd-8ecc-8c2a15468b5e
# ╟─e3366414-3335-421e-83b1-e2c7fdbbd368
# ╟─0c53f037-bcf3-4c9c-830d-9341be294639
# ╠═14fcee89-199e-48b4-8a13-ac8ca9931dc0
# ╟─e42ab2aa-1242-41f8-882e-b5ba3ed27e57
# ╟─7e0e9f32-cfad-4594-9aa2-b067130aaf63
# ╠═09d3292b-caca-4bff-b7cc-48ede0a0aa9d
# ╟─be920cd2-cd8f-4b5c-85a9-5b9641f4b53d
# ╟─1c2b32bd-b91e-4cbe-b841-8630666f9898
# ╟─25db0861-4063-45a5-95f7-be9f28654e8f
# ╠═1f5d1018-3418-46b7-b8c0-5623254c6c5c
# ╟─21a68cf1-b5ca-4448-849d-4a2ed232d13b
# ╟─9063bb97-844f-4ab0-8e60-962d5f7c0ada
# ╠═a238d349-b9fc-4c7b-b8f7-8ab89711069c
# ╟─15a03116-4372-4138-a7b7-d8a63305d111
# ╟─f2eea4f2-98d0-43cc-bf3f-bbe836bc4ce9
# ╠═a72b989b-d8ff-4529-8ee3-46770dc0fd80
# ╟─b8646508-525b-49df-b770-2cfa2806c12b
# ╟─0ef68cda-bd96-4619-a1d2-64cf267877d4
# ╟─33c2f57f-a9f8-43ef-b8fd-274500dc0d36
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
