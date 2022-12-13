"""


`expr_kwarg_int(keyword)` returns regular expression that matches integer after "\$keyword=".
Noted that whitespace is allowed after "=" but NOT allowd before.

# Example
```jldoctest exprkw

expr = expr_kwarg_int("verbosity")
str = "fit!(mach; verbosity= 5)"
parse(Int, match(expr,str).match)

# output

5
```

```jldoctest exprkw
str = "fit!(mach; verbosity = 5)"
match(expr,str)

# output


```

"""
function expr_kwarg_int(keyword)
    Regex("(?<=$keyword\\=)$(rstr_onlywsp)*\\d+")
end
