@testset "base" begin
    env = LotteryEnv()
    Random.seed!(env, 123)
    policy = RandomPolicy(env)
    Random.seed!(policy, 111)
    reset!(env)
    run(policy, env)
    @test is_terminated(env)

    discrete_env =
        env |> ActionTransformedEnv(
            a -> get_actions(env)[a];  # action index to action
            mapping = x ->
                Dict{Any,Int}(a => i for (i, a) in enumerate(get_actions(env)))[x], # arbitrary vector to DiscreteSpace
        )
    policy = RandomPolicy(discrete_env)
    reset!(discrete_env)
    run(policy, discrete_env)
    @test is_terminated(discrete_env)
end
