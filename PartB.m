clc;
clear all;
clear variables;
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
	Gam	    =	-atan(1 / LDmax);
    % Corresponding Velocity, m/s (Vnom = 3.55)
	V		=	sqrt((2 * m * g /(rho * S * (CL * cos(Gam) - CD * sin(Gam)))));
    Alpha	=	CL / CLa;			% Corresponding Angle of Attack, rad
% Timespan & Steps
num_trajectories = 100;
t0 = 0;
tf = 6;
tspan = linspace(t0, tf, 100); % 100 steps for simulation

% Arrays to store trajectories
height_data = zeros(numel(tspan), num_trajectories);
range_data = zeros(numel(tspan), num_trajectories);
time_data = zeros(numel(tspan),num_trajectories);
% Simulating 100 trajectories with random parameters
for i = 1:num_trajectories
    % Generating random parameters within expected ranges
    V_rand = 2 + (7.5 - 2) * rand(1); % Interval [+2,+7.5]
    Gam_rand = -0.5 + (0.4 + 0.5) * rand(1); % Interval [-0.5, 0.4]
    
    % Simulating trajectory
    H		=	2;			% Initial height in meters
	R		=	0;			% Initial range in meters
    xo		=	[V_rand;Gam_rand;H;R];
    [ta,xn]	=	ode23('EqMotion',tspan,xo);
    
    % Storing trajectory data
    height = xn(:,3);
    height_data(:, i) = height;
    range = xn(:,4);
    range_data(:, i) = range;
    time_data (:,i) = tspan;

    % Plotting individual trajectory
    plot(range, height, 'b', 'LineStyle', '-', 'LineWidth', 0.5);
    title('Height vs Range')
	xlabel('Range, m'), ylabel('Height, m')
    hold on;
end

% Plotting nominal trajectory
[V_nominal, Gam_nominal] = deal(3.55, -0.18); % Nominal values
 xo		=	[V_nominal;Gam_nominal;H;R];
[t_nominal, y] = ode23('EqMotion',tspan,xo);
range_nominal = y(:,4);
height_nominal = y(:,3);
%plot(range_nominal, height_nominal, 'k-', 'LineWidth', 2); don't need it


% Fitting polynomials to average trajectory
t = reshape(time_data,[],1);

poly_order = 5; % choosing 5 in this case
p_range = polyfit(t, reshape(range_data,[],1), poly_order); 
p_height = polyfit(t, reshape(height_data,[],1), poly_order);

range_fit = polyval(p_range,tspan);
height_fit = polyval(p_height,tspan);

% plot of the curve fit
plot(range_fit,height_fit,'r-',LineWidth=3);


% Computing first time derivatives
d_range_dt = polyder(p_range);
d_height_dt = polyder(p_height);

% Plotting first time derivatives
figure;
subplot(2,1,1);
fplot(@(t) polyval(d_range_dt, t), [t0 tf], 'b-');
xlabel('Time');
ylabel('d(range)/dt');
title('First Time Derivative of Range');


subplot(2,1,2);
fplot(@(t) polyval(d_height_dt, t), [t0 tf], 'r-');
xlabel('Time');
ylabel('d(height)/dt');
title('First Time Derivative of Height');
