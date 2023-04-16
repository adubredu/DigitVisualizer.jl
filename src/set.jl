
function update_state!(q::Vector{Float64},  q̇::Vector{Float64}, sim::DigitViz) 
    state = sim.state
    mechanism = state.mechanism
    floating_base = first(out_joints(root_body(mechanism), mechanism))  
    base_pose = q[1:7]
    set_configuration!(state, floating_base, base_pose)
    for (i, joint) in enumerate(joints(sim.state.mechanism)[2:end])
        set_configuration!(state, joint, q[i+7]) 
    end 
    qstate = configuration(state)
    q̇state = velocity(state)
    return qstate, q̇state
end

function set_nominal_configuration(sim::DigitViz)
    default_configuration = Dict(
        "left-hip-roll" => 0.302,
        "left-hip-yaw" => -0.03,
        "left-hip-pitch" => 0.335,
        "left-knee" => 0.366,
        "left-shin" => -0.0129,
        "left-tarsus" => -0.339,
        "left-toe-pitch" => 0.149,
        "left-toe-roll" => -0.082,
        "left-shoulder-roll" => -0.15,
        "left-shoulder-pitch" => 1.08,
        "left-shoulder-yaw" => 0.0,
        "left-elbow" => -0.145,
        "right-hip-roll" => -0.308,
        "right-hip-yaw" => 0.0147,
        "right-hip-pitch" => -0.308,
        "right-knee" => -0.367,
        "right-shin" => 0.012,
        "right-tarsus" => 0.340,
        "right-toe-pitch" => -0.122,
        "right-toe-roll" => 0.0787,
        "right-shoulder-roll" => 0.15,
        "right-shoulder-pitch" => -1.1,
        "right-shoulder-yaw" => 0.0,
        "right-elbow" => 0.145
    )
    state = sim.state
    mechanism = state.mechanism
    floating_base = first(out_joints(root_body(mechanism), mechanism)) 
    base_pose = [1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.03]
    set_configuration!(state, floating_base, base_pose)

    for name in keys(default_configuration)
        set_configuration!(state, findjoint(mechanism, name), default_configuration[name]) 
    end
    set_configuration!(sim.mvis, configuration(state))
end

function set_joint_positions!(θ::AbstractArray{Float64}, sim::DigitViz)
    state = sim.state
    mechanism = state.mechanism
    floating_base = first(out_joints(root_body(mechanism), mechanism)) 
    # base_pose = [ypr_to_quat(θ[4:6])..., θ[1:3]...]
    base_pose = θ[1:7]
    set_configuration!(state, floating_base, base_pose)
    for (i, joint) in enumerate(joints(sim.state.mechanism)[2:end])
        set_configuration!(state, joint, θ[i+7]) 
    end 
    set_configuration!(sim.mvis, configuration(state))
end 

function animate_trajectory(θs::AbstractArray, Ts::Vector{Float64}, sim::DigitViz)
    qs = SegmentedVector{JointID, Float64, Base.OneTo{JointID}, Vector{Float64}}[]
    for θ in θs 
        qstate, _ = update_state!(θ, zeros(30), sim)
        push!(qs, copy(qstate))
    end
    return Ts, qs
end