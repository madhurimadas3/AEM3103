clc;
clear all;
clear variables;

% Animation 
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

%%   Create and save GIF
%   Create a figure
    figure;
    hold on;    
% Plot the xnom data
    plot(xnom(:,4),xnom(:,3), 'k', 'DisplayName', 'xnom');
    plot(xgs(:,4),xgs(:,3),'b','DisplayName','xgs');
% Initialize the dot
    dotHandle = plot(xgs(1,4),xgs(1,3), 'r*', 'MarkerSize', 5, 'DisplayName', 'Moving Dot');
% Set axis limits(Size of Graph)
    xlim([min(xnom(:,4)+3), max(xnom(:,4)+3)]);
    ylim([min(xnom(:,3)), max(xnom(:,3))]);
    
% Add labels and legend
    xlabel('Range');
    ylabel('Height');
    title('Animated Plot');
    legend('Location', 'best');
% GIF variables
    filename = 'animated_plot.gif';
    frameRate = 30;  % Frames per second
    numFrames = length(xgs(:,4));
    delayTime = 1 / frameRate;  
% Create the animation
    for i = 1:numFrames
    % Update the dot position
        set(dotHandle, 'XData', xgs(i,4), 'YData', xgs(i,3));
        drawnow; 
        pause(0.05);  % Pause for a short duration
    % Save as a GIF
        frame = getframe(gcf);
        im = frame2im(frame);
        [imIndexed, map] = rgb2ind(im, 256);
    % Append the frame to the GIF file
        if i == 1
            imwrite(imIndexed, map, filename, 'gif', 'LoopCount', Inf, 'DelayTime', delayTime);
        else
            imwrite(imIndexed, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', delayTime);
        end
    end
    disp(['Animated GIF saved as "', filename, '"']);
    hold off;
    
    

