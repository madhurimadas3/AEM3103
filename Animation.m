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
   figure;
   hold on;
   axis equal;
   xlabel('Range (m)'); ylabel('Height (m)'); title('2D Trajectory (Velocity)');
   
   h1 = animatedline('Color','k');

   % Animating trajectory
   for k = 1:length(xnom)
       addpoints(h1,xnom(:,4),xnom(:,3));
       drawnow
   end
%% Animation for Gam = +0.4 rad
    H		=	2;			% Initial height in meters
	R		=	0;			% Initial range in meters
	to		=	0;			% Initial time in seconds
	tf		=	6;			% Final time in seconds
	tspan	=	[to tf];
    Vs      =   7.5;        % Given velocity in this scenario
    Gams    =   0.4;        % Given FPA in this scenario
	xo		=	[Vs;Gams;H;R];
	[ta,xgs]	=	ode23('EqMotion',tspan,xo);

   % Plotting trajectory 
   h2 = animatedline('Color','r');

   % Animating trajectory
   for d = 1:length(xgs)
       addpoints(h2,xgs(d,4),xgs(d,3));
       drawnow
   end

   % legend 
   legend('Nominal Graph','Vs = 7.5 m/s , Gs = 0.4rad');

   %Save as GIF
   saveas(gcf,'AnimationGIF.gif','gif')

   figure
  
	plot(xnom(:,4),xnom(:,3),'k')
   title('Height vs Range')
	xlabel('Range, m'), ylabel('Height, m'), grid
trajectories = 100;
   for i = 1:numel(trajectories)
       frames(i) = getframe(gcf);
   end
% Create animated GIF
filename = 'trajectory_animation.gif';
for i = 1:numel(frames)
   [imind, cm] = rgb2ind(frames(i).cdata, 256);
   if i == 1
       imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.5);
   else
       imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.5);
   end
end


