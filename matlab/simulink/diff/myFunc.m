function y = myFunc(h,T)
f = @(x) 9.8*T^2/(2*pi)*tanh(2*pi*h/x)-x;
y = fzero(f,20);
end