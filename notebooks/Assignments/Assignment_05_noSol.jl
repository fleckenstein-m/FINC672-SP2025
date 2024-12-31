### A Pluto.jl notebook ###
# v0.19.39

using Markdown
using InteractiveUtils

# ╔═╡ 35e6b686-2daa-40f6-b348-6987406ba95b
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
		
end

# ╔═╡ d7e2e472-6aae-4d12-ab51-d8ed83a2d201
html"""
	<p align=left style="font-size:32px; font-family:family:Georgia"> <b> FINC 672: Workshop in Finance - Empirical Methods</b> <p>
	"""

# ╔═╡ 822f9a29-2599-4ad6-8902-ad9cc3aab263
begin 
	html"""
	<p style="padding-bottom:1cm"> </p>
	<div align=center style="font-size:25px; font-family:family:Georgia"> FINC-672: Workshop in Finance - Empirical Methods </div>
	<p style="padding-bottom:1cm"> </p>
	<p align=center style="font-size:25px; font-family:family:Georgia"> <b> Assignment 05</b> <p>
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

# ╔═╡ b68a17d2-a3e7-4379-a441-1ca20a8970c5
vspace

# ╔═╡ 806aebe8-d7b8-4dde-b5a2-401ec631b444
md"""
# Gold Prices and Exchange Rates

- The goal of this assignment is to analyze daily data on gold prices and exchange rates. 
- The data for this assignment is made available via a Web API, which is described at [https://api.nbp.pl/en.html](https://api.nbp.pl/en.html).
"""

# ╔═╡ 155f8b79-4163-4759-b4d6-2085be2dd77b
vspace

# ╔═╡ 82c2c7f4-3e69-4800-bb2d-2b82d2403145
md"""
__0. Load the `Chain`, `DataFrames`, `Dates`, `FreqTables`, `HTTP`, `JSON3`, and `Statistics` packages.__
"""

# ╔═╡ 0084413a-acae-4ccb-a38a-93c48243cfbc


# ╔═╡ 8cce31ee-d948-4af5-9cab-25d836ec1732
vspace

# ╔═╡ 5fdb6824-5508-4d8e-a947-6b68fa1f9c04
md"""
__1. Create a vector of daily dates for the period from January 1st, 2024 to March 15, 2024.__
- Call this vector `SamplePeriod`. This vector has the dates for the sample period used in the subsequent analyses.
"""

# ╔═╡ edd1716f-a882-4678-982e-4ad1796c9ad4


# ╔═╡ 6a4c45b1-c5ab-48c1-b2d0-77f0ec9c2cc0
vspace

# ╔═╡ bc4a619f-bda2-4eaa-b56a-3ea9e2b93fc7
md"""
__2. Write a function `get_fxrate` that returns PLN/USD exchange rate data for a specific date.__
- Recall that the API request can be made via http protocal using
`https://api.nbp.pl/api/exchangerates/rates/a/usd/YYYY-MM-DD/?format=json`
  - Note that we need to replace the YYYY-MM-DD part with a specific date, first passing four digits for the year, then two digits for the month, and finally two digits for the day.

"""

# ╔═╡ 1d0dd4b6-6189-4986-a852-25a9e0177a0c


# ╔═╡ 288ce3c2-1a63-446e-9fd1-1c64fe752835
vspace

# ╔═╡ 056663c8-7fdc-4862-a9d7-1ccf83610ac1
md"""
__3. Write a function `get_goldprice` that returns gold price data for a specific date.__

- Note from the API manual that the API request can be made via http protocal using
`https://api.nbp.pl/api/cenyzlota/YYYY-MM-DD/?format=json`

  - Note that we need to replace the YYYY-MM-DD part with a specific date, first passing four digits for the year, then two digits for the month, and finally two digits for the day.

"""


# ╔═╡ c51c832c-fc40-4126-bb0a-3b89569d4561
md"""
- Here is an example for the gold price on March 15, 2024.
- We see that the gold price (`cena` means price in English) can be accessed via the field `cena`, i.e., we can `json.cena` to get the value of the gold price on that date.
"""

# ╔═╡ 02e6a8e0-8edf-4dc9-ab4a-c63e606e0def
#let
#query = "https://api.nbp.pl/api/cenyzlota/2024-03-15/?format=json"
#response = HTTP.get(query)
#json = JSON3.read(response.body)
#end

# ╔═╡ 6da7a4bd-4cd4-4b84-8fb4-4a207dc5c393
vspace

# ╔═╡ c36d1ac0-0eb1-482c-afa0-ac0411a2bd39


# ╔═╡ 9a45dbe4-d28c-4784-8d9e-fffb117765eb
vspace

# ╔═╡ 736dd22c-e73b-465f-bda3-17abc64b49c8
md"""
__4. Use the two functions from Questions 2. and 3. to collect PLN/USD exchange rates and gold prices for the dates in the sample period. Create a DataFrame with the name `GoldAndFx` that has one column for the date, a column for the exchanges rates, and one column for the gold prices.__
- Note: the exchange rate is quoted in terms of Polish zloty per USD (i.e., it is the price of \$1 in terms of Polish zloty).
"""

# ╔═╡ 8da702ce-fa95-4d97-882e-9a13a9b5c381


# ╔═╡ db4ebe3d-4d69-4d7a-9ef0-0b78f63c7c09


# ╔═╡ 7d8e8d41-b1d7-4bc9-87b3-6cd78b044e97


# ╔═╡ 32f2a06d-1a92-440e-9bc9-93c492719df1
vspace

# ╔═╡ 5e8d96b0-c1e9-4917-89f4-08d1bbfc728c
md"""
__5. Analyze whether there are missing observations in the foreign exchange and gold price data. Are there missing values for any days during the workweek (i.e., from Monday through Friday)? If so, can you explain these missing values?__
"""

# ╔═╡ 88401a57-76dd-4f99-8515-522a1f6edfe7


# ╔═╡ b678a9c1-c401-416c-acb4-0a9b26d45d33


# ╔═╡ 0c7ab1ce-0fbd-4a84-9735-e07c463bff79


# ╔═╡ 81883771-459b-4c7c-a529-457e5868fb4b


# ╔═╡ dd053f81-18ad-4bc3-8b19-a9c1c0ebd1a1
vspace

# ╔═╡ 3969bff6-dc28-46d9-abbf-183fd82c8189
md"""
__6. Convert the gold prices, which are quoted in Polish `zloty`, to USD. Store the result in a new DataFrame (keep only the date column and the gold price in USD),__
- Note that the converted price is the price in USD for one gram of gold.
"""

# ╔═╡ c5931493-fe35-4cea-b820-d40b261a8d80


# ╔═╡ b07d065e-e7fe-41ae-9df5-ee6d02e7d8d2
vspace

# ╔═╡ c0ba7689-ebf1-4f15-92bb-637b0e7108bf
md"""
__7. Convert the gold price which is in terms of USD per gram of gold to the equivalent dollar price per oz of gold. Store the result in a new DataFrame `GoldPxUSDPerOz` (keep only the date column and the gold price per oz of gold).__
- Note: there are 31.1034768 grams in an ounce of gold.
"""

# ╔═╡ d4c9adc9-02a4-4fb7-8ec1-9ab5b08cbbca


# ╔═╡ 795eb168-d674-4595-a188-b36d80e1a065
vspace

# ╔═╡ 29de608f-2921-4e39-b7e2-4c5afd2528b3
md"""
__8. Plot the gold price from Question 7 over the entire sample period.__
"""

# ╔═╡ 17feaa79-2394-4cc8-995e-dec9510199e2


# ╔═╡ d73f83b6-9d32-4c47-93dd-07856660232f
vspace

# ╔═╡ 98e77325-e121-47ae-9337-2bde4b72df1f
md"""
__9. Use linear interpolation to replace the missing values in the gold price data. Create a new DataFrame `GoldPxUSDPerOzInterp`, where the missing values are replaced by the interpolated prices (keep only the date column and the column with the interpolated gold prices).__
- Recall that we need to load the `Impute` package.
"""

# ╔═╡ 5412d08d-9232-44fe-aaa6-4970e0795bc9
begin
	
end

# ╔═╡ e1b67e90-f0af-4c95-bc7a-f4c85d0902ef
vspace

# ╔═╡ 1fadad74-aa06-47b5-b513-401235e70f9c
md"""
__10. Make a plot of the interpolated gold prices over the entire sample period.__
"""

# ╔═╡ 2d47eead-9131-44aa-b116-cc1688999945


# ╔═╡ 22934d73-3ad2-4e44-8a54-3b3ab6cea1a1
vspace

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
HypertextLiteral = "~0.9.4"
LaTeXStrings = "~1.3.0"
PlutoUI = "~0.7.34"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.0"
manifest_format = "2.0"
project_hash = "4c6021f27ec3b25c54b78b2a1f688decef667929"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "793501dcd3fa7ce8d375a2c878dca2296232686e"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.2.2"

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
version = "0.3.23+2"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "a935806434c9d4c506ba941871b327b96d41f2bf"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "bd7c69c7f7173097e7b5e1be07cee2b8b7447f51"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.54"

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
# ╟─d7e2e472-6aae-4d12-ab51-d8ed83a2d201
# ╟─822f9a29-2599-4ad6-8902-ad9cc3aab263
# ╟─b68a17d2-a3e7-4379-a441-1ca20a8970c5
# ╟─806aebe8-d7b8-4dde-b5a2-401ec631b444
# ╟─155f8b79-4163-4759-b4d6-2085be2dd77b
# ╟─82c2c7f4-3e69-4800-bb2d-2b82d2403145
# ╠═0084413a-acae-4ccb-a38a-93c48243cfbc
# ╟─8cce31ee-d948-4af5-9cab-25d836ec1732
# ╟─5fdb6824-5508-4d8e-a947-6b68fa1f9c04
# ╠═edd1716f-a882-4678-982e-4ad1796c9ad4
# ╟─6a4c45b1-c5ab-48c1-b2d0-77f0ec9c2cc0
# ╟─bc4a619f-bda2-4eaa-b56a-3ea9e2b93fc7
# ╠═1d0dd4b6-6189-4986-a852-25a9e0177a0c
# ╟─288ce3c2-1a63-446e-9fd1-1c64fe752835
# ╟─056663c8-7fdc-4862-a9d7-1ccf83610ac1
# ╟─c51c832c-fc40-4126-bb0a-3b89569d4561
# ╠═02e6a8e0-8edf-4dc9-ab4a-c63e606e0def
# ╟─6da7a4bd-4cd4-4b84-8fb4-4a207dc5c393
# ╠═c36d1ac0-0eb1-482c-afa0-ac0411a2bd39
# ╟─9a45dbe4-d28c-4784-8d9e-fffb117765eb
# ╟─736dd22c-e73b-465f-bda3-17abc64b49c8
# ╠═8da702ce-fa95-4d97-882e-9a13a9b5c381
# ╠═db4ebe3d-4d69-4d7a-9ef0-0b78f63c7c09
# ╠═7d8e8d41-b1d7-4bc9-87b3-6cd78b044e97
# ╟─32f2a06d-1a92-440e-9bc9-93c492719df1
# ╟─5e8d96b0-c1e9-4917-89f4-08d1bbfc728c
# ╠═88401a57-76dd-4f99-8515-522a1f6edfe7
# ╠═b678a9c1-c401-416c-acb4-0a9b26d45d33
# ╠═0c7ab1ce-0fbd-4a84-9735-e07c463bff79
# ╠═81883771-459b-4c7c-a529-457e5868fb4b
# ╟─dd053f81-18ad-4bc3-8b19-a9c1c0ebd1a1
# ╟─3969bff6-dc28-46d9-abbf-183fd82c8189
# ╠═c5931493-fe35-4cea-b820-d40b261a8d80
# ╟─b07d065e-e7fe-41ae-9df5-ee6d02e7d8d2
# ╟─c0ba7689-ebf1-4f15-92bb-637b0e7108bf
# ╠═d4c9adc9-02a4-4fb7-8ec1-9ab5b08cbbca
# ╟─795eb168-d674-4595-a188-b36d80e1a065
# ╟─29de608f-2921-4e39-b7e2-4c5afd2528b3
# ╠═17feaa79-2394-4cc8-995e-dec9510199e2
# ╟─d73f83b6-9d32-4c47-93dd-07856660232f
# ╟─98e77325-e121-47ae-9337-2bde4b72df1f
# ╠═5412d08d-9232-44fe-aaa6-4970e0795bc9
# ╟─e1b67e90-f0af-4c95-bc7a-f4c85d0902ef
# ╟─1fadad74-aa06-47b5-b513-401235e70f9c
# ╠═2d47eead-9131-44aa-b116-cc1688999945
# ╟─22934d73-3ad2-4e44-8a54-3b3ab6cea1a1
# ╟─35e6b686-2daa-40f6-b348-6987406ba95b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
