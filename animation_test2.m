clc;
clear all;
clear variables;

% Animation 
% Point-Mass Animation
% Animated GIF 
% showing 2D trajectory for nominal and the scenario (V=7.5m/s,Gam=+0.4rad)

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
	Gam_nom		=	-atan(1 / LDmax);
    
    % Corresponding Velocity, m/s (Vnom = 3.55)
	Vnom		=	sqrt((2 * m * g /(rho * S * (CL * cos(Gam_nom) - CD * sin(Gam_nom)))));
	
    Alpha	=	CL / CLa;			% Corresponding Angle of Attack, rad

  %% Animation for nominal velocity
	H		=	2;			% Initial height in meters
	R		=	0;			% Initial range in meters
	to		=	0;			% Initial time in seconds
	tf		=	6;			% Final time in seconds
	tspan	=	[to tf];
	xo		=	[Vnom;Gam_nom;H;R];
	[ta,xnom]	=	ode23('EqMotion',tspan,xo);

   % Plotting trajectory
   hold on;
   subplot(2,1,1);
   axis equal;
   
   
   xlabel('Range (m)'); ylabel('Height (m)'); title('2D Trajectory (Velocity)');
   
   h1 = animatedline('Color','k');

   % Animating trajectory
   for k = 1:length(xnom)
       addpoints(h1,xnom(k,4),xnom(k,3));
       drawnow
   end
%% Animation for velocity, Vs = 7.5 m/s
    H		=	2;			% Initial height in meters
	R		=	0;			% Initial range in meters
	to		=	0;			% Initial time in seconds
	tf		=	6;			% Final time in seconds
	tspan	=	[to tf];
    Vs      =   7.5;        % Given velocity in this scenario
	xo		=	[Vs;Gam_nom;H;R];
	[ta,xs]	=	ode23('EqMotion',tspan,xo);

   % Plotting trajectory 
   subplot(2,1,1);
   h2 = animatedline('Color','r');

   % Animating trajectory
   for a = 1:length(xs)
       addpoints(h2,xs(a,4),xs(a,3));
       drawnow
   end

   % legend 
   legend('Nominal Velocity','Vs = 7.5 m/s');
   hold off;
   %% Animation for nominal Flight path angle   
	H		=	2;			% Initial height in meters
	R		=	0;			% Initial range in meters
	to		=	0;			% Initial time in seconds
	tf		=	6;			% Final time in seconds
	tspan	=	[to tf];
	xo		=	[Vnom;Gam_nom;H;R];
    [ta,xgnom]	= ode23('EqMotion',tspan,xo);

   % Plotting trajectory 
   hold on;
   axis equal;
   
   subplot(2,1,2);
   xlabel('Range (m)'); ylabel('Height (m)'); title('2D Trajectory(FPA)');
   h3 = animatedline('Color','k');

   % Animating trajectory
   for c = 1:length(xgnom)
       addpoints(h3,xgnom(c,4),xnom(c,3));
       drawnow
   end
%% Animation for Gam = +0.4 rad
    H		=	2;			% Initial height in meters
	R		=	0;			% Initial range in meters
	to		=	0;			% Initial time in seconds
	tf		=	6;			% Final time in seconds
	tspan	=	[to tf];
    Gams    =   0.4;        % Given FPA in this scenario
	xo		=	[Vnom;Gams;H;R];
	[ta,xgs]	=	ode23('EqMotion',tspan,xo);

   % Plotting trajectory 
   subplot(2,1,2);
   h4 = animatedline('Color','r');

   % Animating trajectory
   for d = 1:length(xgs)
       addpoints(h4,xgs(d,4),xgs(d,3));
       drawnow
   end

   % legend 
   legend('Nominal Gam','Gams = 0.4 rad');
   hold off;