module DigitVisualizer

using MeshCat
using MeshCatMechanisms
using RigidBodyDynamics
using CoordinateTransformations
using Rotations 
using Colors 
using StaticArrays
using LinearAlgebra 
using GeometryBasics

include("visuals.jl")
include("types.jl")
include("utils.jl")
include("set.jl")
include("load.jl")
include("get.jl")


export DigitViz 

export load_digit_vis,
        initialize_arena!,
        set_joint_positions!,
        set_frost_joint_positions!,
        get_generalized_coordinates,
        get_frost_generalized_coordinates,
        animate_trajectory,
        animate_trajectory_frost


end
