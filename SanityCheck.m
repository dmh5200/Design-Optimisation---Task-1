% Function that returns stress and force in each of the beams
% Compares stress and force to yield stress and buckling force

function SanityCheck(X)

% Extract variables from input vector X
x_c = X(1);  % length of strut BC [m]
R_ab = X(2); % radius of strut AB [m]
R_bc = X(3); % radius of strut BC [m]
R_ac = X(4); % radius of strut AC [m]

% Inputs
constants = getConstants();

% Forces in struts
F_ab = constants.F_y + constants.F_x*(constants.y_a/x_c); % Force in strut AB [N]
F_ac = (-1*constants.F_x*sqrt(x_c^2+constants.y_a^2))/x_c; % Force in strut AC [N]
F_bc = constants.F_x; % Force in strut BC [N]

% Axial stress constraints
fprintf('Yield stress: %f MPa. \n', constants.sigma_y/1e6);
% Stress in strut AB
sigma_ab = abs(((-1*constants.F_y)+(constants.F_x*(constants.y_a/x_c)))/(pi*((2*constants.t*R_ab)-constants.t^2)));
fprintf('Stress in strut AB: %f MPa.\n', sigma_ab/1e6);
% Stress in strut BC
sigma_bc = abs(constants.F_x/(pi*((2*constants.t*R_bc)-constants.t^2)));
fprintf('Stress in strut BC: %f MPa. \n', sigma_bc/1e6);
% Stress in strut AC
sigma_ac = abs(((-1*constants.F_y*sqrt(x_c^2+constants.y_a^2))/x_c)/(pi*((2*constants.t*R_ac)-constants.t^2)));
fprintf('Stress in strut AC: %f MPa. \n', sigma_ac/1e6);

% Buckling constraints
% Buckling in strut AB
buckling_ab = -1*((pi^2*constants.E_s*(pi/4)*((2*constants.t*R_ab)-constants.t^2))/(constants.y_a^2));
fprintf('Critical buckling load in strut AB: %f kN. \n', buckling_ab/1e3);
fprintf('Force in strut AB: %f kN. \n', F_ab/1e3);
% Buckling in strut BC
buckling_bc = -1*((pi^2*constants.E_s*(pi/4)*((2*constants.t*R_bc)-constants.t^2))/(x_c^2));
fprintf('Critical buckling load in strut BC: %f kN. \n', buckling_bc/1e3);
fprintf('Force in strut BC: %f kN. \n', F_bc/1e3);

% Buckling in strut AC
buckling_ac = -1*((pi^2*constants.E_s*(pi/4)*((2*constants.t*R_ac)-constants.t^2))/(sqrt(x_c^2+constants.y_a^2)^2));
fprintf('Critical buckling load in strut AC: %f kN. \n', buckling_ac/1e3);
fprintf('Force in strut AC: %f kN. \n', F_ac/1e3);



