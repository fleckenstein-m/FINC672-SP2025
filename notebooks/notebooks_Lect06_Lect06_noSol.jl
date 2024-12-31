### A Pluto.jl notebook ###
# v0.19.9

using Markdown
using InteractiveUtils

# ╔═╡ 9a5b04d9-9740-4ead-b8f2-aab54f1281de
html"""
	<p align=left style="font-size:32px; font-family:family:Georgia"> <b> FINC 672: Workshop in Finance - Empirical Methods</b> <p>
	"""

# ╔═╡ f9f2216a-3d43-4846-8733-879ba5075407
html"""
	<p style="padding-bottom:1cm"> </p>
	<div align=center style="font-size:25px; font-family:family:Georgia"> FINC-672: Workshop in Finance - Empirical Methods </div>
	<p style="padding-bottom:1cm"> </p>
	<p align=center style="font-size:25px; font-family:family:Georgia"> <b> Tabular Data </b> <p>
	<p style="padding-bottom:1cm"> </p>
	<p align=center style="font-size:25px; font-family:family:Georgia"> Spring 2024 <p>
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
	<input type="checkbox" value=""> Tabular Data in Julia using DataFrames
	<br>
	<input type="checkbox" value=""> Load and Save Files
	<br>
	<input type="checkbox" value=""> Indexing Tabular Data
	<br>
	<input type="checkbox" value=""> Filter and Subset DataFrames
	<br>
	<br>
	</fieldset>      
	"""
end

# ╔═╡ 15cd6dec-49c7-4699-b44c-3698dcf8728c
vspace

# ╔═╡ f14fe56a-6ad8-44e4-bd34-a242305a614d
md"""
# Tabular Data
"""

# ╔═╡ 16ff8aed-2440-4a50-b57b-5554e8bb3438
md"""
- Data comes mostly in _tabular_ format.
- By tabular, we mean that the data consists of a table containing rows and columns.
- Columns are usually of the same data type, whereas rows have different types.
- The rows, in practice, denote observations while columns denote variables.
- For example, we can have a table of TV shows containing in which country it was produced and our personal rating.
- To work with tabular data, we use the `DataFrames` package.
"""

# ╔═╡ bc94035a-795b-4d08-aab2-87519b4ffd65
md"""
# Setting up DataFrames
"""

# ╔═╡ 1b2a5e1a-9ed1-4ba4-bac5-eeb3b823988d
md"""
- First, we need to step up the Julia `DataFrames` package.
"""

# ╔═╡ 2b3b2b5a-55e8-4d50-b084-095482b9aa3b
using DataFrames

# ╔═╡ a4ada2ab-9702-4d93-a60d-27f041bdd903
vspace

# ╔═╡ 745eba40-0c86-4eb5-bdd3-20dd6ebd2429
md"""
# Motivating example
"""

# ╔═╡ 4225bb56-8b49-4f78-8ea6-91958174ad07
md"""

| Name  | Country | Rating |
|:------|:------|:------|
| Game of Thrones | United States | 8.2 |
| The Crown | England | 7.3 |
| Friends | United States | 7.8 |
| ... | ... | ... |

- Here, the dots mean that this could be a very long table and we only show a few rows.
"""

# ╔═╡ 58a0f0b3-29c1-4d52-91d3-b847ad2223b0
md"""
#
"""

# ╔═╡ fb9d346d-9e52-4e58-9a74-b787b7885063
md"""
- When we analyze data, often we come up with interesting questions about the data, also known as data queries.
- Examples of, so called queries, for this data could be:
  - Which TV show has the highest rating?
  - Which TV shows were produced in the United States?
  - Which TV shows were produced in the same country?
- To answer questions like "Which TV show has the highest rating?" we use _data transformation_.
"""

# ╔═╡ 64a4e4f5-e742-4af5-b984-ee16795c98c0
md"""
#
"""

# ╔═╡ a6fda050-c8c4-4d91-82d2-2c3e6bbb0de3
md"""
- Let’s take the first three shows in the table and see how we model this using DataFrames in Julia.
- In a Julia `DataFrame`, we would set this up as follows in the next section.
"""

# ╔═╡ 85ada988-94ee-4c7f-b025-cbc178439238
vspace

# ╔═╡ 6e6b7860-f321-4e9c-8ec7-094421a5c4e5
md"""
# DataFrame Constructor
"""

# ╔═╡ ba4f6ec4-1187-4cbc-9392-f667dbec1727
md"""
- We construct a `DataFrame` by simply passing vectors as arguments into the `DataFrame` constructor.
- You can come up with any valid Julia vector and it will work as long as the vectors have the same length.
- Duplicates, Unicode symbols and any sort of numbers are fine. 
"""

# ╔═╡ cf5981d0-56e0-4cca-b442-406a28207f29


# ╔═╡ d9615428-0165-4fa0-b5a7-4de1f97092d4
md"""
#
"""

# ╔═╡ c0aaf25f-4402-487b-b7ed-d13e2b0edd4c
md"""
- As a second example, suppose we have data on bonds of four firms with (full) price and coupon rate (expressed as percentages, and paid semi-annually).
"""

# ╔═╡ 6a5c482b-82f2-46b7-a915-6893bb8d2b0b
md"""
| firm  | price | coupon  | 
|:------|:------| --------|
| firmA | 70.0 | 5.00 | 
| firmB | 80.0 | 3.75 | 
| firmC | 100.0 | 2.50 | 
| firmD | 110.0 | 2.00 | 

- Here, the column with the firm name (_firm_) has type `string`,  price (_price_) and coupon rate (_coupon_) have type `float`.
"""

# ╔═╡ e4800876-e5ba-4131-a81c-97c23e792cc3
md"""
#
"""

# ╔═╡ 811d4aa9-0518-4a43-85c6-a2c0c5eec8e0
md"""
- With DataFrames, we can define a DataFrame to hold our tabular data.
- The following code gives us a variable `df` containing our data in table format
"""

# ╔═╡ 2cf46eeb-9373-46a5-811a-aad1ceae25b6


# ╔═╡ b0690699-6119-4463-a18a-092f009c2639
vspace

# ╔═╡ 7d4510a8-45a0-4d4c-b819-c7f838948be4
md"""
- Another example
"""

# ╔═╡ 06e308e4-524a-4d2f-8101-9126724f7261
# DataFrame(σ = ["a", "a", "a"], δ = [π, π/2, π/3])

# ╔═╡ 909aa38a-1eb4-406b-b8ed-c731675af1f1
vspace

# ╔═╡ 2c6e1e44-a405-4503-bb04-702beccbf435
md"""
# Loading and Saving Files
"""

# ╔═╡ fb555768-69ac-4614-8011-bfc5a39cddad
md"""
- We need to be able to store files and load files from disk.
- We focus on CSV and Excel file formats since those are the most common data storage formats for tabular data.
- Comma-separated values (CSV) files are are very effective way to store tables.
- CSV files have two advantages over other data storage files.
- First, it does exactly what the name indicates it does, namely storing values by separating them using commas `,`
- This acronym is also used as the file extension (you save your files using the ".csv" extension such as "myfile.csv").
- To demonstrate how a CSV file looks, we can install the `CSV.jl` package.

"""

# ╔═╡ 3b9d1877-bdfe-4a02-8208-0d62a2a5f469
md"""
#
"""

# ╔═╡ 23ed4509-0d6d-4da2-971b-8e17aff2227a
md"""
- We first need to load the `CSV.jl` package.
"""

# ╔═╡ 64bf07f5-6bd3-4325-bb5e-41e2e606eeda
using CSV

# ╔═╡ 1f0a6c13-e8bb-48d4-9c8b-d783a7cb2648
vspace

# ╔═╡ 1535d83b-f8a0-457f-9acb-ea66d08e5196
md"""
# Writing data to CSV files
"""

# ╔═╡ 71c441b2-fca3-4382-bf07-5963c71a73a3
md"""
- We can now use our previous data on bonds and write it to CSV.
"""

# ╔═╡ 7e952365-3c23-48c1-a0b1-28f49668471a


# ╔═╡ 76bf4ae7-ac48-4277-aaa1-6bad92e06a20


# ╔═╡ 2557e1b2-963f-4ba0-9535-88adc7a4b82f
vspace

# ╔═╡ 6439040e-06e7-463a-8ac2-0fa08d2d501d
md"""
# Reading Data From CSV Files
"""

# ╔═╡ 7060827d-47a2-457e-a42e-2e93a9473e34
md"""
- Next, let’s read the data from the CSV file we have just created and put it into a DataFrame.
- Conveniently, CSV.jl will automatically infer column types for us.
  - Here we use the |> operator to "send" the CSV file into a DataFrame
"""

# ╔═╡ 67c4c239-4f6e-44cc-a555-b5e6d6cc5aac


# ╔═╡ 05878d95-1307-49a9-b6cd-ea39c18fa38e


# ╔═╡ f43d5098-3de4-4391-aa03-860aa140a35b
vspace

# ╔═╡ 4585b547-af4a-4df1-b184-77d715a0c1f3
md"""
# Writing data to Excel files
"""

# ╔═╡ 0270b474-c4e9-41cf-9235-daf89aefba16
md"""
- Let’s now write the bonds data to an Excel file.
- First, we need to load the `XLSX.jl` package.
"""

# ╔═╡ d5b567d3-0444-48a5-9a40-30a36a9d69e3
using XLSX

# ╔═╡ 6dd4c140-2172-4f5f-954a-40112fd43283
md"""
- Here, we need to provide the tabular data (data) and the column names (cols) individually to `writetable`.
- We get the data by collecting each column. This is what `collect(eachcol(df))` does.
- We get the column names by using `names(df)`.
"""

# ╔═╡ 67e6c75e-5bc8-4794-a8f0-4a447056d831
let

	
end

# ╔═╡ e3a660fb-7d82-40b9-9ff9-f62d7701006e
vspace

# ╔═╡ 57cedb4d-1448-42f7-b15c-5f2e0eb29d96
md"""
# Reading Data From Excel Files
"""

# ╔═╡ 2b8c7816-c887-4e32-86f0-8b1ff9d90df2
md"""
#
"""

# ╔═╡ d4f555fe-481a-4f93-a421-a1a37c770062
md"""
- Let’s now read the bond data in the Excel file "bond.xlsx" into a DataFrame.
"""

# ╔═╡ b00bbb6d-c453-4b89-b6ed-ae301a980fc8


# ╔═╡ a1037974-9df4-4b6c-a5a4-dedf2596090f
md"""
#
"""

# ╔═╡ 8780b70a-a35c-47d0-a348-a33978b775fa
md"""
- Let’s continue to use our bond data as an example.
- Suppose we want to know all names of the firms in our dataset.
- To retrieve a vector for firm names, we can access the DataFrame with the `.` operator.
"""

# ╔═╡ ed97df42-fa3d-4417-8e33-c15686852087


# ╔═╡ 1d29d759-b491-4ca8-ba7a-e67a9ced4bb5
md"""
#
"""

# ╔═╡ bfdb4954-2edd-404f-9c01-55b31b292d49
md"""
- Alternatively, we can index a DataFrame much like an Array with symbols and special characters. The second index is the column indexing.
- Here, we are using the `!` operator to indicate that we want to get all rows.
"""

# ╔═╡ ec7f0750-7e94-4ebf-a409-43f16dbeefb6


# ╔═╡ fc61265a-5e2e-4532-9693-2609de82242a
md"""
#
"""

# ╔═╡ 0c15ad5f-b1f6-4eb4-8258-0fb8f33deb9d
md"""
- Let’s suppose, you want to get the price and coupon rate for the second bond in our data.
- For any row, in our case the second row, we can use the first index as row indexing (in the codeblock below, this is the 2 before the comma). 
- The colon `:` just means that we want to get all columns (in our case the firm name, bond price, and coupon rate).
"""

# ╔═╡ 3a4e33ae-53c8-428d-b5d9-ee0b0db8affa


# ╔═╡ 79a55f86-765f-40cb-a377-9660525780c9
md"""
#
"""

# ╔═╡ 8552dd0f-d500-4602-9a6b-6f845bbd2d13
md"""
- How would we get the price and dividend for the third stock in our data? 
- Simply use a 3 as the row index.
"""

# ╔═╡ 7fc46967-6521-4bc2-a9f9-612a3a2e84c7


# ╔═╡ 946ae8a0-e98c-4e1e-b7c1-a2a1fc894df1
md"""
#
"""

# ╔═╡ b97391ca-ea41-4f58-9c36-8bf759c08953
md"""
- How about the firm name for the second and the third bond?
"""

# ╔═╡ 39011a8f-a6fc-40e3-b9dc-2da6170e5abc


# ╔═╡ 5ef42bbc-140e-4442-91cc-9054461eca4e
md"""
#
"""

# ╔═╡ 39db800a-76fe-43b6-8ca0-7add96940ec5
md"""
- How can we get the price and coupon rate of the second and third bond?
- Note that here, we write the column names with a colon `:` and put them between brackets (`[` and `]`) and separate the column names with a comma `,`
"""

# ╔═╡ 79d80c73-096d-4248-b8b9-b58180398d80


# ╔═╡ 3ed2e1b2-6708-4c64-bbc6-6fd4c43f3804
vspace

# ╔═╡ 6ec3099b-bf0e-4ffe-8947-689905d44de3
md"""
# Filter and Subset DataFrames
"""

# ╔═╡ b9307cee-5af6-4ad1-a3f2-18f59560cf7f
md"""
- The DataFrame functions filter and subset subset allow us to "filter" out rows from  DataFrame, or, in other words, allow us to take a subset of a DataFrame.
- We can filter rows by using `filter(source => f::Function, df)`
- Let’s illustrate this with an example using our bond data from before
"""

# ╔═╡ 1c7c7c24-cde9-4a24-bada-51a77b35970f
md"""
#
"""

# ╔═╡ 4ffc3a13-aa4e-42b4-98f6-36c5ab7f9c40
md"""
- Let’s find the bond that is trading at par (i.e. its price is 100.0).
"""

# ╔═╡ 80ccbebe-bc6d-4d8a-9ce8-e353d72967d2


# ╔═╡ bb68e71b-a330-4a7a-99ed-600c77e38237
md"""
#
"""

# ╔═╡ 2b6f1d3c-65b9-4088-8720-0148847d6ce0
md"""
- Let's break this down: `filter(:price => (x->x==100.0), df)`
- We take the price column and use the `=>` operator to pass this column to a function.
- Why? Because we are looking for the bond with price=100.0.
- Then, we use a so-called anonymous function to check when the bond price is equal to 100.0.
- This is the (x->x==100.0).
- The filter function then returns the row for which the condition x==100.0 is true.
"""

# ╔═╡ d6b79c1c-61d2-4de3-ac7a-0abedde9ed1d
md"""
#
"""

# ╔═╡ 8e506331-a0dc-4c56-a879-f1d965abde02
md"""
- We often want to subset data using multiple conditions.
- For instance, we would like to know which bond trades at a discount to par and has a coupon rate greater than four percent.
- In these cases, we do not use an anonymous function as in the previous example `((x->x==100.0))`, but we define a function.
- To illustrate this, let’s use a function in the previous example.
"""

# ╔═╡ 88fb44cc-fbe5-4685-9e9c-3576bb65c9e8
md"""
#
"""

# ╔═╡ 04de9d16-7597-40f0-b275-d75d12a61c10


# ╔═╡ cda99e9d-a83e-4247-b5ea-566c7350323b
md"""
#
"""

# ╔═╡ ca98e338-0fa2-4c4a-8f3e-8d0b8a9e3f70


# ╔═╡ b7e90ebc-029d-4fa6-9b84-8a6c68a6ea00
md"""
#
"""

# ╔═╡ 43b423f7-208d-48cc-b767-1117bd745337
md"""
- We can build a more complex filter.
- Suppose we want to get the bonds that trade at a discount to par value and with coupon rate of at least four percent.
- Let’s first build the function
"""

# ╔═╡ a9868e63-6c6e-4be7-a3ad-86728622413c


# ╔═╡ cec1bf13-e2d7-4f06-a882-d858b45f344c
md"""
#
"""

# ╔═╡ 79acbcdf-9737-4972-ba3a-0ab8fac23fda
md"""
- Now, let’s use our `getBond` function.
"""

# ╔═╡ 5ea69e41-4459-486c-b369-5dcbd9dd9531


# ╔═╡ cc093687-122d-410e-9ff0-269534ed6880
md"""
#
"""

# ╔═╡ 2f61823b-f59d-447a-b9fa-da0f0df88b03
md"""
- Let's break this down: `df2 = filter([:price, :coupon] => ( (x,y)->getBond(x,y)), df)`
- Here, we need to check the price (price) and coupon rate (coupon) of the bonds.
- We get these two columns by using the colon `:` operator and by putting them between brackets (`[` and `]`), seperated by a comma `,` i.e. `[:price, :coupon]`.
- We then use `=>` to "send" these two columns to our function.
- To call our function, we need two inputs: the price and the coupon rate.
- Thus, we use `(x,y)` followed by `->`.
- This _send_ these two inputs to our function `getBond(x,y)`.
"""

# ╔═╡ 8312cb85-fd05-4680-ba39-adcd64b61c9c
vspace

# ╔═╡ 8a8810ca-2609-408a-a271-80ed99622ff0
md"""
# Selecting Columns
"""

# ╔═╡ 79f28808-74b3-4d67-9182-bd3fa3cd95dd
md"""
- We select specific columns using the function `select`.
- To illustrate, let's suppose we have the following bond dataset.
- Note that we have the same bonds as before, but we now know the year when the bonds were issued and the year of maturity of the bonds. We also have bid and ask prices.
"""

# ╔═╡ 85b8d270-a6b0-45be-a4af-4404ef84e443
md"""
#
"""

# ╔═╡ 9fa6b97b-c18e-4dd1-b3e3-f04bb6ed0c9c
md"""
| firm  | bidprice  | askprice  | coupon  | issueyear  | maturityyear |
|:--------|:--------|:--------|:--------|:--------|:--------|
| firmA  | 69.00  | 70.0  | 5.00  | 2018  |  2023 |
| firmB  | 79.50  | 80.0  | 3.75  | 2020  | 2030 |
| firmC  | 99.75  | 100.0  | 2.50  | 2021 | 2024 |
| firmD  | 109.00  | 110.0  | 2.00  | 2015  |  2025 |
"""

# ╔═╡ a46253a7-5e84-474c-a49b-8c72755f1bf2
md"""
#
"""

# ╔═╡ e9e0f4ee-c777-4f93-86c2-8529d5b326ba
# begin
# 	frm = ["firmA","firmB","firmC","firmD"]
# 	pxbid = [69.00, 79.50, 99.75, 109.00]
# 	pxask = [70.0, 80.0, 100.0, 110.0]
# 	cpn = [5.00, 3.75, 2.50, 2.00]
# 	issyr = [2018, 2020, 2021, 2015]
# 	matyr = [2023, 2030, 2024, 2025]

# 	df2 = DataFrame(firm=frm, bidprice=pxbid, askprice=pxask, coupon=cpn, issueyear=issyr, maturityyear=matyr)
# end	

# ╔═╡ fe1a37df-fc03-4de8-a56f-77958667f109
md"""
#
"""

# ╔═╡ bd561d17-3178-4ee8-a21d-38ee0bc1e579
md"""
- First, we want to select the column with all firm names.
  - Note that our DataFrame `df2` comes first, i.e. select(df,...).
  - Also note that we could get the same result by using `df.firm`.
  - However, `select` is powerful when we select multiple columns.
"""

# ╔═╡ 6ad1466e-df8e-4a58-b35b-b93b99f4b383


# ╔═╡ 42806369-b240-4675-83fe-6b4582dcc78d
md"""
#
"""

# ╔═╡ 1622706c-5c3d-4474-99fe-a9886d81e67b
md"""
- Next, suppose we want to get back the original bond dataset that we started with (i.e. where we have the firm name, askprice, and the coupon rate).
"""

# ╔═╡ 6f8ddf4b-26e8-4065-9ba3-221f0c4965a1


# ╔═╡ 7090ff64-7f19-4043-8892-ce2700a156f5
md"""
#
"""

# ╔═╡ fe0ed40b-02be-4b64-9c1d-c7721d2ecafe
md"""
- Let's break this down: `select(df, [:firm, :askprice, :coupon])`.
- As before, we use the column names with a colon `:` and put them between brackets (`[` and `]`), separated by a comma `,`
- Then we simply use this as the second argument after `df2` in the function call to select.
"""

# ╔═╡ f3725b7e-59fa-4b11-a827-d01d643065bf
md"""
#
"""

# ╔═╡ ab4fe12a-0396-4b16-a4e2-713435415173
md"""
- Suppose now that we want all columns, except the issue year.
- To exclude one (or more columns), we use `Not()` as shown below.
"""

# ╔═╡ 543d6721-3cd7-4337-bfc9-0073bf98fcfc


# ╔═╡ 2b60596a-bd59-4791-b516-ff68f29bd75e
md"""
#
"""

# ╔═╡ 028b1008-89e3-4f73-abb3-e4c9b57c7474
md"""
- What if we want all columns except the issue year and the bid price?
  - Note that we need to put the two column names between brackets (`[` and `]`), separated by a comma `,`
"""

# ╔═╡ 1a7658d3-dfd1-42d7-bc48-4248ba0fb91b


# ╔═╡ c739ced0-a36d-499a-b7ad-2a4a211b4146
md"""
#
"""

# ╔═╡ 1ea624b2-c51c-4187-817c-ed51eb431706
md"""
- We can also "mix and match"
- Suppose we want the firm name, all other columns, but not the bid price.
"""

# ╔═╡ 62f483d7-a163-48cd-b256-da5f66866467


# ╔═╡ 68753596-3093-4ea8-9256-e49090f6625e
md"""
#
"""

# ╔═╡ d937f6b8-e24b-41f8-9445-001091006445
md"""
- Can we rename columns using the `select` function?
- The answer is yes. Suppose we want to rename the firm column to firmname.
"""

# ╔═╡ 5efbd671-a417-4f04-9819-bd702f739019


# ╔═╡ 7c3a4465-0748-45c8-9f59-4c1bec3d37c1
md"""
#
"""

# ╔═╡ 30bede84-9998-4c01-ae0e-0f5028cf867e
md"""
- Let's break this down: `select(df, :firm => :firmname, :)`
- The first part `:firm => :firmname` means that we assign the new name "firmname" to the existing column firm.
- The colon `:` (which is separated by a comma `,`) means that we want to select all other columns as well (except the one we just renamed).
"""

# ╔═╡ 55e42d18-9457-47d7-813e-789f5d2757b5
vspace

# ╔═╡ 01eea949-1bd1-4255-803e-ac06fdca3cee
md"""
# Missing Data and Data Types
"""

# ╔═╡ 2291b793-51c9-40a9-b508-a3ac9a5611b4
md"""
- `CSV.jl` will typically work quite well in guessing what kind of types our data have as columns.
- However, this won’t always work perfectly. Let’s see how we fix wrong data types and what data types we should use.
- We work with the following bond dataset.
"""

# ╔═╡ fe90ad75-1955-4bba-ba76-1e34ac703a00
md"""
#
"""

# ╔═╡ cf82d0b8-ee97-4590-99a9-a4d464309642
md"""
| id | firm | bidprice | askprice | coupon | issuedate | maturitydate | 
|:-------|:-------|:-------|:-------|:-------|:-------|:------- |
| 1 | firmA |  69.00 | 70.0 | 5.00 | 31-01-2018 | 31-01-2023 |
| 2 | firmB | 79.50 | 80.0 |  3.75 |   31-03-2020 | 31-03-2030| 
| 3 | firmC | 99.75 | 100.0 | 2.50 | 30-09-2021 | 30-09-2024| 
| 4 | firmD | 109.00 | 110.0 |  2.00 |  31-10-2015 | 31-10-2025 |
"""

# ╔═╡ 2527be95-99c1-4f47-8974-5c98b24e243b
md"""
#
"""

# ╔═╡ 0e6a1a35-1f58-4215-b747-dd3a8e33c041
# begin
# 	idno3 = ["1","2","3","4"]
# 	frm3 = ["firmA","firmB","firmC","firmD"]
# 	pxbid3 = [69.00, 79.50, 99.75, 109.00]
# 	pxask3 = [70.0, 80.0, 100.0, 110.0]
# 	cpn3 = [5.00, 3.75, 2.50, 2.00]
# 	issdt3 = ["31-01-2018","31-03-2020","30-09-2021","31-10-2015"]
# 	matdt3 = ["31-01-2023","31-03-2030","30-09-2024","31-10-2025"]

# 	df3 = DataFrame(id=idno3, firm=frm3, bidprice=pxbid3, askprice=pxask3, coupon=cpn3, issuedate=issdt3, maturitydate=matdt3)
	
# end

# ╔═╡ 71ea3183-2b19-4f7e-b0ef-cf5e6da1f935
md"""
#
"""

# ╔═╡ 81a0c6a1-c53f-4c2c-9f8a-47b856ea83a5
md"""
- What could be wrong here?
- Let’s try to sort the DataFrame by issue date.
- We do this by using the function sort as follows.
"""

# ╔═╡ c4f3e633-def1-4116-a6eb-fa016f789590


# ╔═╡ c4a5dbe4-e09a-463e-afa9-acc474b2eeac
md"""
#
"""

# ╔═╡ d88ffa35-4dd7-42d9-acc2-0ecc09e17be5
md"""
- What went wrong? 
- Because the issue date column has the wrong type, sorting does not work correctly.
- To fix the sorting, we can use the Date module from Julias standard library.
- To illustrate convert a String to Date, consider the first date "31-01-2023".
"""

# ╔═╡ 6fa7bd95-446e-41d8-91cb-71b24a66bfa7
md"""
#
"""

# ╔═╡ 93d9f7a2-07cf-495e-812d-ce7d6da913c6
md"""
- First, we need to load the `Dates.jl` package.
"""

# ╔═╡ 76c3b5f0-12eb-4618-b4c0-ef2214e19ef4
using Dates

# ╔═╡ 73eaeda6-9b21-4ab8-90a8-cb1ef03a5d41
let

	
end

# ╔═╡ b93c159e-b4ec-4e7a-9443-d425ef28480b
md"""
#
"""

# ╔═╡ f57e7d93-9817-4969-bced-b3a6cf64c769
md"""
- Next, let’s convert all issue date to Julia Date type.
- To do this, we first get all issue dates in a Vector.
- Then we broadcast the Date constructor.
- In the last step, we write the converted dates back to our DataFrame `df3`
"""

# ╔═╡ e06d806b-9194-4c7c-bac1-19d7acdfffc3


# ╔═╡ 90133060-8d12-47e8-8613-f7f412e51e5a


# ╔═╡ 0391e3ca-36f3-40d0-b073-81ff3678834f


# ╔═╡ 8bdba3f5-9e78-405a-9fe2-c5aca82974b2
md"""
#
"""

# ╔═╡ c48276fd-9dfe-45d0-afc0-f275af52f993
md"""
- Likewise, we repeat the same operations for the maturity dates.
- Note, we will learn how to do this more quickly when we talk about data transformation function in DataFrames.
"""

# ╔═╡ f1757c8a-70da-4963-8756-08592cd318e1


# ╔═╡ 8dc61e9c-ba5d-4edc-b2ca-5a7f01b609aa


# ╔═╡ 2313ba7a-8471-4c4e-9d8f-453067aee623


# ╔═╡ 7e681a42-0df2-48a8-be67-dc9b3e9d251f
md"""
#
"""

# ╔═╡ f148fd7a-0a24-45b3-b84f-d4eb5fe30390
md"""
- We are not done yet. Notice that the id column is also recognized as a String.
- An _id_ variable should be of categorical type.
- Julia helps us here since it implements functionality for categorical data.
- All we need to do is load `CategoricalArrays.jl`
"""

# ╔═╡ c7722e6b-18b1-45e5-a642-479d9e4f0b63
using CategoricalArrays

# ╔═╡ c03cbf18-38da-4e1a-a912-d40aaeeff657
md"""
#
"""

# ╔═╡ 0e5132b8-4327-4757-aff6-808db28f5536
md"""
- Now we are all set to convert the id column to categorical
- Here we are using a shortcut by directly making the conversion on our DataFrame.
- Note: We must use the ! operator. 
- This ensures two things. First, recall that `!` gives us the entire id column.
- Second, by using `!` we change the contents of our DataFrame `df3` directly (or in place).
"""

# ╔═╡ 26ab9aa9-1751-429d-bb23-dfe493ce4cf5


# ╔═╡ 8f1cce3b-13ca-4b90-9a72-06b135b1690c
md"""
#
"""

# ╔═╡ 259a77e2-091b-4ac9-a938-c2e28fb8bf6e
md"""
- Finally, let’s sort our DataFrame by the issuedate column.
"""

# ╔═╡ b07ca161-c3ad-4a17-bff2-87494487d5ad


# ╔═╡ 3c46d36d-417c-44fd-86bc-dce2e52c1f9c
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
	<input type="checkbox" value="" checked> Tabular Data in Julia using DataFrames
	<br>
	<input type="checkbox" value="" checked> Load and Save Files
	<br>
	<input type="checkbox" value="" checked> Indexing Tabular Data
	<br>
	<input type="checkbox" value="" checked> Filter and Subset DataFrames
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

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
CategoricalArrays = "324d7699-5711-5eae-9e2f-1d82baa6b597"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Logging = "56ddb016-857b-54e1-b83d-db4d58db5568"
Pkg = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"
XLSX = "fdbf4ff8-1666-58a4-91e7-1b58723a45e0"

[compat]
CSV = "~0.10.7"
CategoricalArrays = "~0.10.7"
DataFrames = "~1.4.3"
HypertextLiteral = "~0.9.4"
LaTeXStrings = "~1.3.0"
PlutoUI = "~0.7.49"
XLSX = "~0.8.4"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.0"
manifest_format = "2.0"
project_hash = "35eb6606a0df3c60d01f3c162dfcaf7e057dc821"

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

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "PrecompileTools", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings", "WorkerUtilities"]
git-tree-sha1 = "679e69c611fff422038e9e21e270c4197d49d918"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.12"

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
git-tree-sha1 = "75bd5b6fc5089df449b5d35fa501c846c9b6549b"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.12.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+1"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Random", "Reexport", "SnoopPrecompile", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "d4f69885afa5e6149d0cab3818491565cf41446d"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.4.4"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "ac67408d9ddf207de5cfa9a97e114352430f01ed"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.16"

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

[[deps.EzXML]]
deps = ["Printf", "XML2_jll"]
git-tree-sha1 = "380053d61bb9064d6aa4a9777413b40429c79901"
uuid = "8f5d6c58-4d21-5cfd-889c-e3ad7ee6a615"
version = "1.2.0"

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

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

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

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "f9557a255370125b405568f9767d6d195822a175"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.17.0+0"

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
git-tree-sha1 = "68723afdb616445c6caaef6255067a8339f91325"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.55"

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
git-tree-sha1 = "0e7508ff27ba32f26cd459474ca2ede1bc10991f"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.1"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SnoopPrecompile]]
deps = ["Preferences"]
git-tree-sha1 = "e760a70afdcd461cf01a575947738d359234665c"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.3"

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

[[deps.WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "b1be2855ed9ed8eac54e5caff2afcdb442d52c23"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.2"

[[deps.WorkerUtilities]]
git-tree-sha1 = "cd1659ba0d57b71a464a29e64dbc67cfe83d54e7"
uuid = "76eceee3-57b5-4d4a-8e66-0e911cebbf60"
version = "1.6.1"

[[deps.XLSX]]
deps = ["Artifacts", "Dates", "EzXML", "Printf", "Tables", "ZipFile"]
git-tree-sha1 = "ccd1adf7d0b22f762e1058a8d73677e7bd2a7274"
uuid = "fdbf4ff8-1666-58a4-91e7-1b58723a45e0"
version = "0.8.4"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "801cbe47eae69adc50f36c3caec4758d2650741b"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.12.2+0"

[[deps.ZipFile]]
deps = ["Libdl", "Printf", "Zlib_jll"]
git-tree-sha1 = "f492b7fe1698e623024e873244f10d89c95c340a"
uuid = "a5390f91-8eb1-5f08-bee0-b1d1ffed6cea"
version = "0.10.1"

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
# ╟─9a5b04d9-9740-4ead-b8f2-aab54f1281de
# ╟─f9f2216a-3d43-4846-8733-879ba5075407
# ╟─ab6ac8d0-6d8a-11ed-0400-1b357312718e
# ╟─42d2dc69-c5e8-4cb8-809b-19cae75e479d
# ╟─15cd6dec-49c7-4699-b44c-3698dcf8728c
# ╟─f14fe56a-6ad8-44e4-bd34-a242305a614d
# ╟─16ff8aed-2440-4a50-b57b-5554e8bb3438
# ╟─bc94035a-795b-4d08-aab2-87519b4ffd65
# ╟─1b2a5e1a-9ed1-4ba4-bac5-eeb3b823988d
# ╠═2b3b2b5a-55e8-4d50-b084-095482b9aa3b
# ╟─a4ada2ab-9702-4d93-a60d-27f041bdd903
# ╟─745eba40-0c86-4eb5-bdd3-20dd6ebd2429
# ╟─4225bb56-8b49-4f78-8ea6-91958174ad07
# ╟─58a0f0b3-29c1-4d52-91d3-b847ad2223b0
# ╟─fb9d346d-9e52-4e58-9a74-b787b7885063
# ╟─64a4e4f5-e742-4af5-b984-ee16795c98c0
# ╟─a6fda050-c8c4-4d91-82d2-2c3e6bbb0de3
# ╟─85ada988-94ee-4c7f-b025-cbc178439238
# ╟─6e6b7860-f321-4e9c-8ec7-094421a5c4e5
# ╟─ba4f6ec4-1187-4cbc-9392-f667dbec1727
# ╠═cf5981d0-56e0-4cca-b442-406a28207f29
# ╟─d9615428-0165-4fa0-b5a7-4de1f97092d4
# ╟─c0aaf25f-4402-487b-b7ed-d13e2b0edd4c
# ╟─6a5c482b-82f2-46b7-a915-6893bb8d2b0b
# ╟─e4800876-e5ba-4131-a81c-97c23e792cc3
# ╟─811d4aa9-0518-4a43-85c6-a2c0c5eec8e0
# ╠═2cf46eeb-9373-46a5-811a-aad1ceae25b6
# ╟─b0690699-6119-4463-a18a-092f009c2639
# ╟─7d4510a8-45a0-4d4c-b819-c7f838948be4
# ╠═06e308e4-524a-4d2f-8101-9126724f7261
# ╟─909aa38a-1eb4-406b-b8ed-c731675af1f1
# ╟─2c6e1e44-a405-4503-bb04-702beccbf435
# ╟─fb555768-69ac-4614-8011-bfc5a39cddad
# ╟─3b9d1877-bdfe-4a02-8208-0d62a2a5f469
# ╟─23ed4509-0d6d-4da2-971b-8e17aff2227a
# ╠═64bf07f5-6bd3-4325-bb5e-41e2e606eeda
# ╟─1f0a6c13-e8bb-48d4-9c8b-d783a7cb2648
# ╟─1535d83b-f8a0-457f-9acb-ea66d08e5196
# ╟─71c441b2-fca3-4382-bf07-5963c71a73a3
# ╠═7e952365-3c23-48c1-a0b1-28f49668471a
# ╠═76bf4ae7-ac48-4277-aaa1-6bad92e06a20
# ╟─2557e1b2-963f-4ba0-9535-88adc7a4b82f
# ╟─6439040e-06e7-463a-8ac2-0fa08d2d501d
# ╟─7060827d-47a2-457e-a42e-2e93a9473e34
# ╠═67c4c239-4f6e-44cc-a555-b5e6d6cc5aac
# ╠═05878d95-1307-49a9-b6cd-ea39c18fa38e
# ╟─f43d5098-3de4-4391-aa03-860aa140a35b
# ╟─4585b547-af4a-4df1-b184-77d715a0c1f3
# ╟─0270b474-c4e9-41cf-9235-daf89aefba16
# ╠═d5b567d3-0444-48a5-9a40-30a36a9d69e3
# ╟─6dd4c140-2172-4f5f-954a-40112fd43283
# ╠═67e6c75e-5bc8-4794-a8f0-4a447056d831
# ╟─e3a660fb-7d82-40b9-9ff9-f62d7701006e
# ╟─57cedb4d-1448-42f7-b15c-5f2e0eb29d96
# ╟─2b8c7816-c887-4e32-86f0-8b1ff9d90df2
# ╟─d4f555fe-481a-4f93-a421-a1a37c770062
# ╠═b00bbb6d-c453-4b89-b6ed-ae301a980fc8
# ╟─a1037974-9df4-4b6c-a5a4-dedf2596090f
# ╟─8780b70a-a35c-47d0-a348-a33978b775fa
# ╠═ed97df42-fa3d-4417-8e33-c15686852087
# ╟─1d29d759-b491-4ca8-ba7a-e67a9ced4bb5
# ╟─bfdb4954-2edd-404f-9c01-55b31b292d49
# ╠═ec7f0750-7e94-4ebf-a409-43f16dbeefb6
# ╟─fc61265a-5e2e-4532-9693-2609de82242a
# ╟─0c15ad5f-b1f6-4eb4-8258-0fb8f33deb9d
# ╠═3a4e33ae-53c8-428d-b5d9-ee0b0db8affa
# ╟─79a55f86-765f-40cb-a377-9660525780c9
# ╟─8552dd0f-d500-4602-9a6b-6f845bbd2d13
# ╠═7fc46967-6521-4bc2-a9f9-612a3a2e84c7
# ╟─946ae8a0-e98c-4e1e-b7c1-a2a1fc894df1
# ╟─b97391ca-ea41-4f58-9c36-8bf759c08953
# ╠═39011a8f-a6fc-40e3-b9dc-2da6170e5abc
# ╟─5ef42bbc-140e-4442-91cc-9054461eca4e
# ╟─39db800a-76fe-43b6-8ca0-7add96940ec5
# ╠═79d80c73-096d-4248-b8b9-b58180398d80
# ╟─3ed2e1b2-6708-4c64-bbc6-6fd4c43f3804
# ╟─6ec3099b-bf0e-4ffe-8947-689905d44de3
# ╟─b9307cee-5af6-4ad1-a3f2-18f59560cf7f
# ╟─1c7c7c24-cde9-4a24-bada-51a77b35970f
# ╟─4ffc3a13-aa4e-42b4-98f6-36c5ab7f9c40
# ╠═80ccbebe-bc6d-4d8a-9ce8-e353d72967d2
# ╟─bb68e71b-a330-4a7a-99ed-600c77e38237
# ╟─2b6f1d3c-65b9-4088-8720-0148847d6ce0
# ╟─d6b79c1c-61d2-4de3-ac7a-0abedde9ed1d
# ╟─8e506331-a0dc-4c56-a879-f1d965abde02
# ╟─88fb44cc-fbe5-4685-9e9c-3576bb65c9e8
# ╠═04de9d16-7597-40f0-b275-d75d12a61c10
# ╟─cda99e9d-a83e-4247-b5ea-566c7350323b
# ╠═ca98e338-0fa2-4c4a-8f3e-8d0b8a9e3f70
# ╟─b7e90ebc-029d-4fa6-9b84-8a6c68a6ea00
# ╟─43b423f7-208d-48cc-b767-1117bd745337
# ╠═a9868e63-6c6e-4be7-a3ad-86728622413c
# ╟─cec1bf13-e2d7-4f06-a882-d858b45f344c
# ╟─79acbcdf-9737-4972-ba3a-0ab8fac23fda
# ╠═5ea69e41-4459-486c-b369-5dcbd9dd9531
# ╟─cc093687-122d-410e-9ff0-269534ed6880
# ╟─2f61823b-f59d-447a-b9fa-da0f0df88b03
# ╟─8312cb85-fd05-4680-ba39-adcd64b61c9c
# ╟─8a8810ca-2609-408a-a271-80ed99622ff0
# ╟─79f28808-74b3-4d67-9182-bd3fa3cd95dd
# ╟─85b8d270-a6b0-45be-a4af-4404ef84e443
# ╟─9fa6b97b-c18e-4dd1-b3e3-f04bb6ed0c9c
# ╟─a46253a7-5e84-474c-a49b-8c72755f1bf2
# ╠═e9e0f4ee-c777-4f93-86c2-8529d5b326ba
# ╟─fe1a37df-fc03-4de8-a56f-77958667f109
# ╟─bd561d17-3178-4ee8-a21d-38ee0bc1e579
# ╠═6ad1466e-df8e-4a58-b35b-b93b99f4b383
# ╟─42806369-b240-4675-83fe-6b4582dcc78d
# ╟─1622706c-5c3d-4474-99fe-a9886d81e67b
# ╠═6f8ddf4b-26e8-4065-9ba3-221f0c4965a1
# ╟─7090ff64-7f19-4043-8892-ce2700a156f5
# ╟─fe0ed40b-02be-4b64-9c1d-c7721d2ecafe
# ╟─f3725b7e-59fa-4b11-a827-d01d643065bf
# ╟─ab4fe12a-0396-4b16-a4e2-713435415173
# ╠═543d6721-3cd7-4337-bfc9-0073bf98fcfc
# ╟─2b60596a-bd59-4791-b516-ff68f29bd75e
# ╟─028b1008-89e3-4f73-abb3-e4c9b57c7474
# ╠═1a7658d3-dfd1-42d7-bc48-4248ba0fb91b
# ╟─c739ced0-a36d-499a-b7ad-2a4a211b4146
# ╟─1ea624b2-c51c-4187-817c-ed51eb431706
# ╠═62f483d7-a163-48cd-b256-da5f66866467
# ╟─68753596-3093-4ea8-9256-e49090f6625e
# ╟─d937f6b8-e24b-41f8-9445-001091006445
# ╠═5efbd671-a417-4f04-9819-bd702f739019
# ╟─7c3a4465-0748-45c8-9f59-4c1bec3d37c1
# ╟─30bede84-9998-4c01-ae0e-0f5028cf867e
# ╟─55e42d18-9457-47d7-813e-789f5d2757b5
# ╟─01eea949-1bd1-4255-803e-ac06fdca3cee
# ╟─2291b793-51c9-40a9-b508-a3ac9a5611b4
# ╟─fe90ad75-1955-4bba-ba76-1e34ac703a00
# ╟─cf82d0b8-ee97-4590-99a9-a4d464309642
# ╟─2527be95-99c1-4f47-8974-5c98b24e243b
# ╠═0e6a1a35-1f58-4215-b747-dd3a8e33c041
# ╟─71ea3183-2b19-4f7e-b0ef-cf5e6da1f935
# ╟─81a0c6a1-c53f-4c2c-9f8a-47b856ea83a5
# ╠═c4f3e633-def1-4116-a6eb-fa016f789590
# ╟─c4a5dbe4-e09a-463e-afa9-acc474b2eeac
# ╟─d88ffa35-4dd7-42d9-acc2-0ecc09e17be5
# ╟─6fa7bd95-446e-41d8-91cb-71b24a66bfa7
# ╟─93d9f7a2-07cf-495e-812d-ce7d6da913c6
# ╠═76c3b5f0-12eb-4618-b4c0-ef2214e19ef4
# ╠═73eaeda6-9b21-4ab8-90a8-cb1ef03a5d41
# ╟─b93c159e-b4ec-4e7a-9443-d425ef28480b
# ╟─f57e7d93-9817-4969-bced-b3a6cf64c769
# ╠═e06d806b-9194-4c7c-bac1-19d7acdfffc3
# ╠═90133060-8d12-47e8-8613-f7f412e51e5a
# ╠═0391e3ca-36f3-40d0-b073-81ff3678834f
# ╟─8bdba3f5-9e78-405a-9fe2-c5aca82974b2
# ╟─c48276fd-9dfe-45d0-afc0-f275af52f993
# ╠═f1757c8a-70da-4963-8756-08592cd318e1
# ╠═8dc61e9c-ba5d-4edc-b2ca-5a7f01b609aa
# ╠═2313ba7a-8471-4c4e-9d8f-453067aee623
# ╟─7e681a42-0df2-48a8-be67-dc9b3e9d251f
# ╟─f148fd7a-0a24-45b3-b84f-d4eb5fe30390
# ╠═c7722e6b-18b1-45e5-a642-479d9e4f0b63
# ╟─c03cbf18-38da-4e1a-a912-d40aaeeff657
# ╟─0e5132b8-4327-4757-aff6-808db28f5536
# ╠═26ab9aa9-1751-429d-bb23-dfe493ce4cf5
# ╟─8f1cce3b-13ca-4b90-9a72-06b135b1690c
# ╟─259a77e2-091b-4ac9-a938-c2e28fb8bf6e
# ╠═b07ca161-c3ad-4a17-bff2-87494487d5ad
# ╟─3c46d36d-417c-44fd-86bc-dce2e52c1f9c
# ╟─a124bf84-7ca4-40c8-8607-b05dec24a730
# ╟─75672e0c-5c34-44c8-b1a9-f6ba821d6c8d
# ╟─5f191192-bc5f-41e8-845c-beba89ee5841
# ╟─cddc45e1-7547-4d34-bc12-b08a5320a62c
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
