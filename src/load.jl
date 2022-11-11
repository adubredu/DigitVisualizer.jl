packagepath() = joinpath(@__DIR__, "models")
urdfpath() = joinpath(packagepath(), "digit_w_grippers.urdf")

function mechanism(;floating=true, remove_fixed_joints=true, add_flat_ground=false)
    mechanism = RigidBodyDynamics.parse_urdf(urdfpath(); scalar_type=Float64, floating=floating, remove_fixed_tree_joints=remove_fixed_joints)
    if add_flat_ground
        frame = root_frame(mechanism)
        ground = RigidBodyDynamics.HalfSpace3D(Point3D(frame, 0.,0.,0.), FreeVector3D(frame, 0.,0.,1.))
        add_environment_primitive!(mechanism, ground)
    end
    remove_fixed_joints && remove_fixed_tree_joints!(mechanism)
    return mechanism
end

function load_digit_vis(sim::DigitViz; floating=true)
    mech  = mechanism(floating=floating, add_flat_ground=true) 
    state = MechanismState(mech) 

    mvis = MechanismVisualizer(state.mechanism, URDFVisuals(urdfpath(); package_path=[packagepath()]), sim.vis) 
    set_configuration!(mvis, configuration(state))
    sim.mvis = mvis 
    sim.state = state     
    set_nominal_configuration(sim) 
end