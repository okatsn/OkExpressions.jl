using Chain
@testset "rexpressions.jl" begin
    # # Basic test
    list_todotree = ["KEYNOTE", "CHECKPOINT", "(WARN|WARNING)"] # Make sure this list is identical with that in the project module

    for ukeyexpr in list_todotree
        ukey1 = match(r"[A-Z]+", ukeyexpr).match
        lkey = lowercase(ukey1)
        fnm = Symbol("expr_startw_$lkey")
        # expr = Regex("^$ukeyexpr\\:\\s*", "m")

        eval(quote
            # $fnm = $expr
            ukey1 = $ukey1
            @test match(    $fnm, "$(ukey1): Hello world").match == "$(ukey1): Hello world"
            @test !occursin($fnm, " $(ukey1): Hello world")
            @test !occursin($fnm, "a = 1+1 # $(ukey1): Hello world")
        end)
    end


    ukey1 = "HELLOWHATEVER"
    expr = gen_expr_startw(ukey1)

    txt =
    """
    $(ukey1):
            Second line
    """
    @test match(    expr, txt).match == "$(ukey1):"
    @test match(    expr, "$(ukey1): Hello world").match == "$(ukey1): Hello world"
    @test !occursin(expr, " $(ukey1): Hello world") # inline keynote should be ignored
    @test !occursin(expr, "a = 1+1 # $(ukey1): Hello world") # inline keynote should be ignored

    # Test linbreak
    #using Chain
    targetstr = """
    $(ukey1): My Title
    Hello world. My name is Foobar.
        How are you?
    """

    @test match(expr, targetstr).captures[end] == "My Title"
    outstr = replace(targetstr, expr => s"!!! note \g<myhead>")

    v1 = [mt.match for mt in eachmatch(r"[A-Za-z]+",outstr) if !isnothing(mt)]
    v2 = [mt.match for mt in eachmatch(r"[A-Za-z]+",targetstr) if !isnothing(mt)]

    @test isequal(v1[2:end], v2[2:end])
    @test v1[1] == "note"
    @test v2[1] == ukey1

    @test replace("$(ukey1):", expr => s"!!! note \g<myhead>") == "!!! note "
    # line2nd = split(outstr, "\n")[2]
    # @test occursin(r"^\s{4,}", line2nd) # make sure the second line have at least 4 white spaces.
end
