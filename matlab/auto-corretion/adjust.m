function csys = adjust(sys,w,h)

%  test sys
%  sys = tf([40],conv(conv([1,0],[0.2,1]),[0.0625,1]))
origin = surfeit(sys);%计算裕度
phase_forward = w - origin(1);%超前角

if phase_forward < 60 % 当超前角小于60时使用超前较正
    csys = forward(sys,w,h);
else % 否则使用滞后矫正
    csys = backward(sys,w,h);
end

[n,d] = tfdata(sys);
n = n{1};
n = n(find(n~=0));
d = d{1};
d = d(find(d~=0));

[n1,d1] = tfdata(csys(3));
n1 = n1{1};
n1 = n1(find(n1~=0));
d1 = d1{1};
d1 = d1(find(d1~=0));

csys(4) = tf(deconv(n1,n),deconv(d1,d));

bode(sys,csys(3))

legend('sys-origin','sys-result')
end
