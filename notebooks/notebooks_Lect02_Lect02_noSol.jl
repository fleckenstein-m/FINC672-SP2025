### A Pluto.jl notebook ###
# v0.19.9

using Markdown
using InteractiveUtils

# ╔═╡ 9e741225-0a6a-475e-a2d8-c4bae2fb2612
html"""
	<p align=left style="font-size:32px; font-family:family:Georgia"> <b> FINC 672: Workshop in Finance - Empirical Methods</b> <p>
	"""

# ╔═╡ 28d4a3e8-241f-4bf2-9eaf-b786ae43cecd
begin 
	html"""
	<p style="padding-bottom:1cm"> </p>
	<div align=center style="font-size:25px; font-family:family:Georgia"> FINC-672: Workshop in Finance - Empirical Methods </div>
	<p style="padding-bottom:1cm"> </p>
	<p align=center style="font-size:25px; font-family:family:Georgia"> <b> Julia Data Structures I</b> <p>
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

# ╔═╡ 4cd6b6f1-58c6-4579-b2fe-fc30e2f8e63b
vspace

# ╔═╡ 42d2dc69-c5e8-4cb8-809b-19cae75e479d
begin
	html"""
	<fieldset>      
    <legend><b>Learning Objectives</b></legend>      
	<br>
	<input type="checkbox" value=""> Array, Vector
	<br>
	<input type="checkbox" value=""> Array Inspection
	<br>
	<input type="checkbox" value=""> Concatenation
	<br>
	<input type="checkbox" value=""> Indexing, Slicing
	<br>
	<input type="checkbox" value=""> Array Manipulation
	<br>
	<br>
	</fieldset>      
	"""
end

# ╔═╡ 8128e86e-06fa-4064-a22a-51457d7f1994
vspace

# ╔═╡ 3b735bec-07fe-42cc-903f-7be58c7d0b5c
md"""
# Arrays and Vectors
"""

# ╔═╡ a80e0671-4028-4c13-9245-ed2833b14507
md"""
- Arrays are a systematic arrangement of similar objects, usually in rows and columns.
- Let’s start with arrays types. There are several, but we will focus on two.
  - `Vector{T}`: one-dimensional array. Alias for `Array{T, 1}`.
  - `Matrix{T}`: two-dimensional array. Alias for `Array{T, 2}`.
  - For example, `Vector{Int64}` is a __Vector__  in which all elements are `Int64`s and `Matrix{Float64}` is a Matrix in which all elements are subtypes of `Float64`.
- Most of the time, especially when dealing with tabular data, we are using either one- or two-dimensional arrays.
- We can use the aliases Vector and Matrix for clear and concise syntax.
"""

# ╔═╡ 078804f9-c97a-40fc-9fd5-c7ba92e81935
vspace

# ╔═╡ 726fb7b2-fd76-4a5f-8df3-219ac81128a1
md"""
# Array Construction
"""

# ╔═╡ 71a59a18-3d2f-4eec-8da0-3ca22c422c69
md"""
- How do we construct an array? The simplest answer is to use the default constructor.
- It accepts the element type as the type parameter inside the `{}` brackets and inside the constructor you pass the element type followed by the dimensions.
- It is common to initialize vector and matrices with undefined elements by using the `undef` argument for type.
"""

# ╔═╡ 4bcf1a6e-3931-4124-b069-aec95d555ffb
vspace

# ╔═╡ 1839b7b9-8070-4605-929d-a5bbebb586be
md"""
- For example, a vector of 10 undef Float64 elements can be constructed as
"""

# ╔═╡ b2a58ad4-025a-4e76-8622-9eff84867fd8
let

end

# ╔═╡ 84c3bb84-62c1-4062-89b0-c3958c00dfc7
vspace

# ╔═╡ 933cd76a-992c-4279-b7b9-bb1aaa8c643d
md"""
- For matrices, we need to pass two dimensions arguments inside the constructor: one for rows and another for columns.
- For example, a matrix with 10 rows, 2 columns is instantiated as.
"""

# ╔═╡ 27643565-c0de-452a-a54b-fa769a4fb599
let

end

# ╔═╡ 556e7453-e960-44cc-97d1-1d9e52054e9a
vspace

# ╔═╡ 51b7e526-114d-4c59-887f-293cee6ac1e6
md"""
- We also have some syntax aliases for the most common elements in array construction.
- `zeros` for all elements being initialized to value zero.
"""

# ╔═╡ 41916a78-dd3d-481c-9eaf-e6e59ce62b7c
let
	
end

# ╔═╡ de07142f-c954-4e7c-8311-bb14c1f19f6a
vspace

# ╔═╡ 760f526d-231b-411e-ba54-4af6a7ff6128
let
	
end

# ╔═╡ 29084f06-4c3c-43f0-abdd-6e0019ca62d6
vspace

# ╔═╡ 9115d5f2-51d1-436a-b537-fc6a9ce0f29e
md"""
- `ones` for all elements being initialized to value one.
"""

# ╔═╡ 8861dedb-facc-42c6-87ab-42a623f2e0f5
let
	
end

# ╔═╡ e0d056a3-ded8-4ee9-b538-d8333290c2de
let
	
end

# ╔═╡ ebfcfe2b-a754-4102-a57d-d4201f1c533c
vspace

# ╔═╡ 02ae1f16-2fab-46da-a8d1-0b2352f63741
md"""
- For other elements we can first intantiate an array with `undef` elements and use the `fill!` function to fill all elements of an array with the desired element.
- Here’s an example with 3.14 ($\pi$).
"""

# ╔═╡ 0e651f7a-23fc-47ed-a669-fa057dd550d6
let

end

# ╔═╡ 8460e092-cb1f-4695-8a27-f405af12ef97
vspace

# ╔═╡ e6c3b951-c354-41ab-bac8-ab1d8ebb675b
md"""
- We can also create arrays with `array literals`.
- For example a 2x2 matrix of integers.
"""

# ╔═╡ 1d9439b4-81fe-4301-8d44-704fbbb7a3fb


# ╔═╡ dc687845-dde8-4fec-9a15-ad72eaf00dc9
vspace

# ╔═╡ e2aff1dd-bc55-4247-9ef5-0d179c1a9870
md"""
- Array literals also accept a type specification before the `[]` brackets.
- So, if we want the same 2x2 array as before but now as floats, we can do so.
"""

# ╔═╡ a8741df0-a2e1-4e2e-adce-53519ae6838d


# ╔═╡ 715474da-85e8-4480-ba58-27bd88def3b8
vspace

# ╔═╡ 565acb98-6298-41de-9db1-4a6941c3177e
md"""
- It also works for vect
"""

# ╔═╡ d0bf452e-92cc-4a60-a148-ad83460c8eb1


# ╔═╡ 3dcc34e1-e6eb-4d7f-a800-2fdebd6ba510
vspace

# ╔═╡ 61ce12d0-9f61-4d9b-9120-b7142f5864f5
md"""
- You can even mix and match array literals with the constructors.
"""

# ╔═╡ 492f1dbe-b100-484a-8fd5-a0691b3b2a11


# ╔═╡ c1d27a68-cf2c-4cab-a582-b9615ca18ffd


# ╔═╡ b75c1aa2-8d62-422e-b03a-a5ddcd26cd2c
vspace

# ╔═╡ cc89b355-3f75-4267-86e0-b2c760719df2
md"""
- Another example.
"""

# ╔═╡ 8a0363e3-b6ab-4a6b-9813-a5bd646d4862


# ╔═╡ d1de6e8f-ce5d-4ff7-9a18-6ad220e46997
vspace

# ╔═╡ f677c208-a001-4d21-8991-d2af09628a6f
md"""
# Array Concatenation
"""

# ╔═╡ 2b4e44bd-d162-4c5a-99f0-bf495d15edaf
md"""
- Finally, we can also create arrays with concatenation functions.
- `cat`: concatenate input arrays along a specific dimension `dims`
"""

# ╔═╡ 635cb7dc-4d35-4160-87c3-c12a5266d2e4


# ╔═╡ cc4fd98f-6435-40f4-bbe6-da792a8e641c


# ╔═╡ 103bbcbd-c30d-45d4-972a-22931d82356b
vspace

# ╔═╡ 53fa1274-229d-40af-a469-e7c19cf40425
md"""
- `vcat`: vertical concatenation, a shorthand for `cat(...; dims=1)`.
"""

# ╔═╡ 123674ab-7233-410b-ba2a-3feff99da66d


# ╔═╡ 1fbd4ffc-5aee-43b9-b4b7-205e4202b13f
md"""
- `hcat`: horizontal concatenation, a shorthand for `cat(...; dims=2)`.
"""

# ╔═╡ a159d681-a86a-45ff-8191-2e0447e54763


# ╔═╡ cfb15cd1-e7b9-490b-afea-cf86a261a92e
vspace

# ╔═╡ 343cff6e-7d4e-4ce5-bc01-a683681eb44b
md"""
# Array Inspection
"""

# ╔═╡ 7740c5cb-4523-41e1-b934-c73534ced614
md"""
- Once we have arrays, the next logical step is to inspect them.
- There are a lot of handy functions that allows the user to have an inner insight into any array.
- It is most useful to know what type of elements are inside an array.
- We can do this with `eltype`:
"""

# ╔═╡ 11789c5f-14e4-418b-9c48-457cb555577e
let 
	
end


# ╔═╡ 23aef7de-4ad3-4cd2-92d6-92f55d471116
vspace

# ╔═╡ 3df473cc-3a0f-4dcc-a449-bfd19892f530
md"""
- `size` is a little tricky.
- By default it will return a `tuple` containing the array’s dimensions.
"""

# ╔═╡ 5cbad939-364c-4fe6-8bd5-f07952dc0901
let

	
end

# ╔═╡ 02acfe7a-b91a-4a2e-a6e9-8e6c3bb71dde
vspace

# ╔═╡ 8069405a-4d69-460b-a569-42e66b3cda37
md"""
- You can get a specific dimension with a second argument to size
"""

# ╔═╡ a2e49d7a-904b-44c0-a4b5-822e16ec9dab
let

	
end


# ╔═╡ 41c299a2-9d5f-4fee-8a5d-4d9b2a03121e
vspace

# ╔═╡ 2a245bde-2f26-4611-8faf-5f88fe9d9dbb
md"""
# Array Indexing and Slicing
"""

# ╔═╡ 589f664c-02ff-412a-838f-8e6b3df6ce05
md"""
- Sometimes we want to only inspect certain parts of an array.
- This is called indexing and slicing.
- If you want a particular observation of a vector, or a row or column of a matrix, you’ll probably need to index an array.
- First, let’s create an example vector and matrix.
"""

# ╔═╡ 364d326c-c6d7-4160-b62d-c38f9ddf5355
vspace

# ╔═╡ b64631c0-9cec-4db4-a4b7-9e05cab1e1bf


# ╔═╡ 326c4fe6-27e1-4686-8668-ed5004a36fcc


# ╔═╡ 121f44c8-b81a-4b98-8b14-244636f25b42
vspace

# ╔═╡ 1d951c8d-d097-4dc2-b3a6-57de39d009c1
md"""
!!! attention
    - Note that because we did not use a `let`-`end` block, `my_example_vector` and `my_example_matrix` can be accessed from all cells.
    - We do not have to define them again, but for this notebook we can only define them __once__.
"""

# ╔═╡ 996a86e9-fc64-47e6-b17d-c47637b4f37f
vspace

# ╔═╡ 175e936c-089b-447f-8a32-a4e050edd0ad
md"""
- Let’s see first an example with vectors.
- Suppose you want the second element of a vector.
- You append `[]` brackets with the desired index inside.
"""

# ╔═╡ eda6d22e-06ed-4bbc-81cf-84c92cb007b3


# ╔═╡ efb24862-cc37-4441-8c53-6c9743cd99a7
vspace

# ╔═╡ 8677fc85-1733-4db9-98c6-46e534ac0222
md"""
- The same syntax follows with matrices.
- But, since matrices are 2-dimensional arrays, we have to specify both rows and columns.
-  Let’s retrieve the element from the second row (first dimension) and first column (second dimension).
"""

# ╔═╡ 7705e84f-4f52-4316-a630-36c3e904651f


# ╔═╡ 146caa7b-49fa-4898-a44b-ecf1c0556f25
vspace

# ╔═╡ 0d0c4ee1-10ff-424f-a501-8dbf2608879f
md"""
- Julia also have conventional keywords for the first and last elements of an array: `begin` and `end`.
- For example, the second to last element of a vector can be retrieved as.
"""

# ╔═╡ b0052499-31cd-40a1-9784-9bd146ecb886


# ╔═╡ c48cc1e5-a680-44f0-ab4b-b6bf8453ba5a
vspace

# ╔═╡ 7b5759a8-d0b4-4a7b-bd84-6486e249a047
md"""
- It also works for matrices.
- Let’s retrieve the element of the last row and second column.
"""

# ╔═╡ 16d253ed-2bbc-4de1-88ed-244ba4543d00


# ╔═╡ 0815e314-b269-4efa-bc99-fdf33f9e4795
vspace

# ╔═╡ 8367611f-e81e-4d68-8203-df970700afe4
md"""
- Often, we are not only interested in just one array element, but in a whole subset of array elements.
- We can accomplish this by slicing an array. 
- It uses the same index syntax, but with the added colon `:` to denote the boundaries that we are slicing through the array.
- For example, suppose we want to get the 2nd to 4th element of a vector: 
"""

# ╔═╡ ad5b63ad-6031-40f4-bc97-94a56b3a45bc


# ╔═╡ 539120ad-0e3f-4ddb-b92f-8eb93fe06863
vspace

# ╔═╡ c55c8b22-c5cb-4af9-91da-1b5138c1681f
md"""
- We could do the same with matrices.
- Particularly with matrices if we want to select all elements in a following dimension we can do so with just a colon `:`.
- For example, all elements in the second row.
"""

# ╔═╡ e383bf0b-db35-4ff8-ac30-2aa48dd12819


# ╔═╡ 7e24e8ba-792c-4926-a686-91114be1e6f5
vspace

# ╔═╡ 69bc4ed8-11f2-4cbc-98aa-6ea5d4412274
md"""
- You can interpret this with something like "take 2nd row and all columns". 
- It also supports `begin` and `end`.
"""

# ╔═╡ b264aac2-5335-4cbb-a7b8-5889c40da920


# ╔═╡ 9948c533-4a72-4d1a-843c-e761e0aef196
vspace

# ╔═╡ 1d26ea5c-0fb5-41b4-b8d7-004f787a7a46
md"""
# Array Manipulation
"""

# ╔═╡ 9e0bad81-1e07-46c3-82fd-3b833f04ff67
md"""
- There are several ways we could manipulate an array.
- The first would be to manipulate a _single element_ of the array.
- We just index the array by the element and proceed with an assignment =
"""

# ╔═╡ df7654f1-ad75-4777-9f3b-47fd002b180d
vspace

# ╔═╡ 72f13583-b7a8-496e-875c-62ee21e38330


# ╔═╡ 70884b55-e20e-4318-8bc4-d86a8c2360a3


# ╔═╡ a18f832a-82be-4bbe-a128-3ed29cd868f9
vspace

# ╔═╡ fcb1f99a-ce24-4c58-8962-ee701a3a62f9
md"""
- Or you can manipulate a certain subset of elements of the array.
- In this case, we need to slice the array and then assign with `=`.
"""

# ╔═╡ 716be2d5-397f-4ad7-bbcf-4965fc9471cc


# ╔═╡ 88c489c8-01d8-4627-8408-852769d0a7bc


# ╔═╡ 7a072a96-3ab4-4789-b484-39fb1479eff2
vspace

# ╔═╡ 31c2c3d6-71c2-44b9-9f35-08555e403f6f
md"""
- Note that we had to assign a vector because our sliced array is of type `Vector`.
"""

# ╔═╡ 707dc086-5e28-45a5-b1f4-81236213ef6b


# ╔═╡ 7d2d869b-a277-4df4-88b8-e950dd4dea5d
vspace

# ╔═╡ 47cf947e-5fdd-42c4-89f8-49e30777277f
md"""
- The second way we could manipulate an array is to alter its shape. 
- Suppose you have a 6-element vector and you want to make it a 3x2 matrix.
- You can do so with reshape, by using the array as first argument and a tuple of dimensions as second argument.
"""

# ╔═╡ 3165edf3-c58d-45b6-ac5a-b20165e68ff5
let
	
end

# ╔═╡ 408a59f5-c0e9-4bd2-9fe4-3c1a54bb7cd9
vspace

# ╔═╡ 47a245c6-c39a-4e17-9484-aa13d9d2d998
md"""
- You can do the reverse, convert it back to a vector, by specifying a tuple with only one dimension as second argument.
"""

# ╔═╡ 809d848b-8ee3-4a8c-abdd-7e1d863e0260
let
	
end

# ╔═╡ 73989cbd-10c0-4b7e-94fc-59315ead56fd
vspace

# ╔═╡ 8924cea3-e558-4ecc-8181-148f70a216a3
md"""
- The third way we could manipulate an array is to apply a function over every array element.
- This is where the familiar broadcasting "dot" operator `.` comes in.
"""

# ╔═╡ 7bd7abab-b16d-4017-80e9-cd0e9c714a07


# ╔═╡ cfbf12f4-b6b5-487c-81d7-beab3c3d9841
vspace

# ╔═╡ a124bf84-7ca4-40c8-8607-b05dec24a730
md"""
# Wrap-Up
"""

# ╔═╡ 75672e0c-5c34-44c8-b1a9-f6ba821d6c8d
begin
	html"""
	<fieldset>      
    <legend><b>Learning Objectives</b></legend>      
	<br>
	<input type="checkbox" value="" checked> Array, Vector
	<br>
	<input type="checkbox" value="" checked> Array Inspection
	<br>
	<input type="checkbox" value="" checked> Concatenation
	<br>
	<input type="checkbox" value="" checked> Indexing, Slicing
	<br>
	<input type="checkbox" value="" checked> Array Manipulation
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
# helper functions
	
	using PlutoUI, Printf, LaTeXStrings, HypertextLiteral

	using Pkg
	#Pkg.upgrade_manifest()
	#Pkg.update()
	#Pkg.resolve()
	
	#Define html elements
	nbsp = html"&nbsp" #non-breaking space
	vspace = html"""<div style="margin-bottom:1cm;"></div>"""
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
# ╟─9e741225-0a6a-475e-a2d8-c4bae2fb2612
# ╟─28d4a3e8-241f-4bf2-9eaf-b786ae43cecd
# ╟─4cd6b6f1-58c6-4579-b2fe-fc30e2f8e63b
# ╟─42d2dc69-c5e8-4cb8-809b-19cae75e479d
# ╟─8128e86e-06fa-4064-a22a-51457d7f1994
# ╟─3b735bec-07fe-42cc-903f-7be58c7d0b5c
# ╟─a80e0671-4028-4c13-9245-ed2833b14507
# ╟─078804f9-c97a-40fc-9fd5-c7ba92e81935
# ╟─726fb7b2-fd76-4a5f-8df3-219ac81128a1
# ╟─71a59a18-3d2f-4eec-8da0-3ca22c422c69
# ╟─4bcf1a6e-3931-4124-b069-aec95d555ffb
# ╟─1839b7b9-8070-4605-929d-a5bbebb586be
# ╠═b2a58ad4-025a-4e76-8622-9eff84867fd8
# ╟─84c3bb84-62c1-4062-89b0-c3958c00dfc7
# ╟─933cd76a-992c-4279-b7b9-bb1aaa8c643d
# ╠═27643565-c0de-452a-a54b-fa769a4fb599
# ╟─556e7453-e960-44cc-97d1-1d9e52054e9a
# ╟─51b7e526-114d-4c59-887f-293cee6ac1e6
# ╠═41916a78-dd3d-481c-9eaf-e6e59ce62b7c
# ╟─de07142f-c954-4e7c-8311-bb14c1f19f6a
# ╠═760f526d-231b-411e-ba54-4af6a7ff6128
# ╟─29084f06-4c3c-43f0-abdd-6e0019ca62d6
# ╟─9115d5f2-51d1-436a-b537-fc6a9ce0f29e
# ╠═8861dedb-facc-42c6-87ab-42a623f2e0f5
# ╠═e0d056a3-ded8-4ee9-b538-d8333290c2de
# ╟─ebfcfe2b-a754-4102-a57d-d4201f1c533c
# ╟─02ae1f16-2fab-46da-a8d1-0b2352f63741
# ╠═0e651f7a-23fc-47ed-a669-fa057dd550d6
# ╟─8460e092-cb1f-4695-8a27-f405af12ef97
# ╟─e6c3b951-c354-41ab-bac8-ab1d8ebb675b
# ╠═1d9439b4-81fe-4301-8d44-704fbbb7a3fb
# ╟─dc687845-dde8-4fec-9a15-ad72eaf00dc9
# ╟─e2aff1dd-bc55-4247-9ef5-0d179c1a9870
# ╠═a8741df0-a2e1-4e2e-adce-53519ae6838d
# ╟─715474da-85e8-4480-ba58-27bd88def3b8
# ╟─565acb98-6298-41de-9db1-4a6941c3177e
# ╠═d0bf452e-92cc-4a60-a148-ad83460c8eb1
# ╟─3dcc34e1-e6eb-4d7f-a800-2fdebd6ba510
# ╟─61ce12d0-9f61-4d9b-9120-b7142f5864f5
# ╠═492f1dbe-b100-484a-8fd5-a0691b3b2a11
# ╠═c1d27a68-cf2c-4cab-a582-b9615ca18ffd
# ╟─b75c1aa2-8d62-422e-b03a-a5ddcd26cd2c
# ╟─cc89b355-3f75-4267-86e0-b2c760719df2
# ╠═8a0363e3-b6ab-4a6b-9813-a5bd646d4862
# ╟─d1de6e8f-ce5d-4ff7-9a18-6ad220e46997
# ╟─f677c208-a001-4d21-8991-d2af09628a6f
# ╟─2b4e44bd-d162-4c5a-99f0-bf495d15edaf
# ╠═635cb7dc-4d35-4160-87c3-c12a5266d2e4
# ╠═cc4fd98f-6435-40f4-bbe6-da792a8e641c
# ╟─103bbcbd-c30d-45d4-972a-22931d82356b
# ╟─53fa1274-229d-40af-a469-e7c19cf40425
# ╠═123674ab-7233-410b-ba2a-3feff99da66d
# ╟─1fbd4ffc-5aee-43b9-b4b7-205e4202b13f
# ╠═a159d681-a86a-45ff-8191-2e0447e54763
# ╟─cfb15cd1-e7b9-490b-afea-cf86a261a92e
# ╟─343cff6e-7d4e-4ce5-bc01-a683681eb44b
# ╟─7740c5cb-4523-41e1-b934-c73534ced614
# ╠═11789c5f-14e4-418b-9c48-457cb555577e
# ╟─23aef7de-4ad3-4cd2-92d6-92f55d471116
# ╟─3df473cc-3a0f-4dcc-a449-bfd19892f530
# ╠═5cbad939-364c-4fe6-8bd5-f07952dc0901
# ╟─02acfe7a-b91a-4a2e-a6e9-8e6c3bb71dde
# ╟─8069405a-4d69-460b-a569-42e66b3cda37
# ╠═a2e49d7a-904b-44c0-a4b5-822e16ec9dab
# ╟─41c299a2-9d5f-4fee-8a5d-4d9b2a03121e
# ╟─2a245bde-2f26-4611-8faf-5f88fe9d9dbb
# ╟─589f664c-02ff-412a-838f-8e6b3df6ce05
# ╟─364d326c-c6d7-4160-b62d-c38f9ddf5355
# ╠═b64631c0-9cec-4db4-a4b7-9e05cab1e1bf
# ╠═326c4fe6-27e1-4686-8668-ed5004a36fcc
# ╟─121f44c8-b81a-4b98-8b14-244636f25b42
# ╟─1d951c8d-d097-4dc2-b3a6-57de39d009c1
# ╟─996a86e9-fc64-47e6-b17d-c47637b4f37f
# ╟─175e936c-089b-447f-8a32-a4e050edd0ad
# ╠═eda6d22e-06ed-4bbc-81cf-84c92cb007b3
# ╟─efb24862-cc37-4441-8c53-6c9743cd99a7
# ╟─8677fc85-1733-4db9-98c6-46e534ac0222
# ╠═7705e84f-4f52-4316-a630-36c3e904651f
# ╟─146caa7b-49fa-4898-a44b-ecf1c0556f25
# ╟─0d0c4ee1-10ff-424f-a501-8dbf2608879f
# ╠═b0052499-31cd-40a1-9784-9bd146ecb886
# ╟─c48cc1e5-a680-44f0-ab4b-b6bf8453ba5a
# ╟─7b5759a8-d0b4-4a7b-bd84-6486e249a047
# ╠═16d253ed-2bbc-4de1-88ed-244ba4543d00
# ╟─0815e314-b269-4efa-bc99-fdf33f9e4795
# ╟─8367611f-e81e-4d68-8203-df970700afe4
# ╠═ad5b63ad-6031-40f4-bc97-94a56b3a45bc
# ╟─539120ad-0e3f-4ddb-b92f-8eb93fe06863
# ╟─c55c8b22-c5cb-4af9-91da-1b5138c1681f
# ╠═e383bf0b-db35-4ff8-ac30-2aa48dd12819
# ╟─7e24e8ba-792c-4926-a686-91114be1e6f5
# ╟─69bc4ed8-11f2-4cbc-98aa-6ea5d4412274
# ╠═b264aac2-5335-4cbb-a7b8-5889c40da920
# ╟─9948c533-4a72-4d1a-843c-e761e0aef196
# ╟─1d26ea5c-0fb5-41b4-b8d7-004f787a7a46
# ╟─9e0bad81-1e07-46c3-82fd-3b833f04ff67
# ╟─df7654f1-ad75-4777-9f3b-47fd002b180d
# ╠═72f13583-b7a8-496e-875c-62ee21e38330
# ╠═70884b55-e20e-4318-8bc4-d86a8c2360a3
# ╟─a18f832a-82be-4bbe-a128-3ed29cd868f9
# ╟─fcb1f99a-ce24-4c58-8962-ee701a3a62f9
# ╠═716be2d5-397f-4ad7-bbcf-4965fc9471cc
# ╠═88c489c8-01d8-4627-8408-852769d0a7bc
# ╟─7a072a96-3ab4-4789-b484-39fb1479eff2
# ╟─31c2c3d6-71c2-44b9-9f35-08555e403f6f
# ╠═707dc086-5e28-45a5-b1f4-81236213ef6b
# ╟─7d2d869b-a277-4df4-88b8-e950dd4dea5d
# ╟─47cf947e-5fdd-42c4-89f8-49e30777277f
# ╠═3165edf3-c58d-45b6-ac5a-b20165e68ff5
# ╟─408a59f5-c0e9-4bd2-9fe4-3c1a54bb7cd9
# ╟─47a245c6-c39a-4e17-9484-aa13d9d2d998
# ╠═809d848b-8ee3-4a8c-abdd-7e1d863e0260
# ╟─73989cbd-10c0-4b7e-94fc-59315ead56fd
# ╟─8924cea3-e558-4ecc-8181-148f70a216a3
# ╠═7bd7abab-b16d-4017-80e9-cd0e9c714a07
# ╟─cfbf12f4-b6b5-487c-81d7-beab3c3d9841
# ╟─a124bf84-7ca4-40c8-8607-b05dec24a730
# ╟─75672e0c-5c34-44c8-b1a9-f6ba821d6c8d
# ╟─5f191192-bc5f-41e8-845c-beba89ee5841
# ╟─cddc45e1-7547-4d34-bc12-b08a5320a62c
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
