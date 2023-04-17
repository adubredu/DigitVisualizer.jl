# function get_generalized_coordinates(sim::DigitViz)
#     state = sim.state
#     mechanism = state.mechanism
#     floating_base = first(out_joints(root_body(mechanism), mechanism)) 
#     base_pose = configuration(state, floating_base)
#     ypr = quat_to_ypr(base_pose[1:4])
#     q = [base_pose[5:7]; ypr]
#     for name in sim.joint_names 
#         conf = configuration(state, findjoint(mechanism, name)) 
#         push!(q, conf[1])
#     end
#     return q
# end

function get_generalized_coordinates(sim::DigitViz)
    qstate = configuration(sim.state)
    q = copy(qstate.parent)
    return q
end

function get_frost_generalized_coordinates(sim::DigitViz) 
    state = sim.state 
    mechanism = state.mechanism
    floating_base_joint = first(out_joints(root_body(mechanism), mechanism)) 
    ow, ox, oy, oz, x, y, z = configuration(state, floating_base_joint)
    y, p, r = quat_to_ypr([ow, ox, oy, oz])
    q = [x, y, z, y, p, r]
    for joint_name in sim.joint_names 
        joint = findjoint(mechanism, joint_name)
        push!(q, configuration(state, joint)[1])
    end
    return q 
end