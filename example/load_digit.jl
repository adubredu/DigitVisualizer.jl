using Revise 
using DigitVisualizer
using DigitVisualizer.MeshCat
using DigitVisualizer.RigidBodyDynamics

vis = Visualizer()
initialize_arena!(vis)
digit = DigitViz(vis)
load_digit_vis(digit)

# get generalized coordinates of Digit
# floating base (x, y, z, y, p, r) + 24 joint positions
q = get_generalized_coordinates(digit)
@show q 

# edit shoulder joint position
q[16] = -1.5

# update joint positions
set_joint_positions!(q, digit)

# open visualizer and display digit robot
open(digit.mvis) 