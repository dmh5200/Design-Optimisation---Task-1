% Specify the function fmincon() will minimize
fun = @ObjectiveFunctionV2;

% Declare the constraints
A = [];
b = [];
Aeq = [];
beq = [];
lb = [0;0.006;0.006;0.006];
ub = [];
ub_LHS = [20;4;4;4]; % Upper bounds for initial samples


nonlcon = @Constraints2; % Define nonlinear constraints

% Each optimizer has an 'options' object that the user can customize
options = optimoptions('fmincon','Algorithm','interior-point','SpecifyObjectiveGradient',true,'Display','iter');

% Number of iterations
num_iterations = 10;

% Generate Latin Hypercube samples
samples = lhsdesign(num_iterations, 4);
X0_samples = bsxfun(@plus, lb', bsxfun(@times, samples, (ub_LHS - lb)'));

% Initialize variables to store the best result
best_fval = Inf;
best_Xopt = [];
fval_matrix = zeros(num_iterations, 1);
%iteration_data = cell(num_iterations, 1); % To store iteration data for each run


% Run the optimizer iteratively
for i = 1:num_iterations
    X0 = X0_samples(i, :)';
    fprintf('Iteration %d with starting point: [%f, %f, %f, %f]\n', i, X0);
    iteration_data{i} = []; % Initialize iteration data for this run
    [Xopt, fval, exitflag] = fmincon(fun, X0, A, b, Aeq, beq, lb, [], nonlcon, options);
    fprintf('Optimized parameters: [%f, %f, %f, %f] with objective value: %f\n', Xopt, fval);
    
    % Store the fval for convergence plot
    fval_matrix(i) = fval;
    
    % Check if the solution is feasible
    [c, ceq] = nonlcon(Xopt);
    if all(c <= 0) && all(abs(ceq) <= 1e-6) && exitflag > 0
        fprintf('Feasible solution found with objective value: %f\n', fval);
        % Update the best result if the current one is better
        if fval < best_fval
            best_fval = fval;
            best_Xopt = Xopt;
        end
    else
        fprintf('Infeasible solution or optimization did not converge.\n');
    end
end

% Display the best result
if ~isempty(best_Xopt)
    fprintf('Best optimized parameters: [%f, %f, %f, %f] with objective value: %f\n', best_Xopt, best_fval);
    % Sanity check
    SanityCheck(best_Xopt);
else
    fprintf('No feasible solution found.\n');
end
% Plot the convergence
figure;
plot(1:num_iterations, fval_matrix, '-o');
hold on;
plot(find(fval_matrix == best_fval), best_fval, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
xlabel('Iteration', 'FontSize', 26);
ylabel('Cost (thousand £)', 'FontSize', 26);
legend('Cost (thousand £)', 'Best solution');
grid on;
hold off;

% set axes tick font size
set(gca, 'FontSize', 22);

    % % Plot the convergence for each iteration
    % figure;
    % hold on;
    % for i = 1:num_iterations
    %     plot(iteration_data{i}(:, 1), iteration_data{i}(:, 2), '-o');
    % end
    % xlabel('Iteration');
    % ylabel('Objective Value (fval)');
    % title('Convergence Plot for Each Iteration');
    % legend(arrayfun(@(x) sprintf('Run %d', x), 1:num_iterations, 'UniformOutput', false));
    % grid on;
    % hold off;

    % Draw frame
    drawFrame(best_Xopt);


    % function stop = outfun(x, optimValues, state, i, iteration_data)
    %     stop = false;
    %     switch state
    %         case 'iter'
    %             % Record the iteration data
    %             fprintf('Iteration %d: fval = %f\n', optimValues.iteration, optimValues.fval);
    %             iteration_data{i} = [iteration_data{i}; optimValues.iteration, optimValues.fval];
    %     end
    % end
