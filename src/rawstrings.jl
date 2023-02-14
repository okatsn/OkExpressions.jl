

function esc_quote(str)
    return replace(str, r"(\")" => s"\\\1")
end

function esc_br(str)
    str = replace(str, r"[\n\r]" => "\\n")
end

function esc_tab(str)
    str = replace(str, r"\t" => "\\t")
end


"""
Print the plain string with raw escape characters.

# Example
```julia-repl
julia> OkExpressions.print_raw("hello \n world \n\n  Foobar \t")

hello \n world \n\n  Foobar \t
```
"""
print_raw(io::IO, str) = str |> esc_br |> esc_tab |> esc_quote |> x -> print(io, x)

function print_raw(str)
io = stdout
print_raw(io, str)
end
