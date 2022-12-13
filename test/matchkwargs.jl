@testset "matchkwargs.jl" begin
    expr = expr_kwarg_int("resolution")
    content = """
    # # Is it the best strategy to use TunedModel?
    model = fstree()
    # model.selector.features = colnm -> iseithertpast(colnm, tpast_2long())
    resampler = TimeSeriesCV(;nfolds=12)
    selectfns = [(colnm -> iseithertpast(colnm, tpast_2long()))]
    tuned_model = TunedModel(model=model,
        range= range(model, :(selector.features), values = selectfns),
        tuning=Grid(resolution=10,
                    shuffle=false),
        resampling=resampler,
        measure=lfn,
        train_best=false,
        acceleration= MLJ.CPUThreads()
    )


    machtms = [NamedMachine(nm,machine(tuned_model, fullX, y)) for (nm, y) in pairs(eachcol(y0))]
    """
    @test parse(Int, match(expr, content).match) == 10
end
