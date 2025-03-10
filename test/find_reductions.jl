#=
    The File contains tests for main functions
=#

cases = [
    Dict(
        :sys => ExactODEReduction.@ODEsystem(
	    x1'(t) = x1(t),
	    x2'(t) = 2 * x2(t),
	),
	:dims => [Set([1])],
	:constrained => [([x1], 1), ([x1 + x2], 2)]
    ),
    Dict(
        :sys => ExactODEReduction.@ODEsystem(
	    x1'(t) = x1(t),
	    x2'(t) = 2 * x2(t),
	    x3'(t) = 3 * x3(t)
	),
	:dims => [Set([1, 2])],
	:constrained => [([x1], 1), ([x1 + x2], 2)]
    ),
    Dict(
        :sys => ExactODEReduction.@ODEsystem(
	    x1'(t) = 2 + x1(t),
	    x2'(t) = x1(t)^3 + x1(t) + x2(t),
	    x3'(t) = x1(t) * x2(t) - 10 * x2(t)^2 + x3(t),
	    x4'(t) = x1(t)^3 + x2(t)^6 - 7 * x3(t) * x1(t) - x4(t)
	),
	:dims => [Set([1, 2, 3])],
	:constrained => [([x1], 1), ([x2], 2), ([x2, x3], 3)]
    ),
    Dict(
        :sys => ExactODEReduction.@ODEsystem(
	    x1'(t) = 2,
	    x2'(t) = x1(t)^3 + x1(t),
	    x3'(t) = x1(t) * x2(t) - 10 * x2(t)^2,
	    x4'(t) = x1(t)^3 + x2(t)^6 - 7 * x3(t) * x1(t)
	),
	:dims => [Set([1, 2, 3])],
	:constrained => [([x1], 1), ([x2], 2), ([x2, x3], 3)]
    ),
    Dict(
        :sys => ExactODEReduction.@ODEsystem(
	    x1'(t) = x1(t),
	    x2'(t) = x2(t),
	    x3'(t) = x3(t)
	),
	:dims => [Set([1, 2])],
	:constrained => [([x1 + x2], 1), ([x1 + x3, x2 + x3], 2)]
    ),
    Dict(
        :sys => ExactODEReduction.@ODEsystem(
	    x1'(t) = 0,
	    x2'(t) = 0,
	    x3'(t) = 0
	),
	:dims => [Set([1, 2])],
	:constrained => [([x1 + x2], 1), ([x1 + x3, x2 + x3], 2)]
    ),
    Dict(
        :sys => ExactODEReduction.@ODEsystem(
	    x1'(t) = -x2(t),
	    x2'(t) = x1(t),
	    x3'(t) = -x4(t),
	    x4'(t) = x3(t)
        ),
	:dims => [Set([1, 2, 3])],
	:constrained => [([x1 + x2], 2), ([x3], 2)]
    ),
    Dict(
        :sys => ExactODEReduction.@ODEsystem(
	    x1'(t) = 3 * x1(t)^2 + 7,
	    x2'(t) = x2(t) - 3 * x2(t) * x3(t) + x3(t)^3 + 7 * x3(t),
	    x3'(t) = x3(t) - 5 * x2(t) + x2(t)^2 * x3(t)
	),
	:dims => [Set([1]), Set([2])],
	:constrained => [([x2], 2), ([x1], 1)]
    ),
    Dict(
        :sys => ExactODEReduction.@ODEsystem(
	    x1'(t) = x1(t) - x2(t) + x3(t)^3,
	    x2'(t) = x1(t),
	    x3'(t) = -x4(t),
	    x4'(t) = x3(t)
	),
	:dims => [Set([1, 2, 3])],
	:constrained => [([x1], 4)]
    ),
    Dict(
        :sys => ExactODEReduction.@ODEsystem(
            s1'(t) = -83//1000*s1(t) + 1//20*s2(t) + 24//25*s6(t),
            s6'(t) = 0,
            s2'(t) = 1//20*s1(t) - 3//50*s2(t),
            s3'(t) = 1//100*s2(t) - 1//100*s3(t),
            s8'(t) = 33//1000*s1(t),
            s4'(t) = 1//100*s3(t) - 1//200*s4(t),
            s5'(t) = 1//200*s4(t)
        ),
	:dims => [Set([1, 2, 3, 4, 5, 6])],
	:constrained => []
    ),
    Dict(
        :sys => ExactODEReduction.@ODEsystem(
            x1'(t) = x1(t) + x3(t)^2 - x4(t)^2,
            x2'(t) = x2(t) + 2 * x3(t) * x4(t),
            x3'(t) = -x3(t) + x1(t)^2 - x2(t)^2,
            x4'(t) = -x4(t) + 2 * x1(t) * x2(t)
        ),
        :dims => [Set([2])],
        :constrained => [([x1], 4)]
    ),
    # two copies of complex numbers
    Dict(
        :sys => ExactODEReduction.@ODEsystem(
            x0'(t) = 0,
            x1'(t) = (1 + x0(t)) * x2(t),
            x2'(t) = (1 + 2 * x0(t)) * x1(t),
            x3'(t) = (1 + x0(t)) * x4(t),
            x4'(t) = (1 + 2 * x0(t)) * x3(t),
        ),
        :dims => [Set([1, 3])],
        :constrained => []
    ),
    # two copies of quaternions
    Dict(
        :sys => ExactODEReduction.@ODEsystem(
            x0'(t) = 0,
	        x1'(t) = x1(t) + x0(t) * x2(t) + x0(t)^2 * x3(t) + x0(t)^3 * x4(t), # 1
	        x2'(t) = x2(t) - x0(t) * x1(t) - x0(t)^2 * x4(t) + x0(t)^3 * x3(t), # i
	        x3'(t) = x3(t) + x0(t) * x4(t) - x0(t)^2 * x1(t) - x0(t)^3 * x2(t), # j
	        x4'(t) = x4(t) - x0(t) * x3(t) + x0(t)^2 * x2(t) - x0(t)^3 * x1(t), # k
	        x5'(t) = x5(t) + x0(t) * x6(t) + x0(t)^2 * x7(t) + x0(t)^3 * x8(t), # 1
	        x6'(t) = x6(t) - x0(t) * x5(t) - x0(t)^2 * x8(t) + x0(t)^3 * x7(t), # i
	        x7'(t) = x7(t) + x0(t) * x8(t) - x0(t)^2 * x5(t) - x0(t)^3 * x6(t), # j
            x8'(t) = x8(t) - x0(t) * x7(t) + x0(t)^2 * x6(t) - x0(t)^3 * x5(t), # k
        ),
        :dims => [Set([1, 3, 5, 7])],
        :constrained => [],
        :iters => 4
    ),
    # Example from Section 2 of https://doi.org/10.1007/978-3-030-51945-2_19
    Dict(
        :sys => ExactODEReduction.@ODEsystem(
            x0'(t) = 0,
            x1'(t) = x1(t) + x0(t) * x2(t),
            x2'(t) = x3(t) + x0(t) * x4(t),
            x3'(t) = x2(t) + x0(t) * x5(t),
            x4'(t) = x5(t) + x0(t) * x6(t),
            x5'(t) = x4(t) + x0(t) * x7(t),
            x6'(t) = x8(t) + x0(t) * x1(t),
            x7'(t) = x7(t) + x0(t) * x9(t),
            x8'(t) = x6(t) + x0(t) * x8(t),
            x9'(t) = -(x1(t) + x2(t) + x3(t) + x4(t) + x5(t) + x6(t) + x7(t) + x8(t) + x9(t)) + x0(t) * x3(t)
        ),
        :dims => [Set([1])],
        :constrained => [],
        :iters => 4
    )
]

#------------------------------------------------------------------------------

function random_linear_change(sys)
    n = length(gens(parent(sys)))
    S = Nemo.MatrixSpace(Nemo.QQ, n, n)
    while true
        M = S([rand(-20:20) for i in 1:n, j in 1:n])
        if iszero(det(M))
            continue
        end
        Minv = M^(-1)
        eval_point = [sum([Minv[i, j] * gens(parent(sys))[i] for i in 1:n]) for j in 1:n]
        new_eqs = [sum([M[i, j] * equations(sys)[i] for i in 1:n]) for j in 1:n]
        new_eqs = [Nemo.evaluate(e, eval_point) for e in new_eqs]
        return ExactODEReduction.ODE{fmpq_mpoly}(Dict(gens(parent(sys))[i] => new_eqs[i] for i in 1:n))
    end
end

function check_reduction(red)
    nv = ExactODEReduction.new_vars(red)
    new_eqs = ExactODEReduction.new_system(red)
    sys = ExactODEReduction.old_system(red)
    eval_point = [Nemo.QQ(rand(1:100)) for _ in ExactODEReduction.vars(sys)]
    vect_field = [evaluate(sys.x_equations[x], eval_point) for x in ExactODEReduction.states(sys)]
    
    new_eval_point = [evaluate(nv[v], eval_point) for v in ExactODEReduction.vars(new_eqs)]
    new_vect_field_1 = [evaluate(eq, new_eval_point) for eq in ExactODEReduction.equations(new_eqs)]
    new_vect_field_2 = [evaluate(nv[v], vect_field) for v in ExactODEReduction.states(new_eqs)]

    return (new_vect_field_1, new_vect_field_2)
end

#------------------------------------------------------------------------------

@testset "Finding reductions" begin

    for c in cases
        sys = c[:sys]
        @info "Testing the system $sys"
        for i in 1:length(ExactODEReduction.states(sys))
            sys.ic[i] = rand()
        end

        red = ExactODEReduction.find_some_reduction(sys; overQ=false)
        (f1, f2) = check_reduction(red)
        @test f1 == f2

        reds = ExactODEReduction.find_reductions(sys; overQ=true)
        for r in reds
            (f1, f2) = check_reduction(r)
            @test f1 == f2
            ics_old = reshape(ExactODEReduction.initial_conditions(sys), length(states(sys)), 1)
            ics_old_red = ExactODEReduction.reduce_data(ics_old, r)
            new_sys = ExactODEReduction.new_system(r)
            ics_new = reshape(ExactODEReduction.initial_conditions(new_sys), length(ExactODEReduction.states(new_sys)), 1)
            @test ics_new == ics_old_red
        end
        reds = ExactODEReduction.find_reductions(sys; overQ=false) 
        @test Set([length(ExactODEReduction.new_vars(r)) for r in reds]) in c[:dims]

        for (obs, dim) in c[:constrained]
            red = ExactODEReduction.find_smallest_constrained_reduction(sys, obs)
            @test length(ExactODEReduction.new_vars(red)) == dim
            (f1, f2) = check_reduction(red)
            @test f1 == f2
        end

	for i in 1:get(c, :iters, 50)
            sys_change = random_linear_change(sys)
            reds_change = ExactODEReduction.find_reductions(sys_change; overQ=false)
            for r in reds_change
                (f1, f2) = check_reduction(red)
                @test f1 == f2
            end
            @test Set([length(ExactODEReduction.new_vars(r)) for r in reds_change]) in c[:dims]
        end
    end

end
