function out = gra(newAngle, newRate, dt)
q_angle = 0.001;
q_bias = 0.003;
r_measure = 0.003;
persistent angleX;
if isempty(angleX)
    angleX = 0;
    end

persistent biasX;
if isempty(biasX)
    biasX = 0;
end

persistent kX;
if isempty(kX)
    kX= [0;0];
end

persistent yX;
if isempty(yX)
    yX = 0;
end

persistent sX;
if isempty(sX)
    sX =0;
end

persistent pX;
if isempty(pX)
    pX = [0 kX(2); yX sX];
end


rateX = newRate - biasX;
angleX = angleX + dt*rateX;

%Update estimation error covariance
pX(1,1)= pX(1,1)+ dt*(pX(2,2))+(pX(1,2))- (pX(2,1)) + q_angle;
pX(1,2)= pX(1,2) - dt*(pX(2,2));
pX(2,1) = pX(2,1) - dt*(pX(2,2));
pX(2,2) = pX(2,2) + q_bias * dt;

 

%Calculate KAlman Gain
sX = pX(1,1) + r_measure;
kX(1) = (pX(1,1)) / sX;
kX(2) = (pX(2,1)) / sX;

yX = newAngle - angleX;
angleX = angleX + (kX(1))*yX;
biasX = biasX + kX(2)*yX;
%Calculate estimation error covariance
pX(1,1) = pX(1,1) - kX(1)*pX(1,1);
pX(1,2) = pX(1,2) - kX(1)*pX(1,2);
pX(2,1) = pX(2,1) - kX(2)*pX(1,1);
pX(2,2) = pX(2,2) - kX(2)*pX(1,2);



out = yX;
