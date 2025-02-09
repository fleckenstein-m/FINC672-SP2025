### A Pluto.jl notebook ###
# v0.19.9

using Markdown
using InteractiveUtils

# ╔═╡ 57cb0c12-e132-43f4-8d8a-1cb6149b0963
html"""
	<p align=left style="font-size:32px; font-family:family:Georgia"> <b> FINC 672: Workshop in Finance - Empirical Methods</b> <p>
	"""

# ╔═╡ d7513630-1d64-4ef6-a417-7d7d65f888f1
html"""
	<p style="padding-bottom:1cm"> </p>
	<div align=center style="font-size:25px; font-family:family:Georgia"> FINC-672: Workshop in Finance - Empirical Methods </div>
	<p style="padding-bottom:1cm"> </p>
	<p align=center style="font-size:25px; font-family:family:Georgia"> <b> Julia Data Structures II </b> <p>
	<p style="padding-bottom:1cm"> </p>
	<p align=center style="font-size:25px; font-family:family:Georgia"> Spring 2025 <p>
	<p style="padding-bottom:0.5cm"> </p>
	<div align=center style="font-size:20px; font-family:family:Georgia"> Prof. Matt Fleckenstein </div>
	<p style="padding-bottom:0.05cm"> </p>
	<div align=center style="font-size:20px; font-family:family:Georgia"> University of Delaware, 
	Lerner College of Business and Economics </div>
	<p style="padding-bottom:0.5cm"> </p>
	"""

# ╔═╡ ab6ac8d0-6d8a-11ed-0400-1b357312718e
vspace

# ╔═╡ 42d2dc69-c5e8-4cb8-809b-19cae75e479d
begin
	html"""
	<fieldset>      
    <legend><b>Learning Objectives</b></legend>      
	<br>
	<input type="checkbox" value=""> Broadcasting Operators and Functions
	<br>
	<input type="checkbox" value=""> Comprehensions
	<br>
	<input type="checkbox" value=""> Iteration over Matrices
	<br>
	<br>
	</fieldset>      
	"""
end

# ╔═╡ 6ce01efd-8846-4c63-b41d-dbd2bea213b1
vspace

# ╔═╡ cc7cbf20-9ab5-41e1-967a-f426183246a5
md"""
## Broadcasting
"""

# ╔═╡ 72eaafb9-4130-43fa-b2c5-536509aa5bd5
md"""
- For mathematical operations, like `*` (multiplication) or `+` (addition), we can broadcast it using the dot operator `.`
- For example, broadcasted addition would imply changing the `+` to `.+`
"""

# ╔═╡ c5568d49-9a87-4224-bdf5-4365d77a44e4


# ╔═╡ 93ea5c80-8dc9-42f7-860a-09a797ae4047
begin

	
end

# ╔═╡ 422dd2fc-9103-4fab-8e0a-e5026c7c221e
vspace

# ╔═╡ fb14b35e-894f-4212-85e0-cbc15b029699
md"""
- It also works with functions automatically.
- Let’s use the logarithm function
"""

# ╔═╡ c772d04b-c584-45b0-8935-b8c643fa19b3


# ╔═╡ 24be1cc2-e132-477f-92dc-5defe2d3de4b
vspace

# ╔═╡ c671e317-3d47-4f33-a7a8-3e0389d3b883
md"""
- We can also use anonymous functions.
- To do this, the `map()` function becomes handy. It allows us to apply a (anonymous) function to each element of a vector or matrix.
- Let's illustrate this using an example.
"""

# ╔═╡ 03e8d7c3-e992-42e8-a9cf-b2051011b13e


# ╔═╡ 391a757b-6cfc-4416-8e32-eec931912401


# ╔═╡ 6433fafe-c644-4cc1-b882-6ec52764ea91
vspace

# ╔═╡ bc381236-8532-4cf9-8224-5b6cdef25bbb
md"""
- As a shortcut, we can also do this without giving the anonymous function a label.
"""

# ╔═╡ f80aa11f-6246-4d36-92e3-8673b07e3d11


# ╔═╡ e21e99b0-507c-461d-8219-71c703f9f163


# ╔═╡ 80402620-7794-44f3-b31d-5d33e64995e1
vspace

# ╔═╡ 51a6042d-3999-423a-ac54-71ed9d856474
md"""
#### Exercise
1. We have two stocks (Stock A and Stock B), and three periods. The table below shows annual stock returns in the three periods, expressed as percentages. Set up a matrix with the stock returns.
  - _Hint: use a `begin` `end` block so that you can re-use the stock return matrix in the next questions._

| Period | Stock A | Stock B |
|:-------|:--------|:--------|
| 1      |  10     |   1     |
| 2      |  -2     |   8     |
| 3      |  3      |   -2    |

"""

# ╔═╡ e7d168d6-6dd1-4329-80cc-51f8598ce49b
begin


end

# ╔═╡ ce4b785d-3f14-4604-aed2-8a7b273d1452
vspace

# ╔═╡ 0cd00220-5d3b-470d-8939-0548f4202e29
md"""
2. Use indexing to select the return of Stock A in the third period.
"""

# ╔═╡ fb47f483-903a-4cac-8663-54078cd3303a


# ╔═╡ 9dcfab70-ae04-40a2-b0e8-1d82c946685b
vspace

# ╔═╡ e74f4ca0-b66a-47c4-9c17-da6991242a91
md"""
3. Use indexing to select all returns for Stock B.
"""

# ╔═╡ f831111c-79aa-4b41-9363-7441a54a8a7d


# ╔═╡ 46d00ed5-a2bd-467a-b398-687487945770
vspace

# ╔═╡ 0ad97376-cf1e-4cc8-a2a1-c15240ed7397
md"""
4. Use indexing to select the returns of both stocks in period 2.
"""

# ╔═╡ 84811113-a003-484a-8eed-03bd40c23120


# ╔═╡ 8947fe86-43e9-4e41-aa4f-ca94609bb0d0
vspace

# ╔═╡ a68f123b-1b3e-4e23-b6cc-6cd3720af4e5
md"""
5. Use indexing to select the returns of Stock A and Stock B in the 2nd and 3rd period (_Hint: the result will be a 2-by-2 matrix._)
"""

# ╔═╡ 93b0c9bd-9c96-4b86-a37a-d0af07fdea49


# ╔═╡ 41833092-2471-4feb-b2e9-307b4f887484
vspace

# ╔═╡ 86aa963e-0012-4054-b4f3-9e205810f5da
md"""
6. Use broadcasting to convert the returns from percentages to decimals.
"""

# ╔═╡ 38738b9f-b783-4bbc-8f00-770b5fefcc25


# ╔═╡ f6de9850-a1b3-4311-b059-601e59084af1
md"""
- We can also do this using an anonymous function.
"""

# ╔═╡ 15c3464e-84be-480c-b7f8-b1ac9af41598


# ╔═╡ fcc5e494-b6a1-47eb-98ce-b8a402f27df0
vspace

# ╔═╡ 1ef48a51-802f-4256-92f8-92460fc75d92
md"""
7. Use an anonymous function to convert the returns to log returns. Recall that log returns are calculated from arithmetic returns $r$ using $\log(1+r)$ (where $r$ is a decimal number).
"""

# ╔═╡ 62b26327-972f-448e-8aa3-d3a93e6fe591


# ╔═╡ 8888112b-4fab-4aba-bef2-a5f2bfd39db2
md"""
- Using the `map` function.
"""

# ╔═╡ e053bdee-c29a-48a6-8d7a-a2d101ea86a2


# ╔═╡ dadc0dbe-ce9c-4285-b26c-fb64a80923d2
vspace

# ╔═╡ 5a4d3d4f-83f2-41c9-a19f-9c1ff1cb7b60
md"""
## Comprehensions
"""

# ╔═╡ 1f4d07cc-38cf-4104-8085-e7ee9ef9d5e9
md"""
- It is often useful to use a comprehension as a basic programming construct.
- A typical form of a comprehension is: `[f(x) for x in A]`
"""

# ╔═╡ 1f5bddba-d4ad-4e23-938d-8ce9fee736b1
vspace

# ╔═╡ 7b6c4d93-8cc7-4821-bd3e-dc3369c46086
md"""
- For example, say we want to create a vector of squares from 1 to 100.
"""

# ╔═╡ b748c58b-1484-4060-9b49-502b298152fb


# ╔═╡ 6aa79928-1a44-4baa-bd42-f229c4687076
vspace

# ╔═╡ 9c3b32a2-2cef-4af8-8906-c80afab33a40
md"""
- We can also use multiple inputs
"""

# ╔═╡ 28e29d50-66ac-46ba-bb2b-1039b4fa2d4d


# ╔═╡ 46f730ea-eeef-4bf5-add7-1338649e0e3d
vspace

# ╔═╡ 0d49845b-dc0d-4a80-9bd2-496cc6abc92d
md"""
- And conditionals.
"""

# ╔═╡ 09e409ab-d985-49ee-9005-88e0546ab767


# ╔═╡ 7b5d928f-b21b-45d8-9afe-623f8b863998
vspace

# ╔═╡ 1727c427-af26-42a7-bc58-f0b1f74eb994
md"""
#### Exercise

We would like to model a type of annuity. This annnuity pays \$75 after 1 year, then \$100 after 2 years, \$125 after 3 years, etc., and has a final payment of \$300 after 10-years. Use a comprehension to create the cash flows of this annuity.
"""

# ╔═╡ 3b94d326-2901-4e06-9ecb-6232df4f0a22


# ╔═╡ 17e49a9d-064a-4826-af47-8aabf7c6b984
vspace

# ╔═╡ 49c44c27-bc74-42ca-ac14-a916c9b71723
md"""
## Matrix Iteration
"""

# ╔═╡ 328e958b-2acb-41cf-beda-85e6c04807fb
md"""
- There are some handy functions to iterate over matrices.
- `eachcol`: iterates over an array column first.
- `eachrow`: iterates over an array row first.
"""

# ╔═╡ a85da6f5-ee7c-4f44-9db0-7c406f1bcf80
md"""
- Example with `eachcol`
"""

# ╔═╡ 30bf2b50-0703-42d7-a591-050530b655fd
let


end


# ╔═╡ 3fb3fc36-f018-42af-896e-1a804878e97c
vspace

# ╔═╡ 545fbc71-4d7a-4991-8f5f-6b587926f536
md"""
#### Exercise
Use matrix iteration to put the returns of Stock B (for all periods) into a vector.
"""

# ╔═╡ 5df6cf88-c6bf-4750-9e44-928dd9cb4fa0


# ╔═╡ f4535587-3ac3-4d6d-a3d3-b867d946e583
vspace

# ╔═╡ 94338483-74a1-478a-badc-84431f8dfe45
md"""
- Example with `eachrow`
"""

# ╔═╡ 358fbc00-485f-4f21-ab7c-a2f431fef8b5
let


end


# ╔═╡ 47243e2a-67a1-4c05-bf28-0f056eb2c908
vspace

# ╔═╡ 3a665412-3b74-4488-ac63-2f5a21898960
md"""
#### Exercise
Use matrix iteration to put the returns of Stock A and Stock B in the first period into a vector.
"""

# ╔═╡ 913daa13-7547-4dd4-8bf5-74f4ded92a9f


# ╔═╡ a62e8e7a-01bc-446e-b9c5-7db3faad8109
vspace

# ╔═╡ a124bf84-7ca4-40c8-8607-b05dec24a730
md"""
## Wrap-Up
"""

# ╔═╡ 75672e0c-5c34-44c8-b1a9-f6ba821d6c8d
begin
	html"""
	<fieldset>      
    <legend><b>Learning Objectives</b></legend>      
	<br>
	<input type="checkbox" value="" checked> Broadcasting Operators and Functions
	<br>
	<input type="checkbox" value="" checked> Comprehensions
	<br>
	<input type="checkbox" value="" checked> Iteration over Matrices
	<br>
	<br>
	</fieldset>      
	"""
end

# ╔═╡ 5f191192-bc5f-41e8-845c-beba89ee5841
vspace

# ╔═╡ cddc45e1-7547-4d34-bc12-b08a5320a62c
# ╠═╡ show_logs = false
begin

	using PlutoUI, Printf, LaTeXStrings, HypertextLiteral

	using Pkg
	#Pkg.upgrade_manifest()
	#Pkg.update()
	Pkg.resolve()
	
	
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
PlutoUI = "~0.7.49"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.2"
manifest_format = "2.0"
project_hash = "175814f69ce3389834f82748cefa8e3e8988970e"

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
git-tree-sha1 = "eba4810d5e6a01f612b948c9fa94f905b49087b0"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.60"

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
# ╟─57cb0c12-e132-43f4-8d8a-1cb6149b0963
# ╟─d7513630-1d64-4ef6-a417-7d7d65f888f1
# ╟─ab6ac8d0-6d8a-11ed-0400-1b357312718e
# ╟─42d2dc69-c5e8-4cb8-809b-19cae75e479d
# ╟─6ce01efd-8846-4c63-b41d-dbd2bea213b1
# ╟─cc7cbf20-9ab5-41e1-967a-f426183246a5
# ╟─72eaafb9-4130-43fa-b2c5-536509aa5bd5
# ╠═c5568d49-9a87-4224-bdf5-4365d77a44e4
# ╠═93ea5c80-8dc9-42f7-860a-09a797ae4047
# ╟─422dd2fc-9103-4fab-8e0a-e5026c7c221e
# ╟─fb14b35e-894f-4212-85e0-cbc15b029699
# ╠═c772d04b-c584-45b0-8935-b8c643fa19b3
# ╟─24be1cc2-e132-477f-92dc-5defe2d3de4b
# ╟─c671e317-3d47-4f33-a7a8-3e0389d3b883
# ╠═03e8d7c3-e992-42e8-a9cf-b2051011b13e
# ╠═391a757b-6cfc-4416-8e32-eec931912401
# ╟─6433fafe-c644-4cc1-b882-6ec52764ea91
# ╟─bc381236-8532-4cf9-8224-5b6cdef25bbb
# ╠═f80aa11f-6246-4d36-92e3-8673b07e3d11
# ╠═e21e99b0-507c-461d-8219-71c703f9f163
# ╟─80402620-7794-44f3-b31d-5d33e64995e1
# ╟─51a6042d-3999-423a-ac54-71ed9d856474
# ╠═e7d168d6-6dd1-4329-80cc-51f8598ce49b
# ╟─ce4b785d-3f14-4604-aed2-8a7b273d1452
# ╟─0cd00220-5d3b-470d-8939-0548f4202e29
# ╠═fb47f483-903a-4cac-8663-54078cd3303a
# ╟─9dcfab70-ae04-40a2-b0e8-1d82c946685b
# ╟─e74f4ca0-b66a-47c4-9c17-da6991242a91
# ╠═f831111c-79aa-4b41-9363-7441a54a8a7d
# ╟─46d00ed5-a2bd-467a-b398-687487945770
# ╟─0ad97376-cf1e-4cc8-a2a1-c15240ed7397
# ╠═84811113-a003-484a-8eed-03bd40c23120
# ╟─8947fe86-43e9-4e41-aa4f-ca94609bb0d0
# ╟─a68f123b-1b3e-4e23-b6cc-6cd3720af4e5
# ╠═93b0c9bd-9c96-4b86-a37a-d0af07fdea49
# ╟─41833092-2471-4feb-b2e9-307b4f887484
# ╟─86aa963e-0012-4054-b4f3-9e205810f5da
# ╠═38738b9f-b783-4bbc-8f00-770b5fefcc25
# ╟─f6de9850-a1b3-4311-b059-601e59084af1
# ╠═15c3464e-84be-480c-b7f8-b1ac9af41598
# ╟─fcc5e494-b6a1-47eb-98ce-b8a402f27df0
# ╟─1ef48a51-802f-4256-92f8-92460fc75d92
# ╠═62b26327-972f-448e-8aa3-d3a93e6fe591
# ╟─8888112b-4fab-4aba-bef2-a5f2bfd39db2
# ╠═e053bdee-c29a-48a6-8d7a-a2d101ea86a2
# ╟─dadc0dbe-ce9c-4285-b26c-fb64a80923d2
# ╟─5a4d3d4f-83f2-41c9-a19f-9c1ff1cb7b60
# ╟─1f4d07cc-38cf-4104-8085-e7ee9ef9d5e9
# ╟─1f5bddba-d4ad-4e23-938d-8ce9fee736b1
# ╟─7b6c4d93-8cc7-4821-bd3e-dc3369c46086
# ╠═b748c58b-1484-4060-9b49-502b298152fb
# ╟─6aa79928-1a44-4baa-bd42-f229c4687076
# ╟─9c3b32a2-2cef-4af8-8906-c80afab33a40
# ╠═28e29d50-66ac-46ba-bb2b-1039b4fa2d4d
# ╟─46f730ea-eeef-4bf5-add7-1338649e0e3d
# ╟─0d49845b-dc0d-4a80-9bd2-496cc6abc92d
# ╠═09e409ab-d985-49ee-9005-88e0546ab767
# ╟─7b5d928f-b21b-45d8-9afe-623f8b863998
# ╟─1727c427-af26-42a7-bc58-f0b1f74eb994
# ╠═3b94d326-2901-4e06-9ecb-6232df4f0a22
# ╟─17e49a9d-064a-4826-af47-8aabf7c6b984
# ╟─49c44c27-bc74-42ca-ac14-a916c9b71723
# ╟─328e958b-2acb-41cf-beda-85e6c04807fb
# ╟─a85da6f5-ee7c-4f44-9db0-7c406f1bcf80
# ╠═30bf2b50-0703-42d7-a591-050530b655fd
# ╟─3fb3fc36-f018-42af-896e-1a804878e97c
# ╟─545fbc71-4d7a-4991-8f5f-6b587926f536
# ╠═5df6cf88-c6bf-4750-9e44-928dd9cb4fa0
# ╟─f4535587-3ac3-4d6d-a3d3-b867d946e583
# ╟─94338483-74a1-478a-badc-84431f8dfe45
# ╠═358fbc00-485f-4f21-ab7c-a2f431fef8b5
# ╟─47243e2a-67a1-4c05-bf28-0f056eb2c908
# ╟─3a665412-3b74-4488-ac63-2f5a21898960
# ╠═913daa13-7547-4dd4-8bf5-74f4ded92a9f
# ╟─a62e8e7a-01bc-446e-b9c5-7db3faad8109
# ╟─a124bf84-7ca4-40c8-8607-b05dec24a730
# ╟─75672e0c-5c34-44c8-b1a9-f6ba821d6c8d
# ╟─5f191192-bc5f-41e8-845c-beba89ee5841
# ╟─cddc45e1-7547-4d34-bc12-b08a5320a62c
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
