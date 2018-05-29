function out = kalman_get_angle_Y(newAngle, newRate, dt)
q_angle = 0.001;
q_bias = 0.003;
r_measure = 0.003;
persistent angleY;
if isempty(angleY)
    angleY = 0;
 end

persistent biasY;
if isempty(biasY)
    biasY = 0;
end

persistent kY;
if isempty(kY)
    kY= [0;0];
end

persistent yY;
if isempty(yY)
    yY = 0;
end

persistent sY;
if isempty(sY)
    sY =0;
end

persistent pY;
if isempty(pY)
    pY = [0 kY(2); yY sY];
end

rateY = newRate - biasY;
angleY = angleY + dt*rateY;

%Update estimation error covariance
pY(1,1)= pY(1,1)+ dt*pY(2,2)+pY(1,2)- pY(2,1)+q_angle;
pY(1,2)= pY(1,2) - dt*pY(2,2);
pY(2,1) = pY(2,1) - dt*pY(2,2);
pY(2,2) = pY(2,2) + q_bias * dt;

%Calculate KAlman Gain
sY = pY(1,1) + r_measure;
kY(1) = pY(1,1) / sY;
kY(2) = pY(2,1) / sY;

yY = newAngle - angleY;
angleY = angleY + kY(1)*yY;
biasY = biasY + kY(2)*yY;

%Calculate estimation error covariance
pY(1,1) = pY(1,1) - kY(1)*pY(1,1);
pY(1,2) = pY(1,2) - kY(1)*pY(1,2);
pY(2,1) = pY(2,1) - kY(2)*pY(1,1);
pY(2,2) = pY(2,2) - kY(2)*pY(1,2);

out = angleY;
