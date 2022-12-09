module OkExpressions

include("rexpressions.jl")
@addmyexpressions_1 "KEYNOTE" "CHECKPOINT" "(WARN|WARNING)"
export gen_expr_startw
end
