function csys = forward(sys,w,h)
w1 = 0.1:0.1:1000;
[mag,phase] = bode(sys,w1);
mag = 20*log10(mag);
mag = mag(:)';
f_mag = @(x) interp1(w1,mag,x);  %构造幅相函数


phase_plus = 10;
chara = surfeit(sys);
phase_chase = w - chara(1) + phase_plus;
sin_chase = sin(phase_chase * pi /180);
a = (1+sin_chase)/(1-sin_chase);
wc = fzero(@(x) f_mag(x)+10*log10(a), 15);
T = 1/(sqrt(a)*wc);
resc = tf([a*T,1],[T,1]) ;
res = resc * sys;
chara2 = surfeit(res);%矫正装置传递函数计算


if chara2(1) < w || chara2(2) < h
    an = forward(res,w,h);%不满足要求继续迭代, 多级串联
    csys(1) = an(1);
    csys(2) = an(2);
    csys(3) = an(3);
else
    csys(1) = sys;%满足直接返回结果
    csys(2) = resc;
    csys(3) = res;
end

end