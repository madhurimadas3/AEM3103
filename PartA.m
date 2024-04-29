%%  Enter PaperPlane.m Data Points	
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
    Gam_min        =   -0.5;
    Gam_max        =   0.4;
    % Corresponding Velocity, m/s (Vnom = 3.55)
	Vnom		=	sqrt((2 * m * g /(rho * S * (CL * cos(Gam_nom) - CD * sin(Gam_nom)))));
	Vmin        = 2;
    Vmax        = 7.5;
    Alpha	=	CL / CLa;			% Corresponding Angle of Attack, rad
	
%%	Variations in Velocity
%   anom) Equilibrium Glide at Maximum Lift/Drag Ratio
	H		=	2;			% Initial height in meters
	R		=	0;			% Initial range in meters
	to		=	0;			% Initial time in seconds
	tf		=	6;			% Final time in seconds
	tspan	=	[to tf];
	xo		=	[Vnom;Gam_nom;H;R];
	[ta,xnom]	=	ode23('EqMotion',tspan,xo);
%	amin) Equilibrium Glide at Maximum Lift/Drag Ratio
	H		=	2;			% Initial height in meters
	R		=	0;			% Initial range in meters
	to		=	0;			% Initial time in seconds
	tf		=	6;			% Final time in seconds
	tspan	=	[to tf];
	xo		=	[Vmin;Gam_nom;H;R];
	[ta,xmin]	=	ode23('EqMotion',tspan,xo);
%	amax) Equilibrium Glide at Maximum Lift/Drag Ratio
	H		=	2;			% Initial height in meters
	R		=	0;			% Initial range in meters
	to		=	0;			% Initial time in seconds
	tf		=	6;			% Final time in seconds
	tspan	=	[to tf];
	xo		=	[Vmax;Gam_nom;H;R];
	[ta,xmax]	=	ode23('EqMotion',tspan,xo);%Graph Height vs Range Case A
%%	Variations in Flight Path Angle
%   anom) Equilibrium Glide at Maximum Lift/Drag Ratio
	H		=	2;			% Initial height in meters
	R		=	0;			% Initial range in meters
	to		=	0;			% Initial time in seconds
	tf		=	6;			% Final time in seconds
	tspan	=	[to tf];
	xo		=	[Vnom;Gam_nom;H;R];
	[ta,xgnom]	=	ode23('EqMotion',tspan,xo);
%	amin) Equilibrium Glide at Maximum Lift/Drag Ratio
	H		=	2;			% Initial height in meters
	R		=	0;			% Initial range in meters
	to		=	0;			% Initial time in seconds
	tf		=	6;			% Final time in seconds
	tspan	=	[to tf];
	xo		=	[Vnom;Gam_max;H;R];
	[ta,xgmin]	=	ode23('EqMotion',tspan,xo);
%	amax) Equilibrium Glide at Maximum Lift/Drag Ratio
	H		=	2;			% Initial height in meters
	R		=	0;			% Initial range in meters
	to		=	0;			% Initial time in seconds
	tf		=	6;			% Final time in seconds
	tspan	=	[to tf];
	xo		=	[Vnom;Gam_min;H;R];
	[ta,xgmax]	=	ode23('EqMotion',tspan,xo);%Graph Height vs Range Case A
    %Plot 3 Variations in Velocity
    figure
    subplot(2,1,1);
	plot(xnom(:,4),xnom(:,3),'k',xmin(:,4),xmin(:,3),'r',xmax(:,4),xmax(:,3),'g')
    title('Height vs Range')
	xlabel('Range, m'), ylabel('Height, m'), grid
    subplot(2,1,2);
    plot(xgnom(:,4),xgnom(:,3),'k',xgmin(:,4),xgmin(:,3),'r',xgmax(:,4),xgmax(:,3),'g')
    title('Height vs Range')
	xlabel('Range, m'), ylabel('Height, m'), grid



