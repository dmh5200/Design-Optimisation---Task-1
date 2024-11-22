function [f, J] = ObjectiveFunctionV2(X)
    % Extract variables from input vector X
    x_c = X(1);  % length of strut BC [m]
    R_ab = X(2); % radius of strut AB [m]
    R_bc = X(3); % radius of strut BC [m]
    R_ac = X(4); % radius of strut AC [m]

    % Fixed parameters
    % Call constants function
    constants = getConstants();

    % Define symbolic variables
    syms R_ab_sym R_bc_sym R_ac_sym x_c_sym

    % Use symbolic variables in the objective function
    A_ab = pi*((2*constants.t*R_ab_sym)-constants.t^2); % strut AB cross-sectional area [m^2]
    A_bc = pi*((2*constants.t*R_bc_sym)-constants.t^2); % strut BC cross-sectional area [m^2]
    A_ac = pi*((2*constants.t*R_ac_sym)-constants.t^2); % strut CD cross-sectional area [m^2]

    L_ab = constants.y_a; % strut AB length [m]
    L_bc = x_c_sym; % strut BC length [m]
    L_ac = sqrt(L_ab^2 + L_bc^2); % strut AC length [m]

    % Calculate objective function value (outputs cost of structure)
    f_sym = constants.cost * constants.rho_s * (A_ab * L_ab + A_bc * L_bc + A_ac * L_ac);

    % Substitute numerical values into the symbolic objective function
    f = double(subs(f_sym, [x_c_sym, R_ab_sym, R_bc_sym, R_ac_sym], [x_c, R_ab, R_bc, R_ac]));

    % If the function receives more than 1 output variable
    % i.e. [f, J]
    if nargout > 1
        % Calculate the Jacobian
        X_sym = [x_c_sym, R_ab_sym, R_bc_sym, R_ac_sym];
        J_sym = jacobian(f_sym, X_sym);

        % Substitute numerical values into the Jacobian matrix
        J_num = subs(J_sym, X_sym, [x_c, R_ab, R_bc, R_ac]);

        % Convert the substituted Jacobian matrix to double type
        J = double(J_num);
    end
end