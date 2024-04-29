clc;
clear all;
clear variables;
% Constants and expected ranges
num_trajectories = 100;
t0 = 0;
tf = 6;
tspan = linspace(t0, tf, 100); % 100 steps for simulation

% Arrays to store trajectories
height_data = zeros(numel(tspan), num_trajectories);
range_data = zeros(numel(tspan), num_trajectories);

% Simulate 100 trajectories with random parameters
for i = 1:num_trajectories
    % Generate random parameters within expected ranges
    V_rand = 2 + (7.5 - 2) * rand(1); % Interval [+2,+7.5]
    Gam_rand = -0.5 + (0.4 + 0.5) * rand(1); % Interval [-0.5, 0.4]
    
    % Simulate trajectory
    [t, height, range] = simulate_trajectory(V_rand, Gam_rand, tspan);
    
    % Store trajectory data
    height_data(:, i) = height;
    range_data(:, i) = range;
    
    % Plot individual trajectory
    plot(range, height, 'Color', rand(1,3), 'LineStyle', '-', 'LineWidth', 0.5);
    hold on;
end

% Plot nominal trajectory
[V_nominal, Gam_nominal] = deal(3.55, -0.18); % Nominal values
[t_nominal, height_nominal, range_nominal] = simulate_trajectory(V_nominal, Gam_nominal, tspan);
plot(range_nominal, height_nominal, 'k-', 'LineWidth', 2);

% Fit polynomials to average trajectory
poly_order = 5; % Choose a suitable polynomial order
p_range = polyfit(tspan, mean(range_data, 2), poly_order);
p_height = polyfit(tspan, mean(height_data, 2), poly_order);

% Compute first time derivatives
d_range_dt = polyder(p_range);
d_height_dt = polyder(p_height);

% Plot first time derivatives
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

% Function to simulate trajectory
function [t, height, range] = simulate_trajectory(V, Gam, tspan)
    % Simulation logic goes here
    % This function should return arrays of time, height, and range values
    % based on the initial velocity (V), flight path angle (Gam), and time span (tspan)
    % For demonstration purposes, let's assume some simple simulation
    t = tspan;
    range = V * t;
    height = tan(Gam) * range - 0.5 * 9.81 * (range.^2) / (V^2 * cos(Gam)^2);
end
