# Functions in this script matches tag such as "KEYNOTE: A Certain Header" in the very beginning of the line and replace it by [admonition "Note"](https://documenter.juliadocs.org/stable/showcase/#Admonitions), with A Certain Header preserved.

"""
`gen_expr_startw(startingword)` returns the regular expression that matches what starts with `startingword` in a new line; it also matches the tailing immediatel colon (":") and whitespaces if any.
After that, the remaining characters before a newline is stored as a group match of group name `myhead` that you can call it as shown in the following example:

```jldoctest
targetstr = "KEYNOTE:  My Title"
expr = gen_expr_startw("KEYNOTE")
myhead = match(expr, targetstr).captures[end]

# output

"My Title"
```

or apply it in `replace`:

```jldoctest
replace("KEYNOTE:  My Title", expr => s"!!! note \\g<myhead>")

# output

"!!! note My Title"
```

"""
gen_expr_startw(startingword) = Regex("^$startingword\\:?[^\\S\\r\\n]*(?<myhead>.*)", "m")
# KEYNOTE: r"\s" matches not only whitespace but also line break "\n"
# use Regex([^\\S\\r\\n]) to match only whitespace (which is "not not a whitespace"); see https://stackoverflow.com/questions/3469080/match-whitespace-but-not-newlines

"""
This macro generates variable named `expr_startw_...` using the expression generator `gen_expr_startw`. See `gen_expr_startw`.
[Julia automatically generate functions and export them](https://stackoverflow.com/questions/31313040/julia-automatically-generate-functions-and-export-them)

# Note
This macro (**and also its test**) is superfluous and experimental for metaprogramming.
"""
macro addmyexpressions_1(funs::String...)
    e = quote end  # start out with a blank quoted expression
    for ukeyexpr in funs
      ukey1 = match(r"[A-Z]+", ukeyexpr).match
      lkey = lowercase(ukey1)
      fnm = Symbol("expr_startw_$lkey") # create your function name
      expr = gen_expr_startw(ukeyexpr)
      # this next part creates another quoted expression, which are just the 2 statements
      # we want to add for this function... the export call and the function definition
      # note: wrap the variable in "esc" when you want to use a value from macro scope.
      #       If you forget the esc, it will look for a variable named "maximumfilter" in the
      #       calling scope, which will probably give an error (or worse, will be totally wrong
      #       and reference the wrong thing)
      blk = quote
        export $(esc(fnm))
        $(esc(fnm)) = $expr
      end

      # an "Expr" object is just a tree... do "dump(e)" or "dump(blk)" to see it
      # the "args" of the blk expression are the export and method definition... we can
      # just append the vector to the end of the "e" args
      append!(e.args, blk.args)
    end

    # macros return expression objects that get evaluated in the caller's scope
    # See the module that calls it
    e
end

# # Alternatives:

# list_todotree = ["KEYNOTE", "CHECKPOINT", "(WARN|WARNING)"]
# fnmlist = []
# # exprlist = []
# for ukeyexpr in list_todotree
#     ukey1 = match(r"[A-Z]+", ukeyexpr).match
#     lkey = lowercase(ukey1)
#     fnm = Symbol("expr_startw_$lkey")
#     expr = Regex("^$ukeyexpr\\:\\s*", "m")
#     eval(quote
#         $fnm = $expr
#     end)
#     push!(fnmlist, fnm)
#     # push!(exprlist, expr)
# end
