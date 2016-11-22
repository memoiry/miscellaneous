function res = surfeit(sys)
%计算传递函数幅值裕度, 相角裕度, 截止频率
res = zeros(1,2);
w = 0.1:0.1:1000;
[mag,phase] = bode(sys,w);
mag = 20*log10(mag);
mag = mag(:)';
phase = phase(:)';
phase = 180 + phase;
f_mag = @(x) interp1(w,mag,x);
f_phase = @(x) interp1(w,phase,x);
wc = fzero(f_mag, 15);
wx = fzero(f_phase , 15);
res(1) = f_phase(wc);
res(2) = -f_mag(wx);
res(3) = wc;
res(4) = wx;

end
