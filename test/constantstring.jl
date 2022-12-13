using OkExpressions
@testset "constantstring.jl" begin
    rstr_onlywsp = OkExpressions.rstr_onlywsp
    rwsp = Regex(rstr_onlywsp)
    str = """
    Hello:
    This is a multi-line context. In which linebreak should not be matched by `rstr_onlywsp`.
    This is the third line. (after me is an immediate invisible line break)
    """

    vstrsp = split(str, rwsp)
    @test vstrsp[1]=="Hello:\nThis"
    @test vstrsp[2]=="is"
    @test vstrsp[3]=="a"
    @test isnothing(match(rwsp, "Hello\nThere\nis\nNo\nWhiteSpace!"))
end
