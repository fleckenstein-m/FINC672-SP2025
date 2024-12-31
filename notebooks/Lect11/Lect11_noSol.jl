### A Pluto.jl notebook ###
# v0.19.38

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

# ╔═╡ 971f2459-4f97-4e64-bd25-24d831a4d272
begin

	using HTTP
	using JSON3

	query = "https://api.nbp.pl/api/exchangerates/rates/a/usd/" *
			"2022-06-01/?format=json"
	
end

# ╔═╡ 0084413a-acae-4ccb-a38a-93c48243cfbc
using Dates

# ╔═╡ c268b7b0-609f-475a-9358-e99bb1a1284d
using Statistics

# ╔═╡ 88401a57-76dd-4f99-8515-522a1f6edfe7
begin
	using FreqTables
	
end

# ╔═╡ 17feaa79-2394-4cc8-995e-dec9510199e2
begin
	using Plots
	
end

# ╔═╡ 5412d08d-9232-44fe-aaa6-4970e0795bc9
begin
	using Impute
	
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
	<p align=center style="font-size:25px; font-family:family:Georgia"> <b> Using Web APIs for Data Collection</b> <p>
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

# ╔═╡ a2953e7d-a163-4e1f-8c2c-54a6c31e3d1e
vspace

# ╔═╡ b9cb6ae7-67e2-4671-a49a-c6d2d10e6766
md"""
*Note: The material in this notebook are adapted from Kamiński, Bogumił (2023). Julia for Data Analysis. [https://www.manning.com/books/julia-for-data-analysis](https://www.manning.com/books/julia-for-data-analysis)*
"""

# ╔═╡ 64c2ee7d-a379-46d5-9bff-2152f57fa78c
TableOfContents(aside=true, depth=1)

# ╔═╡ f7428550-fe1b-4749-ad1d-6810f7f136c1
vspace

# ╔═╡ fcdb31f2-3f46-4959-99ef-5e1a2185dbf7
begin
html"""
<fieldset>      
<legend>Goals for today</legend>      
<br>
  <input type="checkbox" value="">Fetching data by using HTTP queries. <br>      
<br>
  <input type="checkbox" value="">Parsing JSON data.<br>
<br>
  <input type="checkbox" value="">Working with dates.<br>      
<br>
<input type="checkbox" value="">Handling missing values.<br>      
<br>
<input type="checkbox" value="">Plotting data with missing values.<br>      
<br>
<input type="checkbox" value="">Interpolating missing values.<br>      
</fieldset>      
"""
end

# ╔═╡ b68a17d2-a3e7-4379-a441-1ca20a8970c5
vspace

# ╔═╡ 806aebe8-d7b8-4dde-b5a2-401ec631b444
md"""
# Exchange Rates

- The problem we tackle in this lecture is analyzing the PLN/USD exchange rate that is published by the National Bank of Poland (NBP). 
- The data is made available via a Web API, which is described at [https://api.nbp.pl/en.html](https://api.nbp.pl/en.html).
"""

# ╔═╡ 155f8b79-4163-4759-b4d6-2085be2dd77b
vspace

# ╔═╡ f3165fda-e453-495e-bd30-1d181e0fbe0f
md"""
We will perform our task via the following steps:
1. Understand the format of the data that the Web API exposes.
2. Fetch the data by using HTTP GET requests for a specified range of dates.
3. Handle errors when the requested data is not available.
4. Extract the PLN/USD exchange rate from the obtained result of the query.
5. Perform simple statistical analysis of the fetched data.
6. Plot the fetched data with a proper handling of missing values.
"""

# ╔═╡ 026a08b7-3fdd-4b8d-92a8-2fa2bd9d5047
vspace

# ╔═╡ 2807c946-1aca-47b7-9c0f-e5d8e6270a0a
md"""
# Web APIs
"""

# ╔═╡ 7d7c0d8e-9beb-420b-b9c2-ec40b5d15d9f
md"""
The full specification of the Web API is available at [link](https://api.nbp.pl/en.html). The API can be accessed both via a web browser and programmatically. We start by querying it using a web browser. For our purpose, it is enough to know one format of the request:

`https://api.nbp.pl/api/exchangerates/rates/a/usd/YYYY-MM-DD/?format=json`

"""

# ╔═╡ 03003007-7690-4b3c-ae88-6070c69c5534
vspace

# ╔═╡ 195bfdc0-3d41-44bc-b1e1-354d09db5bbe
md"""
In this request, you should replace the YYYY-MM-DD part with a specific date, first
passing four digits of a year, then two digits for the month, and finally two digits for the day. 
- Here is an example of getting data for June 1, 2020:

`https://api.nbp.pl/api/exchangerates/rates/a/usd/2020-06-01/?format=json`
"""

# ╔═╡ d5d035fb-2756-4a01-b343-819e90f55c36
vspace

# ╔═╡ 597a33a1-e073-4280-87e5-dd69ecd6f862
md"""
When we run this query in your web browser, we get the following response
(depending on the browser you use, the layout of the response might be a bit different):
"""

# ╔═╡ 16a77cbc-77fb-4583-a002-7e4cbde93be9
md"""

	{
	"table":"A",
	"currency":"dolar amerykański",
	"code":"USD",
	"rates":[
			 {
			  "no":"105/A/NBP/2020",
			  "effectiveDate":"2020-06-01",
			  "mid":3.9680
			 }
			]
	}
"""

# ╔═╡ 45293830-01ac-4d90-98b8-9718f286fcd7
vspace

# ╔═╡ 0124af48-f9ac-479f-a862-b6f77c168955
md"""
- The result is returned in `JSON` format. 
  - You can find the format specification at [www.json.org/json-en.html](www.json.org/json-en.html). 
  - Additionally, if you want to learn more about JSON, consider going through the MDN Web Docs tutorial at [http://mng.bz/DDKa](http://mng.bz/DDKa). 
- Here, we will concentrate on explaining how this specific JSON structure should be interpreted.
"""

# ╔═╡ 10ccafb8-e444-4e87-876c-77a8e168ac25
Resource(
	"https://i.postimg.cc/RC6LfjN5/JSONFormat.png",
	:width => 800
)

# ╔═╡ 45e525b2-2be4-4ef0-83ca-36f3bc3a4730
vspace

# ╔═╡ 7f60398a-3c7a-4bc4-ab73-ba721b40905f
md"""
- The result contains one object with four fields: 
  - table
  - currency
  - code
  - rates. 
- The field that is interesting for us is `rates`, which contains an array holding a single object. 
- This single object has three fields: 
  - no
  - effectiveDate
  - mid. 
- For us, the important field is mid, which stores the PLN/USD exchange rate for the day we have queried. For June 1, 2020, the exchange rate was 3.960 PLN/USD.
"""

# ╔═╡ b08c9d32-4c15-4dfa-a551-46bd79de5652
vspace

# ╔═╡ 49bfc368-94e2-42a2-b4d3-213336629b28
md"""
# Web APIs using Julia
"""

# ╔═╡ a125d73b-25a7-4ac7-948c-49a81379ff6f
md"""
Now that we understand the structure of the data, we switch to Julia. 
- We will fetch the data from the NBP Web API by using the `HTTP.get` function from the `HTTP.jl` package.
- Next, we will parse this response by using the JSON reader provided by the function `JSON3.read` from the `JSON3.jl` package. 
"""

# ╔═╡ 859276d4-8b94-4e97-a7be-9e53a780c7d0
vspace

# ╔═╡ 38bb278a-f905-4168-ab76-7370f0d3137f


# ╔═╡ 2ed05013-c555-4206-aa3e-02acd8809254
vspace

# ╔═╡ 3307f16d-b553-49dd-bd36-c517456d36f7


# ╔═╡ fb7e97cd-7aef-4578-82d5-6fbb66b23a93
md"""
The response object has several fields, and the one that is important for us is
body, which stores the vector of fetched bytes:
"""

# ╔═╡ b820ae55-443d-4b76-8d11-472fc5569a3c
md"""
Let's inspect the response object
"""

# ╔═╡ 7613e884-8392-4aff-991f-cdab4773f3aa


# ╔═╡ e840176c-dd24-4d1e-a8c9-69f599674301
md"""
We pass this vector of bytes to the JSON reader function JSON3.read.
"""

# ╔═╡ 5754bd79-5831-4c94-821b-d846bb6186f1


# ╔═╡ 8be0843e-af4a-4da2-ba5c-71c7604beb19
vspace

# ╔═╡ 425901b7-f1d1-4da9-a75e-ca3610d6799d
md"""
- Next, let’s turn to the json variable to which we have bound the return value of JSON3.read (response.body). 
- A nice feature of the JSON3.read function is that the object it returns can be queried just like any other object in Julia. 
- Therefore, use the dot (.) to access its fields:
"""

# ╔═╡ 46bb021a-a461-4848-b17b-2ba64fe9e295


# ╔═╡ 776cba9f-4cb9-4751-a183-543b1168c4a1


# ╔═╡ baa4746d-dee2-46d3-90db-933af5eee599


# ╔═╡ e1e59fdd-dc73-48cf-9108-28372ba50661


# ╔═╡ a69db56e-2da7-48f8-b38d-ff732455e1ec
vspace

# ╔═╡ 0eab5cc7-2e6b-4c27-8ef6-e1ea1d946930
md"""
- Similarly, JSON arrays, like the one stored in the json.rates field, can be accessed using 1-based indexing, just like any vector in Julia. 
- Therefore, to get the mid field of the first object stored in the json.rates, you can write this:
"""

# ╔═╡ c8b9dc7f-b4e0-4dbc-92ed-3cb300400669


# ╔═╡ b6c80a1a-3150-45d4-a3b5-acd7b5e17de6
vspace

# ╔═╡ 9db3d9fc-c848-4348-b6e2-1d46c5333870
md"""
## Handling cases when a Web API query fails
"""

# ╔═╡ 5600d079-e494-455e-967c-c33ec7ed55a5
md"""
- Before we proceed to fetching data for a wider range of dates, let’s discuss one more feature of the NBP Web API. 
- The scenario we want to consider is what happens if we do not have data on the PLN/USD exchange rate for a given day. 
- To illustrate,  execute the following query in your browser:

`https://api.nbp.pl/api/exchangerates/rates/a/usd/2020-06-06/?format=json`
"""

# ╔═╡ abd517a3-3e7e-4ca3-952f-d2d0db312cb3
vspace

# ╔═╡ ed1004db-2ce0-4e72-ae16-7cbf1e9b9d4b
md"""
We should get the following response:

	`404 NotFound - Not Found - Brak danych`

We see that in this case, the data has no date for June 6, 2020. Let’s see how this scenario is handled when we try to execute the query programmatically in the next listing.

"""

# ╔═╡ 5ae5f571-372b-4f3f-a34b-a36246650309
vspace

# ╔═╡ 9ac46275-0163-4123-95b7-bc8076d06a41
begin
	query_fail = "https://api.nbp.pl/api/exchangerates/rates/a/usd/" *
		"2020-06-06/?format=json"
		"https://api.nbp.pl/api/exchangerates/rates/a/usd/2020-06-06/?format=json"


end

# ╔═╡ 0ade2a38-f7dc-42dd-a89c-adff80ee7334
vspace

# ╔═╡ cced3ddf-b1d2-4894-b1a9-1fce29ce19d8
md"""
The HTTP.get function throws an exception in this case with a 404 error, informing
us that the requested page was not found. This is a new scenario that we have not
encountered yet
"""

# ╔═╡ ca49f09d-10a1-41c9-99eb-263319cc2de7
md"""
- Let’s discuss how to handle exceptions so that they do not terminate our program if we do not want them to. For this, we use the `try-catch-end` block.

- We proceed using the following steps
1. Tries to execute our query in the try part of the block
2. If the query succeeds, returns its result
3. If the query fails, executes the contents of the catch part of the block

- As we see below, for the valid date of June 1, 2020, we get the parsed value 3.968, and for the invalid date of June 6, 2020, a missing value is produced.
"""

# ╔═╡ 4690a578-2089-495a-af77-180aa4e1e143
vspace

# ╔═╡ 98956a7a-4e81-4d69-952e-1d387a9e8056
let
	query = "https://api.nbp.pl/api/exchangerates/rates/a/usd/" *
		"2020-06-01/?format=json"

	
end

# ╔═╡ dab2d612-71e0-48df-83d0-da91bd681eb6
vspace

# ╔═╡ e9462030-da21-47ce-9a88-be35b54e09fe
let

	query = "https://api.nbp.pl/api/exchangerates/rates/a/usd/" *
		"2020-06-06/?format=json"

	
end

# ╔═╡ 3f657ea2-b3f6-4281-97fb-d9b22b7475fd
vspace

# ╔═╡ a30f3bbd-326d-481d-92a5-dfd24c9b1759
md"""
## Getting time-series data from the NBP Web API
"""

# ╔═╡ 52db31ca-ba68-4e5b-b504-d71ab8dbbe5e
md"""
We are now ready to analyzing the PLN/USD exchange rate. For this example, assume we want to get the data for all days of June 2020. We will create a function that fetches the data from a single day and then apply it to all days in question. 
"""

# ╔═╡ 82c2c7f4-3e69-4800-bb2d-2b82d2403145
md"""
- To begin, we load the `Dates.jl` package.
"""

# ╔═╡ 5fdb6824-5508-4d8e-a947-6b68fa1f9c04
md"""
- We already know how to construct a vector of dates for all days in a given month (e.g., June 2022) or between two dates.
- Recall that we accomplish this using `Date` ranges.
- For instance, to get the a range of dates from May 20, 2023 to July 5, 2023. we use
"""

# ╔═╡ edd1716f-a882-4678-982e-4ad1796c9ad4


# ╔═╡ 6a4c45b1-c5ab-48c1-b2d0-77f0ec9c2cc0
vspace

# ╔═╡ bc4a619f-bda2-4eaa-b56a-3ea9e2b93fc7
md"""
- Now that we’ve created a dates vector of dates for which we want to get the PLN/USD exchange rate data, let’s write a function that gets data for a specific date.
"""

# ╔═╡ 1d0dd4b6-6189-4986-a852-25a9e0177a0c


# ╔═╡ 288ce3c2-1a63-446e-9fd1-1c64fe752835
vspace

# ╔═╡ 62fb7d1d-fbd1-431b-9761-bb4b82b63a8d
md"""
Let's now use our function
"""

# ╔═╡ 8da702ce-fa95-4d97-882e-9a13a9b5c381


# ╔═╡ 4d7adfd5-7817-4cbb-a842-b3008d886801
vspace

# ╔═╡ d96c02f0-1e62-40ad-a691-10ed1d935798
md"""
- Note that we use the dot (.) after the get_rate function to apply it to all elements of the dates vector. 
- Additionally, the result is a Vector having the element type Union{Float64, Missing}, which means that in the result, we have a mixture of missing values and floating-point numbers.
"""

# ╔═╡ 4cc01d2f-e046-4eea-b945-6f54db2e7711
vspace

# ╔═╡ c8299e05-a65e-4393-b170-3a317594604a
md"""
# Analyzing Web API Data
"""

# ╔═╡ 0896da60-d72f-4474-b5ef-f1e95eb59273
md"""
- Given the data we just collected, we want to do the following:

1. Calculate basic summary statistics of the data: the mean and standard deviation of the rates vector
2. Analyze for which days of the week we encounter missing data in our vector
3. Display the PLN/USD exchange rate on a plot

"""

# ╔═╡ 406ff58f-6658-4d9a-8d9f-e25ec4a3f07a
vspace

# ╔═╡ 1c1c0d05-94f6-4fe8-a7c6-c5d2acd4ef20
md"""
- First, we want to calculate the mean and standard deviation of the rates vector.
"""

# ╔═╡ bcfd13c1-7f34-4f94-ae70-7409c4d3383c


# ╔═╡ 8788d094-c3f5-4855-b32c-42d7d37b60a3


# ╔═╡ 81db7812-75d4-4f83-bd54-96cca465e38c
vspace

# ╔═╡ d22920d4-38db-4a25-945e-713b274ae18a
md"""
- Unfortunately, this is not what we expect. 
- The reason for this is that we are dealing with missing data.
- Thus, we need to additionally use the `skipmissing` function which allows us to `skip` over missing observations such that we can compute means and standard deviations.
"""

# ╔═╡ c48f2bc6-1029-440a-86a7-4a17da90ba4b


# ╔═╡ c20b673f-676e-4004-9016-dd7837585df6


# ╔═╡ 32f2a06d-1a92-440e-9bc9-93c492719df1
vspace

# ╔═╡ 3e8c5879-86c1-46b8-acf4-6fb8d347637c
md"""
## Finding which days of the week have the most missing values
"""

# ╔═╡ 8c3c65e0-dad5-4d67-80c6-cf798486a216
md"""
- the `dayname` function returns the English name of the given day. 
- Therefore, we can use the `proptable` function from the `FreqTable.jl` package to get the desired result by cross-tabulating `dayname.(dates)` and `ismissing.(rates)`, as shown below.
"""

# ╔═╡ 5a92e307-4b31-4818-abd9-c596ca331ba7
vspace

# ╔═╡ 1be5bbaf-16d4-4d56-8f9d-8d44fc2ac651
md"""
- We can see that we always have missing data for Saturday and Sunday. 
- For all other days, no data is missing except for Thursday. 
- Let’s find which Thursdays are problematic. 
- For this, we create a Boolean vector that finds the indices in our vector that meet both conditions using broadcasting.
"""

# ╔═╡ 0c7ab1ce-0fbd-4a84-9735-e07c463bff79


# ╔═╡ 81883771-459b-4c7c-a529-457e5868fb4b


# ╔═╡ 97455b0e-da65-4dd7-9811-794a4c1c74c0
md"""
- We can see that a single day meets our condition. 
- It turns out that this date was a national holiday in Poland, so the result seems reasonable.
"""

# ╔═╡ dd053f81-18ad-4bc3-8b19-a9c1c0ebd1a1
vspace

# ╔═╡ 4e378fc9-b49f-4d57-851b-a735fadd5731
md"""
## Plotting the PLN/USD exchange rate
"""

# ╔═╡ f6303f92-d07d-4dad-97ae-9d1bc89b8ba9
md"""
- As a final step, let’s create a plot of the PLN/USD exchange rate. 
- We start with the simplest approach, passing the dates and rates vectors to the plot function.
"""

# ╔═╡ d73f83b6-9d32-4c47-93dd-07856660232f
vspace

# ╔═╡ 6b063ab8-8e08-4711-9d45-4f8d890b23d3
md"""
- We can see that this resultdoes not look very nice, as it contains gaps in places where we have missing values in the rates vector.
- To fix the plot, let’s skip the days in both dates and rates vectors in places where the rates vector contains missing values. 
- We can again use the Boolean vector of valid indices. The syntax is slightly tricky.
"""

# ╔═╡ d7bda76c-9a0c-4760-9160-316f9bed705e
begin
	
end

# ╔═╡ 177c6de4-7da1-4b89-ae51-f508341951e5
vspace

# ╔═╡ c576246c-62a7-449c-8653-8c21d5c7d1ef
md"""
- We observe that on the plot’s x-axis, the observations are properly spaced according to their dates. This effectively means that we have linearly interpolated the values for the days for which the data was missing—that is, the dots in the plot are connected by straight lines.
- We can perform linear interpolation of our data by using the `Impute.interp` function from the `Impute.jl` package. 
- Given a vector, this function fills all missing values between two nonmissing values by using linear interpolation.
"""

# ╔═╡ 41042388-1dd4-4460-941d-a16157432465
vspace

# ╔═╡ 44968590-9898-49f6-925c-864c08a59b76
md"""
- To conclude the analysis, let’s add a scatterplot of dates against the `rates_filled` vector.
"""

# ╔═╡ 6329e073-186a-47f2-b6bc-cb18b963a92a


# ╔═╡ 9104b977-144a-47bb-8b90-1864d9de9a47
vspace

# ╔═╡ 44a7664c-a09a-43fe-a1d1-7f80a718074e
md"""
- We can also make the plot prettier.
- Take a lookg at the `Plots.jl` package and the “Attributes” section of its manual at [https://docs.juliaplots.org/stable/attributes/](https://docs.juliaplots.org/stable/attributes/).
"""

# ╔═╡ 2d47eead-9131-44aa-b116-cc1688999945


# ╔═╡ 01e35936-1d6d-4ce8-bf38-c80fc22ca825
vspace

# ╔═╡ 53fa5b3c-f3a4-433e-9515-d8919bfc1f18
md"""
# Wrap-Up
"""

# ╔═╡ e3ec2296-6622-4aac-a42c-846d826448f8
begin
html"""
<fieldset>      
<legend>Goals for today</legend>      
<br>
  <input type="checkbox" value="" checked>Fetching data by using HTTP queries. <br>      
<br>
  <input type="checkbox" value="" checked>Parsing JSON data.<br>
<br>
  <input type="checkbox" value="" checked>Working with dates.<br>      
<br>
<input type="checkbox" value="" checked>Handling missing values.<br>      
<br>
<input type="checkbox" value="" checked>Plotting data with missing values.<br>      
<br>
<input type="checkbox" value="" checked>Interpolating missing values.<br>      
</fieldset>      
"""
end

# ╔═╡ 22934d73-3ad2-4e44-8a54-3b3ab6cea1a1
vspace

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
FreqTables = "da1fdf0e-e0ff-5433-a45f-9bb5ff651cb1"
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
Impute = "f7bf1975-0170-51b9-8c5f-a992d46b9575"
JSON3 = "0f8b85d8-7281-11e9-16c2-39a750bddbf1"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Logging = "56ddb016-857b-54e1-b83d-db4d58db5568"
Pkg = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[compat]
FreqTables = "~0.4.5"
HTTP = "~1.7.3"
HypertextLiteral = "~0.9.4"
Impute = "~0.6.10"
JSON3 = "~1.12.0"
LaTeXStrings = "~1.3.0"
Plots = "~1.38.2"
PlutoUI = "~0.7.34"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.0"
manifest_format = "2.0"
project_hash = "cbc3b9fe7af20c51685771e4cc776dbf9c66a792"

[[deps.AbstractFFTs]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "d92ad398961a3ed262d8bf04a1a2b8340f915fef"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.5.0"
weakdeps = ["ChainRulesCore", "Test"]

    [deps.AbstractFFTs.extensions]
    AbstractFFTsChainRulesCoreExt = "ChainRulesCore"
    AbstractFFTsTestExt = "Test"

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

[[deps.BSON]]
git-tree-sha1 = "2208958832d6e1b59e49f53697483a84ca8d664e"
uuid = "fbb218c0-5317-5bc6-957e-2ee96dd4b1f0"
version = "0.3.7"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "2dc09997850d68179b69dafb58ae806167a32b1b"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.8"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "PrecompileTools", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings", "WorkerUtilities"]
git-tree-sha1 = "44dbf560808d49041989b8a96cae4cffbeb7966a"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.11"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.CategoricalArrays]]
deps = ["DataAPI", "Future", "Missings", "Printf", "Requires", "Statistics", "Unicode"]
git-tree-sha1 = "1568b28f91293458345dabba6a5ea3f183250a61"
uuid = "324d7699-5711-5eae-9e2f-1d82baa6b597"
version = "0.10.8"
weakdeps = ["JSON", "RecipesBase", "SentinelArrays", "StructTypes"]

    [deps.CategoricalArrays.extensions]
    CategoricalArraysJSONExt = "JSON"
    CategoricalArraysRecipesBaseExt = "RecipesBase"
    CategoricalArraysSentinelArraysExt = "SentinelArrays"
    CategoricalArraysStructTypesExt = "StructTypes"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "e0af648f0692ec1691b5d094b8724ba1346281cf"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.18.0"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "cd67fc487743b2f0fd4380d4cbd3a24660d0eec8"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.3"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "67c1f244b991cad9b0aa4b7540fb758c2488b129"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.24.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "a1f44953f2382ebb937d60dafbe2deea4bd23249"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.10.0"

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

    [deps.ColorVectorSpace.weakdeps]
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.Combinatorics]]
git-tree-sha1 = "08c8b6831dc00bfea825826be0bc8336fc369860"
uuid = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
version = "1.0.2"

[[deps.Compat]]
deps = ["UUIDs"]
git-tree-sha1 = "886826d76ea9e72b35fcd000e535588f7b60f21d"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.10.1"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+1"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.CovarianceEstimation]]
deps = ["LinearAlgebra", "Statistics", "StatsBase"]
git-tree-sha1 = "9a44ddc9e60ee398934b73a5168f5806989e6792"
uuid = "587fd27a-f159-11e8-2dae-1979310e6154"
version = "0.2.11"

[[deps.DataAPI]]
git-tree-sha1 = "8da84edb865b0b5b0100c0666a9bc9a0b71c553c"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.15.0"

[[deps.DataDeps]]
deps = ["HTTP", "Libdl", "Reexport", "SHA", "p7zip_jll"]
git-tree-sha1 = "6e8d74545d34528c30ccd3fa0f3c00f8ed49584c"
uuid = "124859b0-ceae-595e-8997-d05f6a7a8dfe"
version = "0.7.11"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3dbd312d370723b6bb43ba9d02fc36abade4518d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.15"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Distances]]
deps = ["LinearAlgebra", "Statistics", "StatsAPI"]
git-tree-sha1 = "66c4c81f259586e8f002eacebc177e1fb06363b0"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.11"
weakdeps = ["ChainRulesCore", "SparseArrays"]

    [deps.Distances.extensions]
    DistancesChainRulesCoreExt = "ChainRulesCore"
    DistancesSparseArraysExt = "SparseArrays"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8e9441ee83492030ace98f9789a654a6d0b1f643"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4558ab818dcceaab612d1bb8c19cee87eda2b83c"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.5.0+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "466d45dc38e15794ec7d5d63ec03d776a9aff36e"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.4+1"

[[deps.FilePathsBase]]
deps = ["Compat", "Dates", "Mmap", "Printf", "Test", "UUIDs"]
git-tree-sha1 = "9f00e42f8d99fdde64d40c8ea5d14269a2e2c1aa"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.21"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "d8db6a5a2fe1381c1ea4ef2cab7c69c2de7f9ea0"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.1+0"

[[deps.FreqTables]]
deps = ["CategoricalArrays", "Missings", "NamedArrays", "Tables"]
git-tree-sha1 = "4693424929b4ec7ad703d68912a6ad6eff103cfe"
uuid = "da1fdf0e-e0ff-5433-a45f-9bb5ff651cb1"
version = "0.4.6"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "d972031d28c8c8d9d7b41a536ad7bb0c2579caca"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.8+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "27442171f28c952804dede8ff72828a96f2bfc1f"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.10"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "025d171a2847f616becc0f84c8dc62fe18f0f6dd"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.10+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "e94c92c7bf4819685eb80186d51c43e71d4afa17"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.76.5+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "Dates", "IniFile", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "37e4657cd56b11abe3d10cd4a1ec5fbdb4180263"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.7.4"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

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

[[deps.Impute]]
deps = ["BSON", "CSV", "DataDeps", "Distances", "IterTools", "LinearAlgebra", "Missings", "NamedDims", "NearestNeighbors", "Random", "Statistics", "StatsBase", "TableOperations", "Tables"]
git-tree-sha1 = "27da3d215f3ac8bd5dc2b0bb144b4a4367652462"
uuid = "f7bf1975-0170-51b9-8c5f-a992d46b9575"
version = "0.6.11"

[[deps.IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

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

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IterTools]]
git-tree-sha1 = "4ced6667f9974fc5c5943fa5e2ef1ca43ea9e450"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.8.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "a53ebe394b71470c7f97c2e7e170d51df21b17af"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.7"

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
deps = ["Dates", "Mmap", "Parsers", "SnoopPrecompile", "StructTypes", "UUIDs"]
git-tree-sha1 = "84b10656a41ef564c39d2d477d7236966d2b5683"
uuid = "0f8b85d8-7281-11e9-16c2-39a750bddbf1"
version = "1.12.0"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "60b1194df0a3298f460063de985eae7b01bc011a"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.0.1+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f689897ccbe049adb19a065c495e75f372ecd42b"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "15.0.4+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "f428ae552340899a935973270b8d98e5a31c49fe"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.1"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

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

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f9557a255370125b405568f9767d6d195822a175"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "2da088d113af58221c52828a80378e16be7d037a"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.5.1+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "7d6dd4e9212aebaeed356de34ccf262a3cd415aa"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.26"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

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

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "9ee1618cbf5240e6d4e0371d6f24065083f60c48"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.11"

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

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

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

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NamedArrays]]
deps = ["Combinatorics", "DataStructures", "DelimitedFiles", "InvertedIndices", "LinearAlgebra", "Random", "Requires", "SparseArrays", "Statistics"]
git-tree-sha1 = "6d42eca6c3a27dc79172d6d947ead136d88751bb"
uuid = "86f7a689-2022-50b4-a561-43c23ac3c673"
version = "0.10.0"

[[deps.NamedDims]]
deps = ["AbstractFFTs", "ChainRulesCore", "CovarianceEstimation", "LinearAlgebra", "Pkg", "Requires", "Statistics"]
git-tree-sha1 = "dc9144f80a79b302b48c282ad29b1dc2f10a9792"
uuid = "356022a1-0364-5f58-8944-0da4b18d706f"
version = "1.2.1"

[[deps.NearestNeighbors]]
deps = ["Distances", "StaticArrays"]
git-tree-sha1 = "3ef8ff4f011295fd938a521cb605099cecf084ca"
uuid = "b8a86587-4115-5ab1-83bc-aa920d37bbce"
version = "0.4.15"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+2"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "51901a49222b09e3743c65b8847687ae5fc78eb2"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "cc6e1927ac521b659af340e0ca45828a3ffc748f"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.0.12+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "a935806434c9d4c506ba941871b327b96d41f2bf"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.0"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "64779bc4c9784fee475689a1752ef4d5747c5e87"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.42.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "f92e1315dadf8c46561fb9396e525f7200cdc227"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.5"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "9f8675a55b37a70aa23177ec110f6e3f4dd68466"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.17"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "bd7c69c7f7173097e7b5e1be07cee2b8b7447f51"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.54"

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

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "37b7bb7aabf9a085e0044307e1717436117f2b3b"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.5.3+1"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "0e7508ff27ba32f26cd459474ca2ede1bc10991f"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.SnoopPrecompile]]
deps = ["Preferences"]
git-tree-sha1 = "e760a70afdcd461cf01a575947738d359234665c"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "5165dfb9fd131cf0c6957a3a7605dede376e7b63"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.0"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "2aded4182a14b19e9b62b063c0ab561809b5af2c"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.8.0"
weakdeps = ["ChainRulesCore", "Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "36b3d696ce6366023a0ea192b4cd442268995a0d"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.2"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "1d77abd07f617c4868c33d4f5b9e1dbb2643c9cf"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.2"

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

[[deps.TableOperations]]
deps = ["SentinelArrays", "Tables", "Test"]
git-tree-sha1 = "e383c87cf2a1dc41fa30c093b2a19877c83e1bc1"
uuid = "ab02a1b2-a7df-11e8-156e-fb1833f50b87"
version = "1.2.0"

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

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
git-tree-sha1 = "1fbeaaca45801b4ba17c251dd8603ef24801dd84"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.10.2"
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

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "3c793be6df9dd77a0cf49d80984ef9ff996948fa"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.19.0"

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    ConstructionBase = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "e2d817cc500e960fdbafcf988ac8436ba3208bfd"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.3"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "7558e29847e99bc3f04d6569e82d0f5c54460703"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+1"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[deps.WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "b1be2855ed9ed8eac54e5caff2afcdb442d52c23"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.2"

[[deps.WorkerUtilities]]
git-tree-sha1 = "cd1659ba0d57b71a464a29e64dbc67cfe83d54e7"
uuid = "76eceee3-57b5-4d4a-8e66-0e911cebbf60"
version = "1.6.1"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "801cbe47eae69adc50f36c3caec4758d2650741b"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.12.2+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "522b8414d40c4cbbab8dee346ac3a09f9768f25d"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.4.5+0"

[[deps.Xorg_libICE_jll]]
deps = ["Libdl", "Pkg"]
git-tree-sha1 = "e5becd4411063bdcac16be8b66fc2f9f6f1e8fe5"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.0.10+1"

[[deps.Xorg_libSM_jll]]
deps = ["Libdl", "Pkg", "Xorg_libICE_jll"]
git-tree-sha1 = "4a9d9e4c180e1e8119b5ffc224a7b59d3a7f7e18"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.3+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "afead5aba5aa507ad5a3bf01f58f82c8d1403495"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+0"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6035850dcc70518ca32f012e46015b9beeda49d8"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.11+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "34d526d318358a859d7de23da945578e8e8727b7"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.4+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8fdda4c692503d44d04a0603d9ac0982054635f9"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.1+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "b4bfde5d5b652e22b9c790ad00af08b6d042b97d"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.15.0+0"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "730eeca102434283c50ccf7d1ecdadf521a765a4"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.2+0"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "04341cb870f29dcd5e39055f895c39d016e18ccd"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.4+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "330f955bc41bb8f5270a369c473fc4a5a4e4d3cb"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.6+0"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "691634e5453ad362044e2ad653e79f3ee3bb98c3"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.39.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e92a1a012a10506618f10b7047e478403a046c77"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.0+0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "49ce682769cd5de6c72dcf1b94ed7790cd08974c"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.5+0"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "gperf_jll"]
git-tree-sha1 = "431b678a28ebb559d224c0b6b6d01afce87c51ba"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.9+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a68c9655fbe6dfcab3d972808f1aafec151ce3f8"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.43.0+0"

[[deps.gperf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3516a5630f741c9eecb3720b1ec9d8edc3ecc033"
uuid = "1a1c6b14-54f6-533d-8383-74cd7377aa70"
version = "3.1.1+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "141fe65dc3efabb0b1d5ba74e91f6ad26f84cc22"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.11.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "ad50e5b90f222cfe78aa3d5183a20a12de1322ce"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.18.0+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "93284c28274d9e75218a416c65ec49d0e0fcdf3d"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.40+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "814e154bdb7be91d78b6802843f76b6ece642f11"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.6+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9c304562909ab2bab0262639bd4f444d7bc2be37"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+1"
"""

# ╔═╡ Cell order:
# ╟─d7e2e472-6aae-4d12-ab51-d8ed83a2d201
# ╟─822f9a29-2599-4ad6-8902-ad9cc3aab263
# ╟─a2953e7d-a163-4e1f-8c2c-54a6c31e3d1e
# ╟─b9cb6ae7-67e2-4671-a49a-c6d2d10e6766
# ╟─64c2ee7d-a379-46d5-9bff-2152f57fa78c
# ╟─f7428550-fe1b-4749-ad1d-6810f7f136c1
# ╟─fcdb31f2-3f46-4959-99ef-5e1a2185dbf7
# ╟─b68a17d2-a3e7-4379-a441-1ca20a8970c5
# ╟─806aebe8-d7b8-4dde-b5a2-401ec631b444
# ╟─155f8b79-4163-4759-b4d6-2085be2dd77b
# ╟─f3165fda-e453-495e-bd30-1d181e0fbe0f
# ╟─026a08b7-3fdd-4b8d-92a8-2fa2bd9d5047
# ╟─2807c946-1aca-47b7-9c0f-e5d8e6270a0a
# ╟─7d7c0d8e-9beb-420b-b9c2-ec40b5d15d9f
# ╟─03003007-7690-4b3c-ae88-6070c69c5534
# ╟─195bfdc0-3d41-44bc-b1e1-354d09db5bbe
# ╟─d5d035fb-2756-4a01-b343-819e90f55c36
# ╟─597a33a1-e073-4280-87e5-dd69ecd6f862
# ╟─16a77cbc-77fb-4583-a002-7e4cbde93be9
# ╟─45293830-01ac-4d90-98b8-9718f286fcd7
# ╟─0124af48-f9ac-479f-a862-b6f77c168955
# ╟─10ccafb8-e444-4e87-876c-77a8e168ac25
# ╟─45e525b2-2be4-4ef0-83ca-36f3bc3a4730
# ╟─7f60398a-3c7a-4bc4-ab73-ba721b40905f
# ╟─b08c9d32-4c15-4dfa-a551-46bd79de5652
# ╟─49bfc368-94e2-42a2-b4d3-213336629b28
# ╟─a125d73b-25a7-4ac7-948c-49a81379ff6f
# ╟─859276d4-8b94-4e97-a7be-9e53a780c7d0
# ╠═971f2459-4f97-4e64-bd25-24d831a4d272
# ╠═38bb278a-f905-4168-ab76-7370f0d3137f
# ╟─2ed05013-c555-4206-aa3e-02acd8809254
# ╠═3307f16d-b553-49dd-bd36-c517456d36f7
# ╟─fb7e97cd-7aef-4578-82d5-6fbb66b23a93
# ╟─b820ae55-443d-4b76-8d11-472fc5569a3c
# ╠═7613e884-8392-4aff-991f-cdab4773f3aa
# ╟─e840176c-dd24-4d1e-a8c9-69f599674301
# ╠═5754bd79-5831-4c94-821b-d846bb6186f1
# ╟─8be0843e-af4a-4da2-ba5c-71c7604beb19
# ╟─425901b7-f1d1-4da9-a75e-ca3610d6799d
# ╠═46bb021a-a461-4848-b17b-2ba64fe9e295
# ╠═776cba9f-4cb9-4751-a183-543b1168c4a1
# ╠═baa4746d-dee2-46d3-90db-933af5eee599
# ╠═e1e59fdd-dc73-48cf-9108-28372ba50661
# ╟─a69db56e-2da7-48f8-b38d-ff732455e1ec
# ╟─0eab5cc7-2e6b-4c27-8ef6-e1ea1d946930
# ╠═c8b9dc7f-b4e0-4dbc-92ed-3cb300400669
# ╟─b6c80a1a-3150-45d4-a3b5-acd7b5e17de6
# ╟─9db3d9fc-c848-4348-b6e2-1d46c5333870
# ╟─5600d079-e494-455e-967c-c33ec7ed55a5
# ╟─abd517a3-3e7e-4ca3-952f-d2d0db312cb3
# ╟─ed1004db-2ce0-4e72-ae16-7cbf1e9b9d4b
# ╟─5ae5f571-372b-4f3f-a34b-a36246650309
# ╠═9ac46275-0163-4123-95b7-bc8076d06a41
# ╟─0ade2a38-f7dc-42dd-a89c-adff80ee7334
# ╟─cced3ddf-b1d2-4894-b1a9-1fce29ce19d8
# ╟─ca49f09d-10a1-41c9-99eb-263319cc2de7
# ╟─4690a578-2089-495a-af77-180aa4e1e143
# ╠═98956a7a-4e81-4d69-952e-1d387a9e8056
# ╟─dab2d612-71e0-48df-83d0-da91bd681eb6
# ╠═e9462030-da21-47ce-9a88-be35b54e09fe
# ╟─3f657ea2-b3f6-4281-97fb-d9b22b7475fd
# ╟─a30f3bbd-326d-481d-92a5-dfd24c9b1759
# ╟─52db31ca-ba68-4e5b-b504-d71ab8dbbe5e
# ╟─82c2c7f4-3e69-4800-bb2d-2b82d2403145
# ╠═0084413a-acae-4ccb-a38a-93c48243cfbc
# ╟─5fdb6824-5508-4d8e-a947-6b68fa1f9c04
# ╠═edd1716f-a882-4678-982e-4ad1796c9ad4
# ╟─6a4c45b1-c5ab-48c1-b2d0-77f0ec9c2cc0
# ╟─bc4a619f-bda2-4eaa-b56a-3ea9e2b93fc7
# ╠═1d0dd4b6-6189-4986-a852-25a9e0177a0c
# ╟─288ce3c2-1a63-446e-9fd1-1c64fe752835
# ╟─62fb7d1d-fbd1-431b-9761-bb4b82b63a8d
# ╠═8da702ce-fa95-4d97-882e-9a13a9b5c381
# ╟─4d7adfd5-7817-4cbb-a842-b3008d886801
# ╟─d96c02f0-1e62-40ad-a691-10ed1d935798
# ╟─4cc01d2f-e046-4eea-b945-6f54db2e7711
# ╟─c8299e05-a65e-4393-b170-3a317594604a
# ╟─0896da60-d72f-4474-b5ef-f1e95eb59273
# ╟─406ff58f-6658-4d9a-8d9f-e25ec4a3f07a
# ╟─1c1c0d05-94f6-4fe8-a7c6-c5d2acd4ef20
# ╠═c268b7b0-609f-475a-9358-e99bb1a1284d
# ╠═bcfd13c1-7f34-4f94-ae70-7409c4d3383c
# ╠═8788d094-c3f5-4855-b32c-42d7d37b60a3
# ╟─81db7812-75d4-4f83-bd54-96cca465e38c
# ╟─d22920d4-38db-4a25-945e-713b274ae18a
# ╠═c48f2bc6-1029-440a-86a7-4a17da90ba4b
# ╠═c20b673f-676e-4004-9016-dd7837585df6
# ╟─32f2a06d-1a92-440e-9bc9-93c492719df1
# ╟─3e8c5879-86c1-46b8-acf4-6fb8d347637c
# ╟─8c3c65e0-dad5-4d67-80c6-cf798486a216
# ╠═88401a57-76dd-4f99-8515-522a1f6edfe7
# ╟─5a92e307-4b31-4818-abd9-c596ca331ba7
# ╟─1be5bbaf-16d4-4d56-8f9d-8d44fc2ac651
# ╠═0c7ab1ce-0fbd-4a84-9735-e07c463bff79
# ╠═81883771-459b-4c7c-a529-457e5868fb4b
# ╟─97455b0e-da65-4dd7-9811-794a4c1c74c0
# ╟─dd053f81-18ad-4bc3-8b19-a9c1c0ebd1a1
# ╟─4e378fc9-b49f-4d57-851b-a735fadd5731
# ╟─f6303f92-d07d-4dad-97ae-9d1bc89b8ba9
# ╠═17feaa79-2394-4cc8-995e-dec9510199e2
# ╟─d73f83b6-9d32-4c47-93dd-07856660232f
# ╟─6b063ab8-8e08-4711-9d45-4f8d890b23d3
# ╠═d7bda76c-9a0c-4760-9160-316f9bed705e
# ╟─177c6de4-7da1-4b89-ae51-f508341951e5
# ╟─c576246c-62a7-449c-8653-8c21d5c7d1ef
# ╠═5412d08d-9232-44fe-aaa6-4970e0795bc9
# ╟─41042388-1dd4-4460-941d-a16157432465
# ╟─44968590-9898-49f6-925c-864c08a59b76
# ╠═6329e073-186a-47f2-b6bc-cb18b963a92a
# ╟─9104b977-144a-47bb-8b90-1864d9de9a47
# ╟─44a7664c-a09a-43fe-a1d1-7f80a718074e
# ╠═2d47eead-9131-44aa-b116-cc1688999945
# ╟─01e35936-1d6d-4ce8-bf38-c80fc22ca825
# ╟─53fa5b3c-f3a4-433e-9515-d8919bfc1f18
# ╟─e3ec2296-6622-4aac-a42c-846d826448f8
# ╟─22934d73-3ad2-4e44-8a54-3b3ab6cea1a1
# ╟─35e6b686-2daa-40f6-b348-6987406ba95b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
