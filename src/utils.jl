function quat_to_ypr(q::Vector{Float64})
    quat = QuatRotation(q)
    zyx = RotZYX(quat)
    ypr = [zyx.theta1, zyx.theta2, zyx.theta3]
    return ypr
end 

function ypr_to_quat(q::Vector{Float64})
    ypr = RotXYZ(q...)
    qr = QuatRotation(ypr)
    quat = [qr.q.s, qr.q.v1, qr.q.v2, qr.q.v3]
    return quat
end