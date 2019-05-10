using Test

session = login("test@jltest-dev-ed.com", "9d3T67hTK8DwKjApVAiwZL4nmBmPGqFpMNnK2YoRE4B7Sgf78", "45.0")
all_object_fields_return = all_object_fields(session)
@test eltype(session["sessionId"]) == Char
@test string(typeof(all_object_fields_return)) == "DataFrames.DataFrame"
@test size(all_object_fields_return, 1) > 1
@test size(all_object_fields_return, 2) > 50