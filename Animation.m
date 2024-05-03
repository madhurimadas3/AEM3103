clc;
clear all;
clear variables;

% Animation 
% Point-Mass Animation
% Animated GIF 
% showing 2D trajectory for nominal and the scenario (V=7.5m/s,Gam=+0.4rad)

% Animation Parameters
num_trajectories = 100;
t0 = 0;
tf = 6;
dt = 0.01; 
tspan = linspace(t0, tf, round((tf-t0)/dt)+1); % timespan for simulation
%Initial variables
global CL CD S m g rho	
	S		=	0.017;			% Reference Area, m^2
	AR		=	0.86;			% Wing Aspect Ratio
	e		=	0.9;			% Oswald Efficiency Factor;
	m		=	0.003;			% Mass, kg
	g		=	9.8;			% Gravitational acceleration, m/s^2
	rho		=	1.225;			% Air density at Sea Level, kg/m^3	
	CLa		=	3.141592 * AR/(1 + sqrt(1 + (AR / 2)^2)); % Lift-Coefficient Slope, per rad
	CDo		=	0.02;			% Zero-Lift Drag Coefficient
	K	=	1 / (3.141592 * e * AR); % Induced Drag Factor	
	CL		=	sqrt(CDo / K);	% CL for Maximum Lift/Drag Ratio
	CD		=	CDo + K * CL^2;	% Corresponding CD
	LDmax	=	CL / CD;			% Maximum Lift/Drag Ratio
    % Corresponding Flight Path Angle, rad
	%Gam	    =	-atan(1 / LDmax);
    % Corresponding Velocity, m/s (Vnom = 3.55)
	% V		=	sqrt((2 * m * g /(rho * S * (CL * cos(Gam) - CD * sin(Gam)))));
    Alpha	=	CL / CLa;			% Corresponding Angle of Attack, rad

% Timespan 
num_frames = round((tf-t0)/dt)+1;
height_data = zeros(num_frames,num_trajectories);
range_data = zeros(num_frames,num_trajectories);



% Nominal Values
%Gam_nom		=	-atan(1 / LDmax);
%Vnom = 3.55; % m/s

% Given values for a scenario
%V_s = 7.5; % m/s
%Gam_s = 0.4; % rad

% Trajectories for animation
for i = 1:num_trajectories
    % Generating random parameters within expected ranges
    V_rand = 2 + (7.5 - 2) * rand(1); % Interval [+2,+7.5]
    Gam_rand = -0.5 + (0.4 + 0.5) * rand(1); % Interval [-0.5, 0.4]
    
    % Simulating trajectory
    H		=	2;			% Initial height in meters
	R		=	0;			% Initial range in meters
    xo		=	[V_rand;Gam_rand;H;R];
    [ta,xn]	=	ode23('EqMotion',tspan,xo);
  
  % storing trajectory data
    height = xn(:,3);
    height_data(:, i) = height;
    range = xn(:,4);
    range_data(:, i) = range;
    % Plotting individual trajectory
    plot(xn(:,4),xn(:,3),'b-','LineWidth',0.5);
    hold on;
end

% Plotting nominal trajectory
[V_nominal, Gam_nominal] = deal(3.55, -0.18); % Nominal values
 xo		=	[V_nominal;Gam_nominal;H;R];
[t_nominal, y] = ode23('EqMotion',tspan,xo);
plot(y(:,4),y(:,3),'k-','LineWidth',2);

% Plot
xlabel('Range (m)'); ylabel('Height (m)'); title('2 Trajectory');
grid on; axis equal;
    
% Creating a GIF animation
filename = 'TrajectoryAnimation.gif';

for Gam = -0.5:0.01:0.4

    Vnom		=	sqrt((2 * m * g /(rho * S * (CL * cos(Gam) - CD * sin(Gam)))));
    plot(Vnom,Gam,'ro');
    drawnow
    frame = getframe(gcf);
    im = frame2im(frame);

    [imind,cm] = rgb2ind(im,256);
    if Gam == -0.5
        imwrite(imind,cm,'Animation.gif','Loopcount',inf);
    else
        imwrite(imind,cm,'Animation.gif','WriteMode','append');
    end
end