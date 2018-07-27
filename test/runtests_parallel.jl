addprocs(2)
@everywhere using DiscreteValueIteration, POMDPs, POMDPModels

mdp = GridWorld(sx=500, sy=500)

solver = ParallelValueIterationSolver(n_procs=3)

parallel_policy = solve(solver, mdp, verbose=true)

serial_policy = solve(ValueIterationSolver(), mdp)

@test isapprox(norm(parallel_policy.util - serial_policy.util), 0., atol=solver.belres)