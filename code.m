% Define time vector
t = linspace(0, 10, 1000);  % 0 to 10 seconds, 1000 samples

% Define ranges for mass, damping coefficient, and spring coefficient
mass_values = 200:50:400;   % Masses between 200 kg and 400 kg
damping_values = 1000:500:3000;  % Damping coefficients between 1000 Ns/m and 3000 Ns/m
spring_values = 15000:5000:25000;  % Spring coefficients between 15000 N/m and 25000 N/m

% Initial displacement and velocity
initial_displacement = 0.1;  % Initial displacement in meters
initial_velocity = 0;  % Initial velocity in m/s

% Placeholder for dataset
dataset = [];

% Function for the system of ODEs
function dxdt = quarter_car_ode(t, x, m, k, c)
    displacement = x(1);   % Displacement of mass
    velocity = x(2);       % Velocity of mass
    % Equation of motion: m * a = -k * x - c * v
    dx = velocity;
    dv = (-k * displacement - c * velocity) / m;
    dxdt = [dx; dv];
end

% Loop over all combinations of mass, damping, and spring values
for m = mass_values
    for c = damping_values
        for k = spring_values
            % Initial conditions [displacement(0), velocity(0)]
            x0 = [initial_displacement; initial_velocity];

            % Solve the ODE system using ode45
            [t, sol] = ode45(@(t, x) quarter_car_ode(t, x, m, k, c), t, x0);

            % Extract the results
            displacement = sol(:, 1);  % Displacement of the mass
            velocity = sol(:, 2);      % Velocity of the mass

            % Append the data to the dataset
            % Repeat mass, damping, and spring coefficient for each time step
            mass_col = m * ones(size(t));
            damping_col = c * ones(size(t));
            spring_col = k * ones(size(t));

            % Append to the dataset
            dataset = [dataset; [t, mass_col, damping_col, spring_col, displacement, velocity]];
        end
    end
end

% Convert the dataset into a table
dataset_table = array2table(dataset, 'VariableNames', ...
    {'Time', 'Mass', 'DampingCoefficient', 'SpringCoefficient', 'Displacement', 'Velocity'});

% Save dataset to CSV
writetable(dataset_table, 'quarter_car_dataset.csv');

% Display completion message
disp('Dataset created and saved as "quarter_car_dataset.csv"');
