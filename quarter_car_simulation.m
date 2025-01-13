% Define constants for the quarter car model (single mass)
m = 250;         % Mass (kg)
k = 20000;       % Suspension stiffness (N/m)
c = 1500;        % Damping coefficient (Ns/m)

% Time vector
t = linspace(0, 10, 1000);  % 0 to 10 seconds, 1000 samples

% Define road profile (example: a sine wave for road disturbance)
road_profile = 0.05 * sin(2 * pi * t);  % Amplitude 5 cm, sinusoidal disturbance

% Initial conditions [displacement(0), velocity(0)]
x0 = [0; 0];

% Solve the ODE system using ode45, passing both the time vector and the road profile
[t, sol] = ode45(@(t, x) single_mass_ode(t, x, m, k, c, road_profile, t), t, x0);

% Extract the results
displacement = sol(:, 1);  % Displacement of the mass
velocity = sol(:, 2);      % Velocity of the mass

% Plot the results for visualization
figure;
subplot(2,1,1);
plot(t, displacement);
title('Mass Displacement');
xlabel('Time (s)');
ylabel('Displacement (m)');

subplot(2,1,2);
plot(t, velocity);
title('Mass Velocity');
xlabel('Time (s)');
ylabel('Velocity (m/s)');

% Create a dataset with road profile and system responses
dataset = table(t', road_profile', displacement, velocity, 'VariableNames', ...
    {'Time', 'RoadProfile', 'Displacement', 'Velocity'});

% Save dataset to CSV
writetable(dataset, 'single_mass_quarter_car_dataset.csv');
