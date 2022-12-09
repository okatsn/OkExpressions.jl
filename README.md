# OkExpressions

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://okatsn.github.io/OkExpressions.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://okatsn.github.io/OkExpressions.jl/dev/)
[![Build Status](https://github.com/okatsn/OkExpressions.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/okatsn/OkExpressions.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/okatsn/OkExpressions.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/okatsn/OkExpressions.jl)

!!! note
    This is a julia package created using `okatsn`'s preference, and this package is expected to be registered to [okatsn/OkRegistry](https://github.com/okatsn/OkRegistry) for CIs to work properly.

## Tips for connecting to remote
Connect to remote:
1. Switch to the local directory of this project (OkExpressions)
2. Add an empty repo OkExpressions on github (without anything!)
3. `git push origin main`
- It can be quite tricky, see https://discourse.julialang.org/t/upload-new-package-to-github/56783
More reading
Pkg's Artifact that manage an external dataset as a package
- https://pkgdocs.julialang.org/v1/artifacts/
- a provider for reposit data: https://github.com/sdobber/FA_data

## Hints for Documenter
Set `docs/make.jl` for example:
```julia
pages=[
    "Home" => "index.md",
    "Examples" => "examples/examples.md",
    "Exported Functions" => "functions.md",
    "Models" =>
                ["Model 1" => "models/model1.md",
                    "Model 2" => "models/model2.md"],
    "Reference" => "reference.md",
    ]
```

For more information, see [this](https://documenter.juliadocs.org/stable/man/guide/#Adding-Some-Docstrings)
