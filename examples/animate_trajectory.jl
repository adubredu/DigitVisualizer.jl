using Revise 
using DigitVisualizer
using DigitVisualizer.MeshCat
using DigitVisualizer.RigidBodyDynamics

# set up visualizer
vis = Visualizer()
initialize_arena!(vis)
digit = DigitViz(vis)
load_digit_vis(digit)

# edit leg joint position
confs = collect(1.5:-0.01:-1.5) 
Ts = collect(0.0:0.01:3)
qs = []
for i in eachindex(confs)
    q = get_generalized_coordinates(digit)
    q[16] = confs[i]
    q[18] = confs[i]
    push!(qs, q)
end

Ts, qs = animate_trajectory(qs, Ts, digit)

# open visualizer and display digit robot
open(digit.mvis) 

# # setting animation
println("***setting animation***") 
setanimation!(digit.mvis, Animation(digit.mvis, Ts, qs))