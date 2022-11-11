mutable struct DigitViz 
    joint_names::SVector{24, String}
    motor_names::SVector{20, String}
    vis::Visualizer 
    mvis::Union{MechanismVisualizer, Nothing}
    state::Union{MechanismState, Nothing} 

    function DigitViz(vis::Visualizer)
        joint_names = SA["left-hip-roll", "left-hip-yaw", "left-hip-pitch", 
            "left-knee", "left-shin", "left-tarsus", "left-toe-pitch", 
            "left-toe-roll", "left-shoulder-roll", "left-shoulder-pitch", 
            "left-shoulder-yaw", "left-elbow", "right-hip-roll", "right-hip-yaw", 
            "right-hip-pitch", "right-knee", "right-shin", "right-tarsus", 
            "right-toe-pitch", "right-toe-roll", "right-shoulder-roll", 
            "right-shoulder-pitch", "right-shoulder-yaw", "right-elbow"]
        motor_names = SA["left-hip-roll", "left-hip-yaw", "left-hip-pitch", 
        "left-knee", "left-toe-A", "left-toe-B",  "right-hip-roll", "right-hip-yaw", 
        "right-hip-pitch", "right-knee", "right-toe-A", "right-toe-B", "left-shoulder-roll", "left-shoulder-pitch", 
        "left-shoulder-yaw", "left-elbow", "right-shoulder-roll", 
        "right-shoulder-pitch", "right-shoulder-yaw", "right-elbow"]
        new(joint_names, motor_names, vis, nothing, nothing)
    end
end