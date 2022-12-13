using Test
# using TestItems
using OkExpressions

function targetlist(targetexpr::Regex, dir2walk::AbstractString)
    # targetexpr = r"(\.jl)$";
    fulllist = String[]
    for (root, folders, files) in walkdir(dir2walk)
        for file in files
            push!(fulllist, joinpath(root, file))
        end
    end
    allfiles = basename.(fulllist)
    targetid = occursin.(targetexpr, allfiles)

    targetpaths = fulllist[targetid]
    return targetpaths, allfiles
end

(testfiles, allnames) = targetlist(r"^(?!runtests).*(\.jl)$", "./");
# pwd() here should be "./test/"
@testset "OkExpressions.jl" begin
    for f in testfiles
        # write test in the file of the same name.
        # E.g., `test/mycode.jl` for testing `src/mycode.jl`.
        include(f)
    end
end

using Documenter
@testset "DocTests" begin
    DocMeta.setdocmeta!(OkExpressions, :DocTestSetup, :(using OkExpressions); recursive=true)
    doctest(OkExpressions; manual = false)
end

# @testitem "test vscode testitem" begin
#     println("Only `@testitem` block will be detectable by vscode's test")
#     @test true
#     # See https://youtu.be/Okn_HKihWn8?t=1299
# end
