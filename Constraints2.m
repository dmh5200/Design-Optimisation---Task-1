% function needs to output the nonlinear constraints for each input variable
% need to use some logic to choose whether to use axial stress constraints or buckling constraints

function [c,ceq] = Constraints2(X)
    
    % Inputs
    % X: vector of design variables
    x_c = X(1); % x-coordinate of point C [m]
    R_ab = X(2); % radius of strut AB [m]
    R_bc = X(3); % radius of strut BC [m]
    R_ac = X(4); % radius of strut AC [m]
   
    % Call constants function
    constants = getConstants();

    % Safety factor
    f_s = 1.5;

    % Forces in struts
    F_ab = f_s*(constants.F_y + constants.F_x*(constants.y_a/x_c)); % Force in strut AB [N]
    F_ac = f_s*((-1*constants.F_x*sqrt((x_c^2)+(constants.y_a^2)))/x_c); % Force in strut AC [N]
    F_bc = f_s*(constants.F_x); % Force in strut BC [N]
    
    % Axial stress constraints
    % Stress in strut AB
    sigma_ab = f_s*abs(((-1*constants.F_y)+(constants.F_x*(constants.y_a/x_c)))/(pi*((2*constants.t*R_ab)-constants.t^2)));
    % Stress in strut BC
    sigma_bc = f_s*abs(constants.F_x/(pi*((2*constants.t*R_bc)-constants.t^2)));
    % Stress in strut AC
    sigma_ac = f_s*abs(((-1*constants.F_y*sqrt(x_c^2+constants.y_a^2))/x_c)/(pi*((2*constants.t*R_ac)-constants.t^2)));

    % Buckling constraints
    % Buckling in strut AB
    buckling_ab = -1*(((pi^2)*constants.E_s*(pi/4)*((R_ab^4) - ((R_ab - constants.t)^4)))/(constants.y_a^2));
    % Buckling in strut BC
    buckling_bc = -1*(((pi^2)*constants.E_s*(pi/4)*((R_bc^4) - ((R_bc - constants.t)^4)))/(x_c^2));
    % Buckling in strut AC
    buckling_ac = -1*(((pi^2)*constants.E_s*(pi/4)*((R_ac^4) - ((R_ac - constants.t)^4)))/(sqrt(x_c^2+constants.y_a^2)^2));

    % Nonlinear inequality constraints
    c = [sigma_ab - constants.sigma_y;
         sigma_bc - constants.sigma_y;
         sigma_ac - constants.sigma_y;
         buckling_ab - F_ab;
         buckling_bc - F_bc;
         buckling_ac - F_ac];

     % Debugging information
     % fprintf('Constraints values:\n');
     % fprintf('sigma_ab - sigma_y: %f\n', sigma_ab - constants.sigma_y);
     % fprintf('sigma_bc - sigma_y: %f\n', sigma_bc - constants.sigma_y);
     % fprintf('sigma_ac - sigma_y: %f\n', sigma_ac - constants.sigma_y);
     % fprintf('buckling_ab - F_ab: %f\n', buckling_ab - F_ab);
     % fprintf('buckling_bc - F_bc: %f\n', buckling_bc - F_bc);
     % fprintf('buckling_ac - F_ac: %f\n', buckling_ac - F_ac);
    
    ceq = [];
    end