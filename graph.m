clear all;
close all;
delete(instrfind);


%important setting variables
BaudRate=19200;%with thisvariable yu can set the baudrate of arduino
buffSize=100;
simulation_duration=30; %time in seconds

%creating an object arduino
arduino=serial('COM3','BaudRate',BaudRate);

%opening the communication with the object arduino
fopen(arduino);
%first reading to throw away
str=fscanf(arduino);
str=fscanf(arduino);
%legge e mette le variabili lette al posto giusto
str=read_MPU6050(arduino);
dt=str(1);
angleX=str(2);
angleY=str(3);
angleZ=str(4);
gyro_x=str(5);
gyro_y=str(6);
gyro_z=str(7);
roll=str(8);
pitch=str(9);
angle_z=str(10);





tic; %to count the seconds

interv = 1500;
passo = 1;
t=1;
x=0;


while(toc<simulation_duration) %stop after "simulation duration" seconds
    str=read_MPU6050(arduino);
    dt=str(1);
    angleX=str(2)*pi/180;
    angleY=str(3)*pi/180;
    angleZ=str(4)*pi/180;
    gyro_x=str(5)*pi/180;
    gyro_y=str(6)*pi/180;
    gyro_z=str(7)*pi/180;
    roll=str(8)*pi/180;
    pitch=str(9)*pi/180;
    angle_z=str(10)*pi/180;
    
    y=gra(roll, gyro_x, dt);
 
    
b=y;
x=[x,b];
plot(x);
axis([0,interv,-0.07,0.07]);
grid
t=t+passo;
drawnow;

end
    
close all;
delete(instrfind);

% Displacement calculation

