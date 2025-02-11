### A Pluto.jl notebook ###
# v0.19.9

using Markdown
using InteractiveUtils

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
	<p align=center style="font-size:25px; font-family:family:Georgia"> <b> Empirical Data Analysis using DataFrames </b> <p>
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

# ╔═╡ f7428550-fe1b-4749-ad1d-6810f7f136c1
vspace

# ╔═╡ fcdb31f2-3f46-4959-99ef-5e1a2185dbf7
begin
html"""
<fieldset>      
<legend>Goals for today</legend>      
<br>
  <input type="checkbox" value="">Download datasets from online sources.<br>
  <input type="checkbox" value="">Know techniques to analyze cross-sectional data (groupe data, compute summary statistics by group, apply functions by group, etc.)<br>
<br>
</fieldset>      
"""
end

# ╔═╡ 83806080-8c00-11ec-0f46-01e9cff3af6f
md"""
*Note: The objective of this lecture is to give you an overview of how we can work with tabular data in Julia. This means that we will go over many things but will not discuss them deeply. The next lectures will provide a much-more in depth coverage of the topics covered here.*

*This material is adapted from the workshop by Bogumił Kamiński titled  "JuliaCon 2021: DataFrames.jl 1.3 tutorial for Julia 1.7" and available on [Github](https://github.com/bkamins/JuliaCon2021-DataFrames-Tutorial)*

"""

# ╔═╡ 7cb5b824-d3e6-4f95-9d42-850d7a8cc646
vspace

# ╔═╡ a741f424-3d49-4ce0-89ab-bd2bc43adf49
md"""
Load packages
"""

# ╔═╡ 289ed25b-514c-4edf-8c5e-154914805786
# ╠═╡ show_logs = false
begin
	import Downloads
	using CategoricalArrays
	using Chain
	using CSV
	using DataFrames
	using Statistics
end

# ╔═╡ 79492b84-0939-45cf-8db9-d2965827b103
md"""
# Labor Force Participation Data
- We will work with the classic labor force participation dataset available here: [Link](https://vincentarelbundock.github.io/Rdatasets/doc/Ecdat/Participation.html).
  - *Reference: Gerfin, Michael (1996) “Parametric and semiparametric estimation of the binary response”, Journal of Applied Econometrics, 11(3), 321-340.*
"""

# ╔═╡ e7c90505-32b1-4be0-8314-639ff27bcb49
md"""
- We first download the file to our working directory. To do this, we use the `Downloads` module.
  - To find out what our working directory is, we can use the `pwd()` command.
"""

# ╔═╡ 84c2afed-1110-423d-88bc-9553071c68e3


# ╔═╡ 1cb09d8c-a575-42a0-9354-c23013622ac0
md"""
- Let's now download the dataset and save it as a .csv file.
"""

# ╔═╡ 61aa2ea3-46a6-4c43-8c71-7733cd4b19b4
begin
	file = "https://vincentarelbundock.github.io/Rdatasets/csv/Ecdat/Participation.csv"
	
end

# ╔═╡ 78c749ee-29d1-46f7-9669-e373d4057f5c
md"""
- Next, let's take a glimpse at the raw data.
- We can read the data line-by-line using `readlines(filename)`.
"""

# ╔═╡ 65dceb93-7d78-43dd-b23f-07fd0547df30


# ╔═╡ 89fe8bb4-1425-43ab-b954-c15caec3394e
md"""
- Now, having a sense of the data, let's load it into a DataFrame
"""

# ╔═╡ 08af723b-546b-4926-9101-a932aa2a503f


# ╔═╡ b75492aa-47f1-45ba-8973-9ec1fb296704
md"""
- Next, let's check what the dataset contains. 
- Based on the data description on the source webpage, we expect:
  - lfp: labour force participation 
  - lnnlinc: the log of nonlabour income
  - age: age in years divided by 10
  - educ: years of formal education
  - nyc: the number of young children (younger than 7)
  - noc: number of older children
  - foreign: foreigner
"""

# ╔═╡ 9cba5972-a03e-4c05-9678-dd491ab035cb
md"""
- We can get a description of the variables in the dataset using `describe()`
"""

# ╔═╡ f736bbef-035b-4c82-84f6-18a017076f84


# ╔═╡ eccf7f7d-58ea-4b7a-9fae-f67271fa8066
md"""
- We notice that some variables are not of the correct type. 
  - lfp is a string, instead of a categorical/binary variable.
  - foreign is a string, instead of a categorical variable.

"""

# ╔═╡ 812d56e9-e2a6-48de-b93a-a8533a778a04
md"""
- Now, we transform the data set by using the `select` function and perform the following transformations:
  - recode :lfp variable from text to binary.
  - change :foreign column to be categorical.
  - all other columns are left as they are.
"""

# ╔═╡ 0af12f33-7edb-4682-a322-243321a41ea7
md"""
- Recall that the general syntax for column transformations is:
  - `source columns => transformation => target columns name` 


"""

# ╔═╡ d4fab46d-40ba-4027-865c-399596563932
md"""
- Note that we applied a new "wrapper" function, `ByRow()`. 
- This is because `select` operates on entire colums by default.
- The `ByRow()` wrapper tells `select` to perform the operation row-wise.
"""

# ╔═╡ 0a4e500b-1e0d-49b7-bd5a-acbbe03cf9f9


# ╔═╡ 4046c2e8-b240-4dfe-abb0-0cbfec5e358b
md"""
- Let's now check the summary statistics again.
"""

# ╔═╡ aa30b527-30f3-4c1f-b374-cfaf693aa70e


# ╔═╡ 896ab261-6860-4351-9854-f750060584a0
vspace

# ╔═╡ 1053961b-f8ae-428f-a305-556a67686967
md"""
- An alternative way to change a DataFrame is to use `transform`.
"""

# ╔═╡ 9b2fa057-d8b6-4090-bd9d-d78b8d16d658


# ╔═╡ 26a92ab1-642e-4bdd-aa04-4fdc299e4fcf
vspace

# ╔═╡ 965946dd-6308-493f-b412-d8b2a8107a45
md"""
# Exploratory Data Analysis
"""

# ╔═╡ 1e55aabe-fffb-4c34-ab6a-847996165b10
md"""
- We are now ready to explore the data.
- To begin, let's compute the mean of numeric columns by the value :lfp to initialy check in what direction they influence the target (i.e. labor force participation).
"""

# ╔═╡ f001c6c6-566a-4063-b369-08d2d249378a
md"""
- To do this, we will use the `Chain.jl` package.
- In addition, we also revisit how we goup data.
"""

# ╔═╡ 320f862b-9361-46e9-98d2-c591bd25cc45
md"""
- Specifically,  
  - the `@chain` macro from the `Chain.jl` package allows for convenient *piping* of operations.
    - Note that we load this package at the top by typing `using Chain`.
  - the `groupby` function groups the DataFrame by the passed column (basically, it adds a key column to the data frame).
  - the `combine` function that combines the rows of a data frame by some function
"""

# ╔═╡ 8212cbcd-4755-48bd-abae-c4923e6920c9


# ╔═╡ 69db7d0c-c9c3-46fd-b678-dce3030150e4
md"""
- Let's understand what is going on in the last Pluto cell.
- To begin, let's consider the transformation in combine.

`[:lnnlinc, :age, :educ, :nyc, :noc] .=> mean`

   - this is a convenient way to specify *multiple* similar transformations using the broadcasting syntax.
"""

# ╔═╡ 73fd420b-6ecd-4e27-9f67-76e65e848bd6
md"""
- If we did not want to list all the columns manually we could have written (note that :lfp was included as it is binary):
"""

# ╔═╡ da0ae244-dc0f-47d7-9ea9-b6f9b64abc81


# ╔═╡ fdad70e5-c5ca-4773-b852-20a1f69ff190
md"""
- In the previous Pluto cell the `names(df,Real)` takes all the column names, but keeps only numeric columns.
"""

# ╔═╡ 68630364-7add-41af-8fb3-f66bf403d9d4
md"""
- Now, let's take the categorical variable `:foreign` and tabulate `lfp` and `foreign`.
"""

# ╔═╡ 0e6c6fd5-a4d6-494d-acdc-0aae30c46bc4


# ╔═╡ bf19dc6b-5b61-473b-9654-87e020ddb9cb
md"""
- Next, if we want to create a cross-tabulation of the data we can put:
  - the `:lfp` variable as rows,
  - the `:foreign` variable as columns,
  - the `:nrow` variable as values,
    - Note: `nrow` is simply the number of rows with (lfp,foreign) combinations.
"""

# ╔═╡ b130b35e-f270-49e9-9b71-1284d91d36a7


# ╔═╡ 2053fb13-d922-448c-9766-9c04e80a1933
md"""
- Finally let us add another step to our `@chain`, which will create a fraction of `:yes` answers in each group.
"""

# ╔═╡ f1c535a8-4faf-453c-b207-7254a5fe5d25


# ╔═╡ b8b26c20-b69c-4a55-b6a7-807367c0e8b1
md"""
- Let's understand what is happening in the last Pluto cell.
- Note that in this example we pass more than one column to a transformation function.
  - This is done using `[:no,:yes] => ByRow( (x,y) -> ...)`
  - We have used this concept before in our Tabular Data lecture.
"""

# ╔═╡ eb636545-bcc1-4ed0-ac68-9aaa6e0b2b97
md"""
- What happens when we are grouping data using `groupby`?
- A `GroupedDataFrame` is created by the groupby function 
- This can be a useful object to work with on its own.
- Let's illustrate this.
"""

# ╔═╡ 20357f8b-cf7a-4011-83eb-a2b1172d8f65


# ╔═╡ 8b31d6ed-3570-4eb1-98b8-d45d2bb987a4
md"""
- A nice thing is that we can conveniently index into it to get the groups.
- First, let's use the standard indexing syntax to get the first group.
"""

# ╔═╡ 9c4480c4-9aae-4a1a-ba8f-f4ee9e72e819


# ╔═╡ 37ae597a-b6cc-4d50-95b1-8549c29554ea
md"""
- There is an alternative way, which might be more intuitive.
- Specifically, we can use special indexing syntax that efficiently selects groups by their *value* (not position).
"""

# ╔═╡ 240f9da5-b9b6-4be5-839d-273d5088ab8d


# ╔═╡ 721a8092-9820-4bc4-a312-fa39345a6f02
md"""
- Anther way is using `Dicts`.
"""

# ╔═╡ 208cbadf-92b7-414f-8966-2c25a61584c3


# ╔═╡ b68a17d2-a3e7-4379-a441-1ca20a8970c5
vspace

# ╔═╡ 43bfb2aa-f225-41be-b5c4-8ab88237fa7a
md"""
# Wrap-Up
"""

# ╔═╡ e3ec2296-6622-4aac-a42c-846d826448f8
begin
html"""
<fieldset>      
<legend>Goals for today</legend>      
<br>
<input type="checkbox" value=""checked>Download datasets from online sources.<br>
   <input type="checkbox" value="" checked>Know techniques to analyze cross-sectional data (groupe data, compute summary statistics by group, apply functions by group, etc.)<br><br>      

</fieldset>      
"""
end

# ╔═╡ 22934d73-3ad2-4e44-8a54-3b3ab6cea1a1
vspace

# ╔═╡ 35e6b686-2daa-40f6-b348-6987406ba95b
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
CategoricalArrays = "324d7699-5711-5eae-9e2f-1d82baa6b597"
Chain = "8be319e6-bccf-4806-a6f7-6fae938471bc"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Downloads = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Logging = "56ddb016-857b-54e1-b83d-db4d58db5568"
Pkg = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[compat]
CSV = "~0.10.2"
CategoricalArrays = "~0.10.2"
Chain = "~0.4.10"
DataFrames = "~1.3.2"
HypertextLiteral = "~0.9.4"
LaTeXStrings = "~1.3.0"
PlutoUI = "~0.7.34"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.2"
manifest_format = "2.0"
project_hash = "caeae0876893685744311247bce91c151d4935ec"

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

[[deps.CategoricalArrays]]
deps = ["DataAPI", "Future", "Missings", "Printf", "Requires", "Statistics", "Unicode"]
git-tree-sha1 = "1568b28f91293458345dabba6a5ea3f183250a61"
uuid = "324d7699-5711-5eae-9e2f-1d82baa6b597"
version = "0.10.8"

    [deps.CategoricalArrays.extensions]
    CategoricalArraysJSONExt = "JSON"
    CategoricalArraysRecipesBaseExt = "RecipesBase"
    CategoricalArraysSentinelArraysExt = "SentinelArrays"
    CategoricalArraysStructTypesExt = "StructTypes"

    [deps.CategoricalArrays.weakdeps]
    JSON = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
    RecipesBase = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
    SentinelArrays = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
    StructTypes = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"

[[deps.Chain]]
git-tree-sha1 = "339237319ef4712e6e5df7758d0bccddf5c237d9"
uuid = "8be319e6-bccf-4806-a6f7-6fae938471bc"
version = "0.4.10"

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
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "db2a9cb664fcea7836da4b414c3278d71dd602d2"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.3.6"

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

[[deps.Formatting]]
deps = ["Logging", "Printf"]
git-tree-sha1 = "fb409abab2caf118986fc597ba84b50cbaf00b87"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.3"

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
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "dfb54c4e414caa595a1f2ed759b160f5a3ddcba5"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.3.1"

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

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

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
# ╟─d7e2e472-6aae-4d12-ab51-d8ed83a2d201
# ╟─822f9a29-2599-4ad6-8902-ad9cc3aab263
# ╟─f7428550-fe1b-4749-ad1d-6810f7f136c1
# ╟─fcdb31f2-3f46-4959-99ef-5e1a2185dbf7
# ╟─83806080-8c00-11ec-0f46-01e9cff3af6f
# ╟─7cb5b824-d3e6-4f95-9d42-850d7a8cc646
# ╟─a741f424-3d49-4ce0-89ab-bd2bc43adf49
# ╠═289ed25b-514c-4edf-8c5e-154914805786
# ╟─79492b84-0939-45cf-8db9-d2965827b103
# ╟─e7c90505-32b1-4be0-8314-639ff27bcb49
# ╠═84c2afed-1110-423d-88bc-9553071c68e3
# ╟─1cb09d8c-a575-42a0-9354-c23013622ac0
# ╠═61aa2ea3-46a6-4c43-8c71-7733cd4b19b4
# ╟─78c749ee-29d1-46f7-9669-e373d4057f5c
# ╠═65dceb93-7d78-43dd-b23f-07fd0547df30
# ╟─89fe8bb4-1425-43ab-b954-c15caec3394e
# ╠═08af723b-546b-4926-9101-a932aa2a503f
# ╟─b75492aa-47f1-45ba-8973-9ec1fb296704
# ╟─9cba5972-a03e-4c05-9678-dd491ab035cb
# ╠═f736bbef-035b-4c82-84f6-18a017076f84
# ╟─eccf7f7d-58ea-4b7a-9fae-f67271fa8066
# ╟─812d56e9-e2a6-48de-b93a-a8533a778a04
# ╟─0af12f33-7edb-4682-a322-243321a41ea7
# ╟─d4fab46d-40ba-4027-865c-399596563932
# ╠═0a4e500b-1e0d-49b7-bd5a-acbbe03cf9f9
# ╟─4046c2e8-b240-4dfe-abb0-0cbfec5e358b
# ╠═aa30b527-30f3-4c1f-b374-cfaf693aa70e
# ╟─896ab261-6860-4351-9854-f750060584a0
# ╟─1053961b-f8ae-428f-a305-556a67686967
# ╠═9b2fa057-d8b6-4090-bd9d-d78b8d16d658
# ╟─26a92ab1-642e-4bdd-aa04-4fdc299e4fcf
# ╟─965946dd-6308-493f-b412-d8b2a8107a45
# ╟─1e55aabe-fffb-4c34-ab6a-847996165b10
# ╟─f001c6c6-566a-4063-b369-08d2d249378a
# ╟─320f862b-9361-46e9-98d2-c591bd25cc45
# ╠═8212cbcd-4755-48bd-abae-c4923e6920c9
# ╟─69db7d0c-c9c3-46fd-b678-dce3030150e4
# ╟─73fd420b-6ecd-4e27-9f67-76e65e848bd6
# ╠═da0ae244-dc0f-47d7-9ea9-b6f9b64abc81
# ╟─fdad70e5-c5ca-4773-b852-20a1f69ff190
# ╟─68630364-7add-41af-8fb3-f66bf403d9d4
# ╠═0e6c6fd5-a4d6-494d-acdc-0aae30c46bc4
# ╟─bf19dc6b-5b61-473b-9654-87e020ddb9cb
# ╠═b130b35e-f270-49e9-9b71-1284d91d36a7
# ╟─2053fb13-d922-448c-9766-9c04e80a1933
# ╠═f1c535a8-4faf-453c-b207-7254a5fe5d25
# ╟─b8b26c20-b69c-4a55-b6a7-807367c0e8b1
# ╟─eb636545-bcc1-4ed0-ac68-9aaa6e0b2b97
# ╠═20357f8b-cf7a-4011-83eb-a2b1172d8f65
# ╟─8b31d6ed-3570-4eb1-98b8-d45d2bb987a4
# ╠═9c4480c4-9aae-4a1a-ba8f-f4ee9e72e819
# ╟─37ae597a-b6cc-4d50-95b1-8549c29554ea
# ╠═240f9da5-b9b6-4be5-839d-273d5088ab8d
# ╟─721a8092-9820-4bc4-a312-fa39345a6f02
# ╠═208cbadf-92b7-414f-8966-2c25a61584c3
# ╟─b68a17d2-a3e7-4379-a441-1ca20a8970c5
# ╟─43bfb2aa-f225-41be-b5c4-8ab88237fa7a
# ╟─e3ec2296-6622-4aac-a42c-846d826448f8
# ╟─22934d73-3ad2-4e44-8a54-3b3ab6cea1a1
# ╟─35e6b686-2daa-40f6-b348-6987406ba95b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
