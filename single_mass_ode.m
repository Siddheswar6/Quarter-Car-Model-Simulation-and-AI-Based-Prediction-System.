function dxdt = single_mass_ode(t, x, m, k, c, road_profile, t_vec)
    % Ensure that t_vec and road_profile have the same length
    x_r = interp1(t_vec, road_profile, t, 'linear', 'extrap');  % Interpolate road profile at time t
    displacement = x(1);   % Displacement of mass
    velocity = x(2);       % Velocity of mass
    
    % Equation of motion: m * a = -k * (x - x_r) - c * v
    dx = velocity;
    dv = (-k * (displacement - x_r) - c * velocity) / m;
    
    % Return derivatives
    dxdt = [dx; dv];
end
