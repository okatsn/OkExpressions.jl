@testset "rawstrings.jl" begin
    str = """
    hello \n world \n\n  "Foobar" \t and "Octa"
    """
    open("temp.txt", "w") do io
        print_raw(io, str)
    end

    @test read("testrawstrings.txt", String) == read("temp.txt", String)
    rm("temp.txt")
end
