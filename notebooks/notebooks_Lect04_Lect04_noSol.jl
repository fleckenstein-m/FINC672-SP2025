### A Pluto.jl notebook ###
# v0.19.9

using Markdown
using InteractiveUtils

# ╔═╡ ea237d72-175a-40da-a35c-017d894ed8c0
html"""
	<p align=left style="font-size:32px; font-family:family:Georgia"> <b> FINC 672: Workshop in Finance - Empirical Methods</b> <p>
	"""

# ╔═╡ b71ed765-a596-45cd-9c29-cbb3d4cba1a4
html"""
	<p style="padding-bottom:1cm"> </p>
	<div align=center style="font-size:25px; font-family:family:Georgia"> FINC-672: Workshop in Finance - Empirical Methods </div>
	<p style="padding-bottom:1cm"> </p>
	<p align=center style="font-size:25px; font-family:family:Georgia"> <b> Julia Data Structures III </b> <p>
	<p style="padding-bottom:1cm"> </p>
	<p align=center style="font-size:25px; font-family:family:Georgia"> Spring 2024 <p>
	<p style="padding-bottom:0.5cm"> </p>
	<div align=center style="font-size:20px; font-family:family:Georgia"> Prof. Matt Fleckenstein </div>
	<p style="padding-bottom:0.05cm"> </p>
	<div align=center style="font-size:20px; font-family:family:Georgia"> University of Delaware, 
	Lerner College of Business and Economics </div>
	<p style="padding-bottom:0.5cm"> </p>
	"""

# ╔═╡ b3e2a1d6-70a5-402d-9219-82c280ba9328
vspace

# ╔═╡ 42d2dc69-c5e8-4cb8-809b-19cae75e479d
begin
	html"""
	<fieldset>      
    <legend><b>Learning Objectives</b></legend>      
	<br>
	<input type="checkbox" value=""> Strings
	<br>
	<input type="checkbox" value=""> String Conversions
	<br>
	<input type="checkbox" value=""> Tuples, Named Tuples
	<br>
	<input type="checkbox" value=""> Ranges
	<br>
	<br>
	</fieldset>      
	"""
end

# ╔═╡ c54e6422-2a39-4960-8332-51b98afaded6
vspace

# ╔═╡ bc94035a-795b-4d08-aab2-87519b4ffd65
md"""
# Strings
"""

# ╔═╡ 25a404ef-b21a-4d43-b87b-f4348d9bb219
md"""
- Strings are represented delimited by double quotes.
"""

# ╔═╡ 6b387a90-454d-4507-8406-4acebdff8a3d


# ╔═╡ a0a9a625-5ac0-470b-8e00-f724064bcf97
md"""
#
"""

# ╔═╡ 4f5bb727-6475-483e-8d60-9cbeed9d7822
md"""
- We can also write a multiline string
"""

# ╔═╡ 402ebee0-68b0-4318-809d-fa81d40ff243
# let 
# 	text = "
# 		This is a big multiline string.
# 		As you can see.
# 		It is still a String to Julia.
# 		"

# 	println(text)

# end

# ╔═╡ 7aef4abc-0abd-4e51-8494-2805aac60869
md"""
#
"""

# ╔═╡ cdcd1a12-3beb-4080-b76c-1976a48c6500
md"""
- But it is typically more clear to use triple quotation marks
"""

# ╔═╡ 34abd3a8-0a33-4d02-827e-d61c74ee9838
# let
# 	s = """
# 		This is a big multiline string with a nested "quotation".
# 		As you can see.
# 		It is still a String to Julia.
# 		"""
# 	println(s)
	
# end

# ╔═╡ 511862c6-c3e8-44d2-9163-06fb0e8aa63a
vspace

# ╔═╡ 66d5ad2e-7569-4d40-9e1b-f49f7f2b1955
md"""
# String Concatenation
"""

# ╔═╡ 098eafb0-8c7e-4584-b252-512d0bbb0227
md"""
- A common string operation is string concatenation.
- Suppose that you want to construct a new string that is the concatenation of two or more strings.
- This is accomplished in julia either with the `*` operator or the join function.
"""

# ╔═╡ 52c10638-14d0-4812-b54d-5879198be7dc
let

end

# ╔═╡ cad420df-583c-4cfe-94db-d01506374f9e
md"""
#
"""

# ╔═╡ 8b592c01-c988-4fb7-940e-a6628d35bceb
md"""
- As you can see, we are missing a space between hello and goodbye.
- We could concatenate an additional " " string with the *, but that would be cumbersome for more than two strings.
- That’s when the `join` function is useful.
- We just pass as arguments the strings inside the brackets `[]` and the separator.
"""

# ╔═╡ 3aa94c23-d150-4f32-b110-df92937e6981
md"""
#
"""

# ╔═╡ 7a9e7928-6d4e-40e8-b9ea-26e2eb6d3f61
let
	
	hello = "Hello"
	goodbye = "Goodbye"
	
	

end

# ╔═╡ 21fdcf6b-3958-43a5-9e22-7192361246d8
vspace

# ╔═╡ a7cf85d5-2299-4a6d-b2a0-9f70f1a5a96f
md"""
# String Interpolation
"""

# ╔═╡ 01a1c439-7022-4857-968a-5321df4a183e
md"""
- Concatenating Strings can be convoluted.
- We can be much more expressive with string interpolation.
- It works like this: you specify whatever you want to be included in your string with the dollar sign `$`.
- Here’s the example before but now using interpolation.
"""

# ╔═╡ 9daccbff-20ee-4429-a428-2a404b585f10
md"""
#
"""

# ╔═╡ c245716e-1a72-42e9-b8cc-fd65b785e968
let

	hello = "Hello"
	goodbye = "Goodbye"
	
	

end


# ╔═╡ 39a41ede-0750-471d-89b3-b2a2d4e2ce52
md"""
#
"""

# ╔═╡ 41074323-ec69-4320-b3f6-de85cc1d34c6
md"""
#### Exercise
Suppose we observe that the price of stock A is \$85.75. Create an variable called `stock_price` with value of the stock price. Then use string interpolation to display "The stock price is 85.75".
"""

# ╔═╡ d9cd0943-6573-44ac-9a25-0d5f05c9136e


# ╔═╡ 27b79bbc-ce6d-4270-8c1d-9363dbb6c35b
vspace

# ╔═╡ 7868c045-4fd9-419d-bc66-a9d14ea41c97
md"""
- It works even inside functions. Let’s create a function to illustrate the idea.
"""

# ╔═╡ c955997d-eeb5-48c6-9ab5-c85de7bef6fc
# function test_interpolated(a, b)
# 	if a < b
# 		"$a is less than $b"
# 	elseif a > b
# 		"$a is greater than $b"
# 	else
# 		"$a is equal to $b"
# 	end
# end

# ╔═╡ c01f4006-98d1-48b8-a069-22f66b856c62


# ╔═╡ e3e82a7f-263c-4b20-897c-338a740f6c6a
vspace

# ╔═╡ 657a80f5-b889-4c2f-84d3-eebdd9f28f02
md"""
# String Manipulations
"""

# ╔═╡ 3c70b4ac-087e-41cf-a38a-fd654edb6011
md"""
- There are several functions to manipulate strings in Julia. 
- We will demonstrate the most common ones.
- Also, note that most of these functions accepts a Regular Expression (RegEx) as arguments.
- We won’t cover RegEx in this course, but you are encouraged to learn about them, especially if most of your work uses textual data.
- First, let us define a string for us to work with.
"""

# ╔═╡ 189e90ac-1516-4b4d-86c0-911bfbd1db24
julia_string = "Julia is an amazing opensource programming language"

# ╔═╡ 329b6035-dcd0-4238-b428-a8448141bdfa
md"""
#
"""

# ╔═╡ 0c7bf844-59c0-4893-9c5f-40774bb61309
md"""
- `occursin`, `startswith` and `endswith`: A conditional (returns either `true` or `false`) if the first argument is a
  - substring of the second argument
  - prefix of the second argument
  - suffix of the second argument
"""

# ╔═╡ c513d589-af7d-40d0-b496-0d0de4df56c3
md"""
#
"""

# ╔═╡ 14d1d1de-458a-467b-8093-a0f63676fac2
md"""
[occursin Documentation](https://docs.julialang.org/en/v1/base/strings/#Base.occursin)
"""

# ╔═╡ 4990d1a0-30f7-4643-bd6e-39d0a642baa0


# ╔═╡ 7a4e47bb-dcaa-443e-bc90-a912221da8bb
md"""
[startswith Documentation](https://docs.julialang.org/en/v1/base/strings/#Base.startswith)
"""

# ╔═╡ ce684892-82fc-4d6a-847d-1e55bfd80296
startswith("JuliaLang", "Julia")

# ╔═╡ e4e15f0f-212a-4071-b408-46dadc0b3e8d


# ╔═╡ d4b4dbc1-ecd4-4ee8-ad34-fa83d5b65fdb
md"""
But
"""

# ╔═╡ 3adf8946-20a8-4904-86d1-50c494cc96fb


# ╔═╡ 60d8da29-d333-4a52-9c5d-a3d9509ddb6c
md"""
[endswith Documentation](https://docs.julialang.org/en/v1/base/strings/#Base.endswith)
"""

# ╔═╡ 5d121a4b-8aba-42f4-a62c-24497cfeaad2


# ╔═╡ 70054c25-f239-47e3-b5c8-30ecec5101ce


# ╔═╡ 5a019a2f-0a04-4c7e-855e-40c216de0fda
md"""
#
"""

# ╔═╡ 21c0603f-43e6-49ac-827e-6188b4bc52dc
md"""
- 2. `lowercase`, `uppercase`, `titlecase` and `lowercasefirst`.
"""

# ╔═╡ 77837a1d-16f7-4034-8c0e-6be4fc7f5b10


# ╔═╡ f5b12fba-0525-4f19-9b69-f62fc7603e08


# ╔═╡ 96802ee7-349f-4b2a-b7e5-0697b2537142


# ╔═╡ 265a4519-24c1-49c3-af86-659e451473e9


# ╔═╡ 6a9fcae9-9fa8-4209-a735-90a092514067
md"""
#
"""

# ╔═╡ 4ae96703-9ea2-4edc-bd54-1cc86a55eabc
md"""
- `split`: breaks up a string by a delimiter.
"""

# ╔═╡ fa8f864a-862c-4b4c-b755-0a7e7530ccfa


# ╔═╡ a3703ec7-844c-42ee-9aa2-bb5530db98aa
md"""
#
"""

# ╔═╡ f70b6a6f-0704-4297-9913-f8328745d9ac
md"""
- `replace`: introduces a new syntax, called the `Pair`.
"""

# ╔═╡ d8d0ceda-a5c3-4c4a-819a-f2c513afe50a


# ╔═╡ 15278a6f-d33d-43ad-a35c-d5edcd91f75f
vspace

# ╔═╡ 806c4f8f-c9fb-4920-9956-eb0e7ccf543f
md"""
# String Conversions
"""

# ╔═╡ 7e2502b8-4535-4242-b56d-2373cb0d4050
md"""
- Often, we need to convert between types in Julia.
- We can use the string function.
"""

# ╔═╡ d6a7a8f8-9bf3-4d09-a108-eddb57e2c8b2
let 
	
end

# ╔═╡ 050af10c-ba4f-422a-8aa3-8af49ca9048b
md"""
#
"""

# ╔═╡ ccc2b2e7-dbc1-4fbb-9620-951d0ff21a42
md"""
- Sometimes, we want the opposite: convert a string to a number.
- Julia has a handy function for that: `parse`.
"""

# ╔═╡ f1affb0e-c709-4d29-ab47-dbc017bc54c6


# ╔═╡ cb3c760e-16cf-4817-b8fc-bdab9f1b5e8b
md"""
#
"""

# ╔═╡ 392afdf7-68df-4227-87a0-22e88dfb3e75
md"""
- Sometimes, we want to play safe with these conversions.
- That’s when `tryparse` function steps in.
- It has the same functionality as parse but returns either a value of the requested type, or `nothing`.
- That makes `tryparse` handy when we want to avoid errors.
- Of course, you would need to deal with all those nothing values afterwards.
"""

# ╔═╡ dbcb6057-086d-4584-b961-7b6569781ffa
let
	# a = tryparse(Int64, "A very non-numeric string")
	
	# typeof(a)
end

# ╔═╡ 0522f18b-6c47-49b9-a492-19ece6d49efc
vspace

# ╔═╡ c805833e-e677-41cc-a748-b0f68e1e3098
md"""
#### Exercise
We have obtained data on stock prices, but in the data, numbers are formatted as string. Convert the stock price given below to a floating point number.
"""

# ╔═╡ 5e364de4-581a-4850-aa3c-4468418d181e


# ╔═╡ 32881d64-5939-4dc3-83ce-d3eb409229a6
vspace

# ╔═╡ e4e970b8-0bc0-4d84-a20c-171546784439
md"""
# Tuples
"""

# ╔═╡ a47c9bca-a192-4148-8968-b105243ff04b
md"""
- Julia has a data structure called `tuple`. They are really special in Julia because they are often used in relation to functions.
- A tuple is a fixed-length container that can hold multiple different types.
- A tuple is an __imutable__ object, meaning that it cannot be modified after instantiation.
- To construct a tuple, use parentheses `()` to delimitate the beginning and end, along with commas `,` as value’s delimiters.
"""

# ╔═╡ d1011108-e962-4421-bc98-28483f5f560d
md"""
#
"""

# ╔═╡ 4ad8f55a-b04c-4c98-9a91-ae7c380e5899
md"""
- Example
  - Here, we are creating a tuple with three values.
  - Each one of the values is a different type. We can access them via indexing.
"""

# ╔═╡ b7dd2983-7735-4c23-a54d-ac3aabdd0838


# ╔═╡ 892566de-1f1a-4745-8713-f0244131bc6a


# ╔═╡ 361ef513-3661-4c9a-8630-4d1e42071efe
md"""
#
"""

# ╔═╡ 2fc75d57-30e8-4c28-860c-386649436615
md"""
#
"""

# ╔═╡ 95ce5454-a3a3-430a-9bc5-74fe3b5dd48f
md"""
- `Tuples` are useful for anonymous functios.
- Specifically, when we want to pass more than one variable to an anonymous function, we use `Tuples`.
"""

# ╔═╡ 6796d442-ea72-4297-bad1-2b18e90d0d9a


# ╔═╡ 7e807618-c81a-4df0-83c3-89ea63dafbe9
md"""
#
"""

# ╔═╡ 3c03eee2-47c3-432a-8e21-783422e18c89
md"""
- Or, even more than two arguments.
"""

# ╔═╡ f5549c83-545a-4da2-841a-aaf1a2c656f3


# ╔═╡ 758c51a1-2227-47fb-80cd-8dda7b9a81e1
vspace

# ╔═╡ fff54865-2dd3-4997-b3eb-6381fcb15450
md"""
# Named Tuples
"""

# ╔═╡ d8612c9b-aa37-4eb2-a853-493d5c68dd34
md"""
- Sometimes, you want to name the values in tuples. That’s when __named tuples__ come in.
- Their functionality is pretty much same the same as tuples. they are immutable and can hold any type of value. 
- Named tuple’s construction are slightly different from tuples. 
- You have the familiar parentheses `()` and comma `,` value separator. But now you name the values.
"""

# ╔═╡ 77ba073b-e243-4f8e-827b-08f95e6981d1


# ╔═╡ a02207c9-5108-4435-8b7a-9b68ef5bb97c
md"""
#
"""

# ╔═╡ d9ed75c6-0216-4552-8a5e-b917757cc48a
md"""
- We can access a named tuple’s values via indexing like regular tuples or, alternatively, access by their names with `.`
"""

# ╔═╡ 1465ebe6-965b-45ab-8f14-2f5e341c3928


# ╔═╡ 4152dd29-da41-4f77-8991-459690a85b5b
md"""
#
"""

# ╔═╡ 017bcf97-8429-4c78-8b18-6aeb6460a609
vspace

# ╔═╡ 0c8d0fac-f204-4c87-b74f-1eb63ed1e462
md"""
#### Exercise
1. Create a named tuple to represent the paramters of the Black Scholes Formula. Suppose the stock price is P=79.97, the implied vol is σ=14%, the riskfree rate is r=5%, the strike price is K=85, and the options expires in t=0.25 years.
"""

# ╔═╡ 1fda5a07-7981-428a-a8e5-9266570d0451


# ╔═╡ 24efaa98-fb85-42a6-a5e5-47b53fbbc86d
md"""
2. Use indexing to output the  implied volatility.
"""

# ╔═╡ 4fa964ee-9226-4732-b993-f90240ee4dfe


# ╔═╡ fdbeb35f-8a8d-4f29-9ad4-e3d195cafad5
vspace

# ╔═╡ 3cf6bb82-151b-4082-9ff9-67506b74af59
md"""
# Ranges
"""

# ╔═╡ 37aee362-f7f6-4fd7-b240-e2c6da0252cd
md"""
- A range in Julia represents an interval between a start and stop boundaries.
- The syntax is `start:stop`.
"""

# ╔═╡ 07f2c7a2-4262-4f6d-bed1-171124dbd28f


# ╔═╡ efd520b0-5890-4de4-adbc-e15664b94688


# ╔═╡ 7b21ac8e-b41c-47d0-9a69-1ddfeed7da42
md"""
- As you can see, our instantiated range is of type `UnitRange{T}` where `T` is the type inside the UnitRange (`Int64` in this case).
"""

# ╔═╡ a323ff01-48f8-4e80-ac10-6b3e5a6204bc
md"""
#
"""

# ╔═╡ e90df9cb-54eb-456a-ac4e-a374d2eb3ba1
md"""
- To put all the values in the range into a vector, we use the `collect` function.
"""

# ╔═╡ 47442c7b-9c18-4e8b-96fd-0b4f472c8624


# ╔═╡ 6fdf0cc0-82ae-4dea-83f4-6da843962f4a
md"""
#
"""

# ╔═╡ bf7c9958-7100-4b32-8a45-100fe07b85b2
md"""
- We can construct ranges also for other types.
"""

# ╔═╡ 12ab5565-b56a-4fd1-8a96-cb195093570f


# ╔═╡ 2e44fbb1-3b01-442b-9165-33a27f89f7e8
md"""
#
"""

# ╔═╡ 2830ac94-b7a3-48fe-9865-aa3bd1293ecc
md"""
- Sometimes, we want to change the default interval _stepsize_ behavior.
- We can do that by adding a _stepsize_ in the range syntax `start:step:stop`.
- For example, suppose we want a range of `Float64` from 0 to 1 with steps of size 0.2.
"""

# ╔═╡ 42442364-0013-487e-b80d-47ab051f0c1b


# ╔═╡ 35678f86-dff3-4baf-ac61-22eb2aff248d
md"""
#
"""

# ╔═╡ cb5b2fe7-63aa-4fe3-a32a-e2caf6078668
md"""
- Again, we can _materialize_ a `UnitRange` into a collection by using the function `collect`.
- We have an array of the type specified in the UnitRange between the boundaries that we’ve set.
"""

# ╔═╡ 8bee3b15-811d-4c3e-9266-a023c5211eae


# ╔═╡ 7a47dc38-e772-4f32-bebc-2c3ddec481be
vspace

# ╔═╡ 9f82918f-3c27-4973-8645-b6bbb02f0edf
md"""
#### Example
Use a range to create a vector of all years from the year 2000 to the year 2024.
"""

# ╔═╡ e70a109e-843c-434c-9a2b-e18a37419193
let
	
end

# ╔═╡ 89685d39-d9db-4119-98fa-173096c7d628
vspace

# ╔═╡ b3dbf318-6e52-46ac-ae6e-2ea8832ba9e1
md"""
#
"""

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
	<input type="checkbox" value="" checked> Strings
	<br>
	<input type="checkbox" value="" checked> Pairs
	<br>
	<input type="checkbox" value="" checked> Tuples, Named Tuples
	<br>
	<input type="checkbox" value="" checked> Ranges
	<br>
	<br>
	</fieldset>      
	"""
end

# ╔═╡ 5f191192-bc5f-41e8-845c-beba89ee5841
md"""
#
"""

# ╔═╡ cddc45e1-7547-4d34-bc12-b08a5320a62c
# ╠═╡ show_logs = false
begin

	using PlutoUI, Printf, LaTeXStrings, HypertextLiteral

	using Pkg
	#Pkg.upgrade_manifest()
	Pkg.update()
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

julia_version = "1.10.0"
manifest_format = "2.0"
project_hash = "6b6c3dd8246a30b04854d2ce30c3f3718dd6ec8c"

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
# ╟─ea237d72-175a-40da-a35c-017d894ed8c0
# ╟─b71ed765-a596-45cd-9c29-cbb3d4cba1a4
# ╟─b3e2a1d6-70a5-402d-9219-82c280ba9328
# ╟─42d2dc69-c5e8-4cb8-809b-19cae75e479d
# ╟─c54e6422-2a39-4960-8332-51b98afaded6
# ╟─bc94035a-795b-4d08-aab2-87519b4ffd65
# ╟─25a404ef-b21a-4d43-b87b-f4348d9bb219
# ╠═6b387a90-454d-4507-8406-4acebdff8a3d
# ╟─a0a9a625-5ac0-470b-8e00-f724064bcf97
# ╟─4f5bb727-6475-483e-8d60-9cbeed9d7822
# ╠═402ebee0-68b0-4318-809d-fa81d40ff243
# ╟─7aef4abc-0abd-4e51-8494-2805aac60869
# ╟─cdcd1a12-3beb-4080-b76c-1976a48c6500
# ╠═34abd3a8-0a33-4d02-827e-d61c74ee9838
# ╟─511862c6-c3e8-44d2-9163-06fb0e8aa63a
# ╟─66d5ad2e-7569-4d40-9e1b-f49f7f2b1955
# ╟─098eafb0-8c7e-4584-b252-512d0bbb0227
# ╠═52c10638-14d0-4812-b54d-5879198be7dc
# ╟─cad420df-583c-4cfe-94db-d01506374f9e
# ╟─8b592c01-c988-4fb7-940e-a6628d35bceb
# ╟─3aa94c23-d150-4f32-b110-df92937e6981
# ╠═7a9e7928-6d4e-40e8-b9ea-26e2eb6d3f61
# ╟─21fdcf6b-3958-43a5-9e22-7192361246d8
# ╟─a7cf85d5-2299-4a6d-b2a0-9f70f1a5a96f
# ╟─01a1c439-7022-4857-968a-5321df4a183e
# ╟─9daccbff-20ee-4429-a428-2a404b585f10
# ╠═c245716e-1a72-42e9-b8cc-fd65b785e968
# ╟─39a41ede-0750-471d-89b3-b2a2d4e2ce52
# ╟─41074323-ec69-4320-b3f6-de85cc1d34c6
# ╠═d9cd0943-6573-44ac-9a25-0d5f05c9136e
# ╟─27b79bbc-ce6d-4270-8c1d-9363dbb6c35b
# ╟─7868c045-4fd9-419d-bc66-a9d14ea41c97
# ╠═c955997d-eeb5-48c6-9ab5-c85de7bef6fc
# ╠═c01f4006-98d1-48b8-a069-22f66b856c62
# ╟─e3e82a7f-263c-4b20-897c-338a740f6c6a
# ╟─657a80f5-b889-4c2f-84d3-eebdd9f28f02
# ╟─3c70b4ac-087e-41cf-a38a-fd654edb6011
# ╠═189e90ac-1516-4b4d-86c0-911bfbd1db24
# ╟─329b6035-dcd0-4238-b428-a8448141bdfa
# ╟─0c7bf844-59c0-4893-9c5f-40774bb61309
# ╟─c513d589-af7d-40d0-b496-0d0de4df56c3
# ╟─14d1d1de-458a-467b-8093-a0f63676fac2
# ╠═4990d1a0-30f7-4643-bd6e-39d0a642baa0
# ╟─7a4e47bb-dcaa-443e-bc90-a912221da8bb
# ╟─ce684892-82fc-4d6a-847d-1e55bfd80296
# ╠═e4e15f0f-212a-4071-b408-46dadc0b3e8d
# ╟─d4b4dbc1-ecd4-4ee8-ad34-fa83d5b65fdb
# ╠═3adf8946-20a8-4904-86d1-50c494cc96fb
# ╟─60d8da29-d333-4a52-9c5d-a3d9509ddb6c
# ╠═5d121a4b-8aba-42f4-a62c-24497cfeaad2
# ╠═70054c25-f239-47e3-b5c8-30ecec5101ce
# ╟─5a019a2f-0a04-4c7e-855e-40c216de0fda
# ╟─21c0603f-43e6-49ac-827e-6188b4bc52dc
# ╠═77837a1d-16f7-4034-8c0e-6be4fc7f5b10
# ╠═f5b12fba-0525-4f19-9b69-f62fc7603e08
# ╠═96802ee7-349f-4b2a-b7e5-0697b2537142
# ╠═265a4519-24c1-49c3-af86-659e451473e9
# ╟─6a9fcae9-9fa8-4209-a735-90a092514067
# ╟─4ae96703-9ea2-4edc-bd54-1cc86a55eabc
# ╠═fa8f864a-862c-4b4c-b755-0a7e7530ccfa
# ╟─a3703ec7-844c-42ee-9aa2-bb5530db98aa
# ╟─f70b6a6f-0704-4297-9913-f8328745d9ac
# ╠═d8d0ceda-a5c3-4c4a-819a-f2c513afe50a
# ╟─15278a6f-d33d-43ad-a35c-d5edcd91f75f
# ╟─806c4f8f-c9fb-4920-9956-eb0e7ccf543f
# ╟─7e2502b8-4535-4242-b56d-2373cb0d4050
# ╠═d6a7a8f8-9bf3-4d09-a108-eddb57e2c8b2
# ╟─050af10c-ba4f-422a-8aa3-8af49ca9048b
# ╟─ccc2b2e7-dbc1-4fbb-9620-951d0ff21a42
# ╠═f1affb0e-c709-4d29-ab47-dbc017bc54c6
# ╟─cb3c760e-16cf-4817-b8fc-bdab9f1b5e8b
# ╟─392afdf7-68df-4227-87a0-22e88dfb3e75
# ╠═dbcb6057-086d-4584-b961-7b6569781ffa
# ╟─0522f18b-6c47-49b9-a492-19ece6d49efc
# ╟─c805833e-e677-41cc-a748-b0f68e1e3098
# ╠═5e364de4-581a-4850-aa3c-4468418d181e
# ╟─32881d64-5939-4dc3-83ce-d3eb409229a6
# ╟─e4e970b8-0bc0-4d84-a20c-171546784439
# ╟─a47c9bca-a192-4148-8968-b105243ff04b
# ╟─d1011108-e962-4421-bc98-28483f5f560d
# ╟─4ad8f55a-b04c-4c98-9a91-ae7c380e5899
# ╠═b7dd2983-7735-4c23-a54d-ac3aabdd0838
# ╠═892566de-1f1a-4745-8713-f0244131bc6a
# ╟─361ef513-3661-4c9a-8630-4d1e42071efe
# ╟─2fc75d57-30e8-4c28-860c-386649436615
# ╟─95ce5454-a3a3-430a-9bc5-74fe3b5dd48f
# ╠═6796d442-ea72-4297-bad1-2b18e90d0d9a
# ╟─7e807618-c81a-4df0-83c3-89ea63dafbe9
# ╟─3c03eee2-47c3-432a-8e21-783422e18c89
# ╠═f5549c83-545a-4da2-841a-aaf1a2c656f3
# ╟─758c51a1-2227-47fb-80cd-8dda7b9a81e1
# ╟─fff54865-2dd3-4997-b3eb-6381fcb15450
# ╟─d8612c9b-aa37-4eb2-a853-493d5c68dd34
# ╠═77ba073b-e243-4f8e-827b-08f95e6981d1
# ╟─a02207c9-5108-4435-8b7a-9b68ef5bb97c
# ╟─d9ed75c6-0216-4552-8a5e-b917757cc48a
# ╠═1465ebe6-965b-45ab-8f14-2f5e341c3928
# ╟─4152dd29-da41-4f77-8991-459690a85b5b
# ╟─017bcf97-8429-4c78-8b18-6aeb6460a609
# ╟─0c8d0fac-f204-4c87-b74f-1eb63ed1e462
# ╠═1fda5a07-7981-428a-a8e5-9266570d0451
# ╟─24efaa98-fb85-42a6-a5e5-47b53fbbc86d
# ╠═4fa964ee-9226-4732-b993-f90240ee4dfe
# ╟─fdbeb35f-8a8d-4f29-9ad4-e3d195cafad5
# ╟─3cf6bb82-151b-4082-9ff9-67506b74af59
# ╟─37aee362-f7f6-4fd7-b240-e2c6da0252cd
# ╠═07f2c7a2-4262-4f6d-bed1-171124dbd28f
# ╠═efd520b0-5890-4de4-adbc-e15664b94688
# ╟─7b21ac8e-b41c-47d0-9a69-1ddfeed7da42
# ╟─a323ff01-48f8-4e80-ac10-6b3e5a6204bc
# ╟─e90df9cb-54eb-456a-ac4e-a374d2eb3ba1
# ╠═47442c7b-9c18-4e8b-96fd-0b4f472c8624
# ╟─6fdf0cc0-82ae-4dea-83f4-6da843962f4a
# ╟─bf7c9958-7100-4b32-8a45-100fe07b85b2
# ╠═12ab5565-b56a-4fd1-8a96-cb195093570f
# ╟─2e44fbb1-3b01-442b-9165-33a27f89f7e8
# ╟─2830ac94-b7a3-48fe-9865-aa3bd1293ecc
# ╠═42442364-0013-487e-b80d-47ab051f0c1b
# ╟─35678f86-dff3-4baf-ac61-22eb2aff248d
# ╟─cb5b2fe7-63aa-4fe3-a32a-e2caf6078668
# ╠═8bee3b15-811d-4c3e-9266-a023c5211eae
# ╟─7a47dc38-e772-4f32-bebc-2c3ddec481be
# ╟─9f82918f-3c27-4973-8645-b6bbb02f0edf
# ╠═e70a109e-843c-434c-9a2b-e18a37419193
# ╟─89685d39-d9db-4119-98fa-173096c7d628
# ╟─b3dbf318-6e52-46ac-ae6e-2ea8832ba9e1
# ╟─a124bf84-7ca4-40c8-8607-b05dec24a730
# ╟─75672e0c-5c34-44c8-b1a9-f6ba821d6c8d
# ╟─5f191192-bc5f-41e8-845c-beba89ee5841
# ╟─cddc45e1-7547-4d34-bc12-b08a5320a62c
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
