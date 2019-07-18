#test/runtests.jl
#import Pkg; Pkg.add("Test")
using Test, SalesForceBulkApi

## Pulling the data ##
session = login("test@jltest-dev-ed.com", "9d3T67hTK8DwKjApVAiwZL4nmBmPGqFpMNnK2YoRE4B7Sgf78", "45.0")
all_object_fields_return = all_object_fields(session)
all_object_fields_return[[:name, :object]]
queries = ["Select Name From Account Limit 10", "Select LastName From Contact limit 10"]
results = sf_bulkapi_query(session, "Select LastName From Contact limit 10")
multi_result = multiquery(session, queries)
multi_result_all = multiquery(session, queries, true)

# Testing content #
@test eltype(session["sessionId"]) == Char
@test string(typeof(all_object_fields_return)) == "DataFrames.DataFrame"
@test size(all_object_fields_return, 1) > 1
@test size(all_object_fields_return, 2) > 50
@test size(results) == (10,1)
@test typeof(multi_result) == Dict{Any,Any}
@test multi_result[queries[2]] == results
@test multi_result[queries[1]][1,1] == "GenePoint"
@test size(multi_result[queries[1]],1) <= size(multi_result_all[queries[1]],1)
