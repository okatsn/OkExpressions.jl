"""
`expr_kwarg_int(keyword)` returns regular expression that matches integer after "\$keyword=".

# Example
```jldoctest
expr = expr_kwarg_int("verbosity")
str = "fit!(mach; verbosity = 5)"
match(expr,str).match

# output

"5"
```

"""
function expr_kwarg_int(keyword)
    Regex("(?<=$keyword\\=)$(rstr_onlywsp)*\\d+")
end
