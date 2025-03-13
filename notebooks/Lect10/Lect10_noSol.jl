### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

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
	<p align=center style="font-size:25px; font-family:family:Georgia"> Spring 2025 <p>
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


# ╔═╡ 2acfb967-e2ad-4772-a81d-d0cc98dd7355
vspace

# ╔═╡ 20ceda13-98fb-41c8-a853-7a55de45e65e
md"""
- Next, we define interactive elements, allowing us to select a stock ticker and start/end dates for the stock price data.
"""

# ╔═╡ f2cb8ae6-6bcf-4d17-bbd7-12b07565fd52


# ╔═╡ 904559d5-5a0c-4c6c-9175-23aae545e55f


# ╔═╡ 8a07bf20-fdc8-4867-a781-3b19f1ce6436


# ╔═╡ bf514c3e-1f3b-460e-9f43-e924e6eb8280


# ╔═╡ 593af85e-e1a9-4ab1-bc70-31188111b5ab
vspace

# ╔═╡ 4ec54437-d86c-43ce-b132-f86baaad61bc
md"""
- Let's define a function to collect stock price data from Yahoo Finance.
"""

# ╔═╡ 6413c68f-84ed-47e8-b62e-e900e83b51e1


# ╔═╡ 30be2eb0-bf49-4951-be28-f0f577667281
vspace

# ╔═╡ 792ae644-7230-4225-b862-5b8cb94cbb12
md"""
- Next, we use the interactive element for the stock ticker and the previous function to collect stock price data from the start to the end date set in the boxes above.
"""

# ╔═╡ 0cdc0c2b-4990-448b-be62-e83b01080cf1


# ╔═╡ d7f05838-c922-44ba-b2cd-29cae6a063c3
vspace

# ╔═╡ 2be5e70a-f766-4d98-b2ac-5647a43cbe19
md"""
- Next, we set up a Layout object for plotting stock prices.
"""

# ╔═╡ 6a41b8b1-f492-43f0-9a1a-74da21b1a03f
# ╠═╡ skip_as_script = true
#=╠═╡

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

# ╔═╡ a69f528f-d94a-4519-91dd-a6149c958ba9


# ╔═╡ c39592ae-974f-4d99-ab8f-c955e1e54897
vspace

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

# ╔═╡ ca897b9a-fd6c-42b0-b27f-e86f146723a0
md"""
- In doing this, we learn a new technique, i.e., we learn to "stack" a DataFrame.
- Stacking a DataFrame refers to reshaping it by pivoting the columns into rows. This operation compresses a DataFrame from a wide format (where data is spread across multiple columns) to a long format (where data is stacked vertically under one index/level).
- This process is illustrated below.
"""

# ╔═╡ 10d5b1ed-4925-4eb9-8355-07732389f9ea
md"""
- Let's do this with ESG score data.
"""

# ╔═╡ 1f5d1018-3418-46b7-b8c0-5623254c6c5c


# ╔═╡ 13848809-3b1e-4240-b5d2-348da4957c83


# ╔═╡ 21a68cf1-b5ca-4448-849d-4a2ed232d13b
vspace

# ╔═╡ 9063bb97-844f-4ab0-8e60-962d5f7c0ada
md"""
- Let's define a function to create bar charts.
"""

# ╔═╡ a238d349-b9fc-4c7b-b8f7-8ab89711069c


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
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Logging = "56ddb016-857b-54e1-b83d-db4d58db5568"
Pkg = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[compat]
HypertextLiteral = "~0.9.5"
LaTeXStrings = "~1.4.0"
PlutoUI = "~0.7.58"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.2"
manifest_format = "2.0"
project_hash = "046d33f718484ef467aa693bd1600264bbb8b67c"

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

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

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

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

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
git-tree-sha1 = "1833212fd6f580c20d4291da9c1b4e8a655b128e"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.0.0"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

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

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"

    [deps.Pkg.extensions]
    REPLExt = "REPL"

    [deps.Pkg.weakdeps]
    REPL = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "7e71a55b87222942f0f9337be62e26b1f103d3e4"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.61"

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

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

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
version = "1.11.0"

[[deps.Tricks]]
git-tree-sha1 = "6cae795a5a9313bbb4f60683f7263318fc7d1505"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.10"

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
# ╠═a69f528f-d94a-4519-91dd-a6149c958ba9
# ╟─c39592ae-974f-4d99-ab8f-c955e1e54897
# ╟─e3366414-3335-421e-83b1-e2c7fdbbd368
# ╟─0c53f037-bcf3-4c9c-830d-9341be294639
# ╠═14fcee89-199e-48b4-8a13-ac8ca9931dc0
# ╟─e42ab2aa-1242-41f8-882e-b5ba3ed27e57
# ╟─7e0e9f32-cfad-4594-9aa2-b067130aaf63
# ╠═09d3292b-caca-4bff-b7cc-48ede0a0aa9d
# ╟─be920cd2-cd8f-4b5c-85a9-5b9641f4b53d
# ╟─1c2b32bd-b91e-4cbe-b841-8630666f9898
# ╟─25db0861-4063-45a5-95f7-be9f28654e8f
# ╟─ca897b9a-fd6c-42b0-b27f-e86f146723a0
# ╟─10d5b1ed-4925-4eb9-8355-07732389f9ea
# ╠═1f5d1018-3418-46b7-b8c0-5623254c6c5c
# ╠═13848809-3b1e-4240-b5d2-348da4957c83
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
