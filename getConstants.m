function constants = getConstants()
    % Fixed parameters
    D = 5; % Rotor diameter [m]
    constants.y_a = 1.3*D; % Rotor hub height [m]
    constants.m = 300; % Rotor mass [kg]
    constants.F_y = -9.81*constants.m; % Rotor weight [N]
    C_t = 0.9; % Thrust coefficient [-]
    V = 25; % Wind speed [m/s]
    A = pi*(D/2)^2; % Rotor swept area [m^2]
    rho_air = 1.225; % Air density [kg/m^3]
    constants.F_x = 0.5*C_t*rho_air*A*V^2; % Thrust force [N]
    constants.t = 0.006; % strut wall thickness [m]
    constants.rho_s = 2700; % strut material density [kg/m^3]
    constants.E_s = 70e9; % strut material Young's modulus [Pa]
    constants.sigma_y = 30e6; % strut material yield stress [Pa]
    constants.cost = 500; % strut material cost [£/kg]

end