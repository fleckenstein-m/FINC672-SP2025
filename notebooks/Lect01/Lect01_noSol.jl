### A Pluto.jl notebook ###
# v0.19.38

using Markdown
using InteractiveUtils

# ╔═╡ cddc45e1-7547-4d34-bc12-b08a5320a62c
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

# ╔═╡ c2a42a5f-1f56-4ef3-af5e-32a1b393032d
html"""
	<p align=left style="font-size:32px; font-family:family:Georgia"> <b> FINC 672: Workshop in Finance - Empirical Methods</b> <p>
	"""

# ╔═╡ 74168e8a-2a45-453d-ada3-0171bc13d8ca
begin 
	html"""
	<p style="padding-bottom:1cm"> </p>
	<div align=center style="font-size:25px; font-family:family:Georgia"> FINC-672: Workshop in Finance - Empirical Methods </div>
	<p style="padding-bottom:1cm"> </p>
	<p align=center style="font-size:25px; font-family:family:Georgia"> <b> Julia Fundamentals </b> <p>
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

# ╔═╡ ae0ce267-67a9-4ee7-bf78-9687131d7111
vspace

# ╔═╡ 42d2dc69-c5e8-4cb8-809b-19cae75e479d
begin
	html"""
	<fieldset>      
    <legend><b>Learning Objectives</b></legend>      
	<br>
	<input type="checkbox" value=""> Basic Julia Syntax
	<br>
	<input type="checkbox" value=""> Variables
	<br>
	<input type="checkbox" value=""> Boolean Operators and Numeric Comparisons
	<br>
	<input type="checkbox" value=""> Functions
	<br>
	<input type="checkbox" value=""> Control Flow and Loops
	<br>
	</fieldset>      
	"""
end

# ╔═╡ 15965456-03b5-41fc-bd5a-e0334f2e48f1
md"""
#
"""

# ╔═╡ 965c2f3a-7aed-48db-9f34-880812267c2a
md"""
- Today, we cover the basics of Julia as a programming language. Having a basic understanding of Julia will make you more effective and efficient in using Julia.
- This is going to be a very brief and not in-depth overview of the Julia language.
- If you are already familiar and comfortable with other programming languages, I encourage you to read [Julia’s documentation](https://docs.julialang.org/). 
"""

# ╔═╡ 3632139a-33f4-443c-b692-4f61adc77edd
md"""
# Variables
"""

# ╔═╡ 14fadd48-e6fe-475f-92b8-8970b6487c05
md"""
- Variables are values that you tell the computer to store with a specific name so that you can later recover or change its value.
- Julia has several types of variables but the most important are:
  - Integers: `Int64`
  - Real Numbers: `Float64`
  - Boolean: `Bool`
  - Strings: `String`
"""

# ╔═╡ 6d90d638-b7c1-4e0b-a1af-8b0cdfa943b2
md"""
#
"""

# ╔═╡ f406efa1-c642-498a-8bf4-cd4ddcd35f9f
md"""
- We create new variables by writing the variable name on the left and its value on the right, and in the middle, we use the `=` assignment operator.
- For example, let's define two new variables: `name` and `age`.
"""

# ╔═╡ ade0df3a-f591-4c55-8032-c83005daa18a
let

end

# ╔═╡ 807e79b5-4c2c-446d-8018-8b1d43336255
let

end

# ╔═╡ 8e7f76a8-aef0-405f-b7e1-50ca7d98d6a1
md"""
#
"""

# ╔═╡ 13109b52-c7b4-4260-9607-9ab2793efef7
md"""
!!! note 
    In the two examples above, we used 
	```
	let
	
	end
	```
	- This is to ensure that the variables we define are only known to Julia inside the cell.
	- This means that we can redefine `name` and `age` somewhere else in the notebook.
	- If we leave out `let` and `end`, the writing `age = 10` somewhere else in the notebook will give us an error.
	- Within a cell, we can define new values for an existing variable. Julia will simply override the previous value with the new one.
"""

# ╔═╡ 9bf34305-6dec-46e2-95b4-c7b5d99a61e4
let

end

# ╔═╡ 26961c2c-7675-4c4c-aa1f-c148ef6a505c
md"""
!!! note 
    We will also use the block
	```
	begin
	
	end
	```
	- This means that the variables are accessible from all other cells in the notebook.
    - This also means that a variable name can only appear once across all `begin` `end` blocks. 
    - One nice feature of this is that when we change the value of a variable in a `begin` `end` block, the entire  notebook will be updated.
"""

# ╔═╡ 772624fc-0952-48f7-8d8f-f82231f39360
# ╠═╡ disabled = true
#=╠═╡
begin

end
  ╠═╡ =#

# ╔═╡ 2b6a6c20-3533-48c2-86c1-4d374c8be563
begin 

end

# ╔═╡ aef0ecc7-ad76-4888-ad41-e54123d16d07
md"""
#
"""

# ╔═╡ 9aacb4dd-4d6e-4b62-87fa-19e364b83c38
md"""
- We can also do operations on variables such as addition or division. For example, let's multiply age by 3:
"""

# ╔═╡ 40deef2b-c458-43ba-acad-7c02f5ae5787
let

end

# ╔═╡ 91a0bd38-0784-4123-876b-85d7361eb579
md"""
#
"""

# ╔═╡ 55a0a539-b89e-4544-9a8f-a6df6218c73b
md"""
- We can also do operations on a variable and update it. For example
"""

# ╔═╡ 5238a439-f5ee-4427-9533-b36965254a6d
let

end

# ╔═╡ 33f27100-64c9-47ef-b60c-62beba7af90c
md"""
#
"""

# ╔═╡ cb046dfb-4007-4216-9743-9456e8e4d250
md"""
- We can inspect the types of variables by using the `typeof` function:
"""

# ╔═╡ 7ed413c6-c0e5-4b85-b4dc-08666c418b28
let

end

# ╔═╡ 25c65694-fee6-4a51-bef6-6e8226bf97a0
md"""
# Boolean Operators and Numeric Comparisons
"""

# ╔═╡ 1d0c2cab-9c8f-44ea-8a1a-df5a80cb4d63
md"""
- Now that we’ve covered types, we can move to boolean operators and numeric comparisons.
- We have three boolean operators in Julia:
  - `!`: __NOT__
  - `&&`: __AND__
  - `||`: __OR__
"""

# ╔═╡ 2d20bd5f-e43e-4ff6-9080-0166046c8223
md"""
#
"""

# ╔═╡ c94cad38-5363-4964-bc42-02010e0a506c
md"""
- Here are a few examples with some of them:
"""

# ╔═╡ 7d8602c2-5a98-472d-a660-15f5f4f60a16


# ╔═╡ 82355982-8aeb-44e7-921f-7f99e4667c03


# ╔═╡ 46fe46fb-a64d-4cb9-9556-9bdea3381a21


# ╔═╡ c41f8840-5081-421e-9a2e-1b145f00b2ba
md"""
#
"""

# ╔═╡ aa452762-85fc-49c3-8e90-1da5d208d1b9
md"""
- Regarding numeric comparison, Julia has three major types of comparisons:
  1. Equality: either something is equal or not equal another
     - `==` "equal"
     - `!=` or `≠` "not equal"
  2. Less than: either something is less than or less than or equal to
     - `<` "less than"
     - `<=` or ≤ "less than or equal to"
  3. Greater than: either something is greater than or greater than or equal to
     - `>` "greater than"
     - `>=` or `≥` "greater than or equal to"
"""

# ╔═╡ 1c2d78ab-ab20-424f-a532-b9e26dbc34b5
md"""
#  
"""

# ╔═╡ 18716ab1-6ffc-43fa-a9b1-786effbce57d
md"""
- Examples
"""

# ╔═╡ 187e1fd0-b8ba-47d6-9857-5d36c195c2c9


# ╔═╡ c960a390-9194-48bc-b8c3-b38503d2fa76


# ╔═╡ 29cf39dc-62c5-4a57-add9-32c96c5efb95
md"""
#
"""

# ╔═╡ ab728c25-7523-4f17-be2a-04f8d69a1182
md"""
- This even works between different types.
"""

# ╔═╡ aaa9341e-4a13-413e-a6ae-7217e6b5d021


# ╔═╡ e9b473dd-dda5-44df-958b-3eafe9d65cd1
md"""
- We can also mix and match boolean operators with numeric comparisons
"""

# ╔═╡ 17febe2d-ac87-496b-9ebe-25da47922967


# ╔═╡ be960870-e0ff-49a3-b14b-dd7716edf25b
md"""
# Functions
"""

# ╔═╡ 6f182c16-b8f5-4835-9ce3-b21af62c5d5c
md"""
- Now that we already know how to define variables, let’s turn our attention to __functions__.
- In Julia, a function maps argument values to one or more return values
- The basic syntax is:
```
function function_name(arg1, arg2)
	result = stuff with the arg1 and arg2
return result
```
"""

# ╔═╡ e060e675-412f-4405-9bd1-eca0501a1b48
md"""
#
"""

# ╔═╡ d05e6344-74af-4fc6-b88d-6ec8204e1386
md"""
- The function declaration begins with the keyword `function` followed by the function name.
- Then, inside parentheses `()`, we define the arguments separated by a comma `,`.
- Inside the function, we specify what we want Julia to do with the parameters that we supplied.
  - All variables that we define inside a function are deleted after the function returns, this is nice because it is like an automatic cleanup.
  - After all the operations in the function body are finished, we instruct Julia to `return` the final result with the return statement.
- Finally, we let Julia know that the function definition is finished with the `end` keyword.
"""

# ╔═╡ 3dad3232-da88-4f40-8faf-6ecaf2cf90e5
md"""
#
"""

# ╔═╡ 217cdb78-2aa9-496e-9daa-f20f8e762bf3
md"""
Let’s dive into some examples. First, let’s create a new function that adds
numbers together:
"""

# ╔═╡ 2cb1933c-50ac-4fed-844b-52aee0f45b71


# ╔═╡ bbd1e1c4-11f8-4e9e-9b53-d5111fe83342
md"""
#
"""

# ╔═╡ 4dd59b38-5e55-4272-8570-650061cb9edb
md"""
- Now, we can use our `add_numbers` function:
"""

# ╔═╡ 4329e88e-ecbe-4336-b453-fc657d4a1621


# ╔═╡ b37b6554-e1fd-4742-a80e-1829b5abd015
md"""
And it works also with floats
"""

# ╔═╡ a0bd7251-d107-4546-bc55-36157dc2f526


# ╔═╡ 9a2f2002-9bc6-4386-a579-b3903f8b61e1
md"""
#
"""

# ╔═╡ 766f70c4-afc4-4e31-86f2-575ee5604d30
md"""
- A function can, also, return two or more values.
- See the new function `add_multiply` below
"""

# ╔═╡ b09bcf25-f482-4599-91ce-37781530d8f6


# ╔═╡ 5941aeae-096f-477d-9f8d-99d0de53b527
md"""
#
"""

# ╔═╡ d1f1e579-de69-4380-acee-9f8793f3f256
md"""
- In that case, we can do two things:
  1. We can, analogously as the return values, define two variables to hold the function return values, one for each return value
  2. Or we can define just one variable to hold the function return values and access them with either first or last.
"""

# ╔═╡ c756ea1a-af25-4152-85f2-7e75b9f18d5b
md"""
#
"""

# ╔═╡ 3b659642-6f7f-43ba-9f3d-99561a36e2c0


# ╔═╡ ce6c05f7-a5a4-4380-bf19-b5e801df1c04


# ╔═╡ 28e15a84-5b59-4732-ae2b-97398b75b987
md"""
# Conditional If-Else-Elseif
"""

# ╔═╡ 2d31ec89-d66f-441a-b3b5-9e6baaa77f8a
md"""
- In most programming languages, the user is allowed to control the computer’s flow of execution.
- Depending on the situation, we want the computer to do one thing or another.
- In Julia we can control the flow of execution with `if`, `elseif` and `else` keywords. These are known as conditional statements
"""

# ╔═╡ 33e4df84-304e-4047-a8bc-c9f97bc8ab38
md"""
#
"""

# ╔═╡ 7da6031d-600a-4100-ba62-0e312052eba7
md"""
- `if` keyword prompts Julia to evaluate an expression and depending on whether `true` or `false` certain portions of code will be executed.
- We can compound several `if` conditions with the `elseif` keyword for complex control flow.
- Finally, we can define an alterative portion to be executed if anything inside the `if` or `elseif`‘s is evaluated to `true`.
- This is the purpose of the `else` keyword.
- Finally, like all the previous keyword operators that we saw, we must tell Julia when the conditional statement is finished with the `end` keyword.
"""

# ╔═╡ 62c6d81a-4859-4dc5-9714-b44c117f6aca
md"""
#
"""

# ╔═╡ e8f7c3ce-256a-4291-b1e4-73dd0c11329d
md"""
- Here's an example with all the `if-elseif-else` keywords:
"""

# ╔═╡ b5d6e2ae-5ea1-4ed6-9a9e-8bf9c108e46c
let

end

# ╔═╡ 44d36e73-fb3b-4c12-83c7-cc4875927d8d
md"""
#
"""

# ╔═╡ 5766ea83-6a34-4968-88f2-387337e06499
md"""
- We can even wrap this in a function called `compare`:
"""

# ╔═╡ 69addfa3-5a79-45fe-a05e-ccfd5e877722


# ╔═╡ ce2dbd2a-a5b8-4b9f-9ea6-3932029f4069


# ╔═╡ 01cd64f7-e024-4def-a8b7-0a03f4276033
md"""
# For Loop
"""

# ╔═╡ 7b3bd5e1-7460-4c71-981b-c13176cf8b3d
md"""
- The classical for loop in Julia follows a similar syntax as the conditional statements.
- You begin with a keyword, in this case `for`.
- Then, you specify what Julia should "loop" for, i.e., a sequence.
- Also, like everything else, you must finish with the `end` keyword.
"""

# ╔═╡ 31338853-5fce-41d8-8366-a0cd5cd8e1ac
md"""
#
"""

# ╔═╡ 8134e48e-0f43-44f4-93ef-91cbef4e7442
md"""
So, to make Julia print every number from 1 to 10, you can use the following for
loop:
"""

# ╔═╡ cb389ce1-19b2-447e-af81-27b040b94ee5


# ╔═╡ 9d85e2dd-e003-4b89-92c4-7f863583770f
md"""
# While Loop
"""

# ╔═╡ a9694818-e967-431c-858c-a5e30f56962b
md"""
- The while loop is a mix of the previous conditional statements and for loops.
- Here, the loop is executed every time the condition is true.
- The syntax follows the same fashion as the previous one.
- We begin with the keyword `while`, followed by the statement to evaluated as either `true`.
- Like previously, you must end with the `end` keyword.
"""

# ╔═╡ 0a8e4dec-f313-49e6-9998-9690ae07b3e1
md"""
#
"""

# ╔═╡ 6d951c8d-22f5-4d6d-b4e8-13bf62b28bea
md"""
- Here’s an example
"""

# ╔═╡ f7da342c-f5ea-4a8c-b2ed-a7ebafb0ef6d
let

end

# ╔═╡ 6591f1c4-7b60-42cc-8101-e6314e280ecf
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
	<input type="checkbox" value="" checked> Basic Julia Syntax
	<br>
	<input type="checkbox" value="" checked> Variables
	<br>
	<input type="checkbox" value="" checked> Boolean Operators and Numeric Comparisons
	<br>
	<input type="checkbox" value="" checked> Functions
	<br>
	<input type="checkbox" value="" checked> Control Flow and Loops
	<br>
	</fieldset>      
	"""
end

# ╔═╡ 5f191192-bc5f-41e8-845c-beba89ee5841
md"""
#
"""

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
# ╟─c2a42a5f-1f56-4ef3-af5e-32a1b393032d
# ╟─74168e8a-2a45-453d-ada3-0171bc13d8ca
# ╟─ae0ce267-67a9-4ee7-bf78-9687131d7111
# ╟─42d2dc69-c5e8-4cb8-809b-19cae75e479d
# ╟─15965456-03b5-41fc-bd5a-e0334f2e48f1
# ╟─965c2f3a-7aed-48db-9f34-880812267c2a
# ╟─3632139a-33f4-443c-b692-4f61adc77edd
# ╟─14fadd48-e6fe-475f-92b8-8970b6487c05
# ╟─6d90d638-b7c1-4e0b-a1af-8b0cdfa943b2
# ╟─f406efa1-c642-498a-8bf4-cd4ddcd35f9f
# ╠═ade0df3a-f591-4c55-8032-c83005daa18a
# ╠═807e79b5-4c2c-446d-8018-8b1d43336255
# ╟─8e7f76a8-aef0-405f-b7e1-50ca7d98d6a1
# ╟─13109b52-c7b4-4260-9607-9ab2793efef7
# ╠═9bf34305-6dec-46e2-95b4-c7b5d99a61e4
# ╟─26961c2c-7675-4c4c-aa1f-c148ef6a505c
# ╠═772624fc-0952-48f7-8d8f-f82231f39360
# ╠═2b6a6c20-3533-48c2-86c1-4d374c8be563
# ╟─aef0ecc7-ad76-4888-ad41-e54123d16d07
# ╟─9aacb4dd-4d6e-4b62-87fa-19e364b83c38
# ╠═40deef2b-c458-43ba-acad-7c02f5ae5787
# ╟─91a0bd38-0784-4123-876b-85d7361eb579
# ╟─55a0a539-b89e-4544-9a8f-a6df6218c73b
# ╠═5238a439-f5ee-4427-9533-b36965254a6d
# ╟─33f27100-64c9-47ef-b60c-62beba7af90c
# ╟─cb046dfb-4007-4216-9743-9456e8e4d250
# ╠═7ed413c6-c0e5-4b85-b4dc-08666c418b28
# ╟─25c65694-fee6-4a51-bef6-6e8226bf97a0
# ╟─1d0c2cab-9c8f-44ea-8a1a-df5a80cb4d63
# ╟─2d20bd5f-e43e-4ff6-9080-0166046c8223
# ╟─c94cad38-5363-4964-bc42-02010e0a506c
# ╠═7d8602c2-5a98-472d-a660-15f5f4f60a16
# ╠═82355982-8aeb-44e7-921f-7f99e4667c03
# ╠═46fe46fb-a64d-4cb9-9556-9bdea3381a21
# ╟─c41f8840-5081-421e-9a2e-1b145f00b2ba
# ╟─aa452762-85fc-49c3-8e90-1da5d208d1b9
# ╟─1c2d78ab-ab20-424f-a532-b9e26dbc34b5
# ╟─18716ab1-6ffc-43fa-a9b1-786effbce57d
# ╠═187e1fd0-b8ba-47d6-9857-5d36c195c2c9
# ╠═c960a390-9194-48bc-b8c3-b38503d2fa76
# ╟─29cf39dc-62c5-4a57-add9-32c96c5efb95
# ╟─ab728c25-7523-4f17-be2a-04f8d69a1182
# ╠═aaa9341e-4a13-413e-a6ae-7217e6b5d021
# ╟─e9b473dd-dda5-44df-958b-3eafe9d65cd1
# ╠═17febe2d-ac87-496b-9ebe-25da47922967
# ╟─be960870-e0ff-49a3-b14b-dd7716edf25b
# ╟─6f182c16-b8f5-4835-9ce3-b21af62c5d5c
# ╟─e060e675-412f-4405-9bd1-eca0501a1b48
# ╟─d05e6344-74af-4fc6-b88d-6ec8204e1386
# ╟─3dad3232-da88-4f40-8faf-6ecaf2cf90e5
# ╟─217cdb78-2aa9-496e-9daa-f20f8e762bf3
# ╠═2cb1933c-50ac-4fed-844b-52aee0f45b71
# ╟─bbd1e1c4-11f8-4e9e-9b53-d5111fe83342
# ╟─4dd59b38-5e55-4272-8570-650061cb9edb
# ╠═4329e88e-ecbe-4336-b453-fc657d4a1621
# ╟─b37b6554-e1fd-4742-a80e-1829b5abd015
# ╠═a0bd7251-d107-4546-bc55-36157dc2f526
# ╟─9a2f2002-9bc6-4386-a579-b3903f8b61e1
# ╟─766f70c4-afc4-4e31-86f2-575ee5604d30
# ╠═b09bcf25-f482-4599-91ce-37781530d8f6
# ╟─5941aeae-096f-477d-9f8d-99d0de53b527
# ╟─d1f1e579-de69-4380-acee-9f8793f3f256
# ╟─c756ea1a-af25-4152-85f2-7e75b9f18d5b
# ╠═3b659642-6f7f-43ba-9f3d-99561a36e2c0
# ╠═ce6c05f7-a5a4-4380-bf19-b5e801df1c04
# ╟─28e15a84-5b59-4732-ae2b-97398b75b987
# ╟─2d31ec89-d66f-441a-b3b5-9e6baaa77f8a
# ╟─33e4df84-304e-4047-a8bc-c9f97bc8ab38
# ╟─7da6031d-600a-4100-ba62-0e312052eba7
# ╟─62c6d81a-4859-4dc5-9714-b44c117f6aca
# ╟─e8f7c3ce-256a-4291-b1e4-73dd0c11329d
# ╠═b5d6e2ae-5ea1-4ed6-9a9e-8bf9c108e46c
# ╟─44d36e73-fb3b-4c12-83c7-cc4875927d8d
# ╟─5766ea83-6a34-4968-88f2-387337e06499
# ╠═69addfa3-5a79-45fe-a05e-ccfd5e877722
# ╠═ce2dbd2a-a5b8-4b9f-9ea6-3932029f4069
# ╟─01cd64f7-e024-4def-a8b7-0a03f4276033
# ╟─7b3bd5e1-7460-4c71-981b-c13176cf8b3d
# ╟─31338853-5fce-41d8-8366-a0cd5cd8e1ac
# ╟─8134e48e-0f43-44f4-93ef-91cbef4e7442
# ╠═cb389ce1-19b2-447e-af81-27b040b94ee5
# ╟─9d85e2dd-e003-4b89-92c4-7f863583770f
# ╟─a9694818-e967-431c-858c-a5e30f56962b
# ╟─0a8e4dec-f313-49e6-9998-9690ae07b3e1
# ╟─6d951c8d-22f5-4d6d-b4e8-13bf62b28bea
# ╠═f7da342c-f5ea-4a8c-b2ed-a7ebafb0ef6d
# ╟─6591f1c4-7b60-42cc-8101-e6314e280ecf
# ╟─a124bf84-7ca4-40c8-8607-b05dec24a730
# ╟─75672e0c-5c34-44c8-b1a9-f6ba821d6c8d
# ╟─5f191192-bc5f-41e8-845c-beba89ee5841
# ╟─cddc45e1-7547-4d34-bc12-b08a5320a62c
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
