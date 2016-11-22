function csys = adjust(sys,w,h)

origin = surfeit(sys);%计算裕度
phase_forward = w - origin(1);%超前角

if phase_forward < 60 % 当超前角小于60时使用超前较正
    csys = forward(sys,w,h);
else % 否则使用滞后矫正
    csys = backward(sys,w,h);
end

bode(sys,csys(3))

legend('sys-origin','sys-result')
end
