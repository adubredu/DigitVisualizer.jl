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