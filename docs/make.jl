using OkExpressions
using Documenter

DocMeta.setdocmeta!(OkExpressions, :DocTestSetup, :(using OkExpressions); recursive=true)

makedocs(;
    modules=[OkExpressions],
    authors="okatsn <okatsn@gmail.com> and contributors",
    repo="https://github.com/okatsn/OkExpressions.jl/blob/{commit}{path}#{line}",
    sitename="OkExpressions.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://okatsn.github.io/OkExpressions.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/okatsn/OkExpressions.jl",
    devbranch="main",
)
