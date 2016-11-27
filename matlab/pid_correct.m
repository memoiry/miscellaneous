function csys = pid_correct(sys,controller)

% sys is the open_sys 

s = tf('s');
[y,t] = step(feedback(sys,1));
[max_dif,max_index] = max(diff(y)./diff(t));
grad = @(x) max_dif*(x-t(max_index))+y(max_index);
zero_ =  -y(max_index)/max_dif+t(max_index);
R = max_dif;
L = zero_;
if L == 0
    disp('the system can not be corrected!')
else
    if strcmp(controller,'P')
        kp = 1/(RL);
        csys = kp*sys;
    elseif strcmp(controller,'PI')
        kp = 0.9/(RL);
        Ti = L/0.3;
        csys = kp*(1+1/(Ti*s))*sys;
    else
        kp = 1.2/(R*L);
        Ti = 2*L;
        Td = 0.5*L;
        csys = kp*(1+1/(Ti*s)+Td*s)*sys;
    end
    step(feedback(sys,1))
    hold on
    step(feedback(csys,1))
    legend('before correct','after correct')
end
end