function drawFrame(best_Xopt)

% Define the coordinates of points A, B, and C
constants = getConstants();
y_a = constants.y_a;
x_c = best_Xopt(1);
r1 = best_Xopt(2);
r2 = best_Xopt(3);
r3 = best_Xopt(4);

A = [0, y_a];
B = [0, 0];
C = [x_c, 0];

% Plot the triangular frame
figure;
hold on;
plot([A(1), B(1)], [A(2), B(2)], 'k-', 'LineWidth', 3); % AB
plot([B(1), C(1)], [B(2), C(2)], 'k-', 'LineWidth', 3); % BC
plot([C(1), A(1)], [C(2), A(2)], 'k-', 'LineWidth', 3); % CA

% Label the corners
text(A(1), A(2), 'A', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom');
text(B(1), B(2), 'B', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top');
text(C(1), C(2), 'C', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top');


% Label the lengths and radii
text(((A(1)+B(1))/2)-0.2, (A(2)+B(2))/2, sprintf('L1 = %.2f (m), r1 = %.2f (m)', norm(A-B), r1), 'HorizontalAlignment', 'right');
text(((B(1)+C(1))/2), ((B(2)+C(2))/2)+0.3, sprintf('L2 = %.2f (m), r2 = %.2f (m)', norm(B-C), r2), 'HorizontalAlignment', 'center');
text(((C(1)+A(1))/2)+0.2, (C(2)+A(2))/2, sprintf('L3 = %.2f (m), r3 = %.2f (m)', norm(C-A), r3), 'HorizontalAlignment', 'left');

% Illustrate the hub and rotor
hub_length = 0.1 * x_c; % Example length for the hub
rotor_length = 0.2 * y_a; % Example length for the rotor

% Hub (horizontal line)
plot([A(1), A(1) - hub_length], [A(2), A(2)], 'b-', 'LineWidth', 2);

% Rotor (vertical line)
plot([A(1) - hub_length, A(1) - hub_length], [A(2) - rotor_length, A(2) + rotor_length], 'r-', 'LineWidth', 2);

% Add labels for hub and rotor
text(C(1) + hub_length/2, A(2) - 0.05*y_a, 'Hub', 'HorizontalAlignment', 'center');
text(C(1) + hub_length + 0.05*x_c, A(2) + rotor_length/2, 'Rotor', 'HorizontalAlignment', 'left');

% Set plot limits and labels
xlim([-0.1*x_c, 1.2*x_c]);
ylim([-0.1*y_a, 1.2*y_a]);
xlabel('X (m)', 'FontSize', 26);
ylabel('Y (m)', 'FontSize', 26);
grid on;
axis equal;
hold off;