function csys = backward(sys,w,h)

res = zeros(1,2);
w1 = 0.1:0.1:1000;
[mag,phase] = bode(sys,w1);
mag = 20*log10(mag);
mag = mag(:)';
phase = phase(:)';
phase = 180 + phase;
f_mag = @(x) interp1(w1,mag,x);
f_phase = @(x) interp1(w1,phase,x); %构造幅相函数


chara = surfeit(sys);
wc = fzero(@(x) f_phase(x)-(w+9), 10);
b =fzero(@(x) f_mag(wc) + 20*log10(x), 0.1);
T = 1/(0.1*b*wc);

resc = tf([b*T,1],[T,1]) ;
res = resc * sys;
chara2 = surfeit(res); %矫正装置传递函数计算

if chara2(1) < w || chara2(2) < h
    an = backward(res,w,h);%不满足要求继续迭代, 多级串联
    csys(1) = an(1);
    csys(2) = an(2);
    csys(3) = an(3);
else
    csys(1) = sys;%满足直接返回结果
    csys(2) = resc;
    csys(3) = res;
end


end