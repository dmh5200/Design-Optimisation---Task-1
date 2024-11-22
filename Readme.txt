# InteriorPoint2 Optimization

This MATLAB script performs optimization using the `fmincon` function with the interior-point algorithm. The script is designed to find the optimal parameters for a given objective function while satisfying specified constraints.

## Files

- `InteriorPoint2.m`: Main script that runs the optimization.
- `ObjectiveFunctionV2.m`: Defines the objective function to be minimized.
- `Constraints2.m`: Defines the nonlinear constraints for the optimization.
- `drawFrame.m`: Function to visualize the optimized frame.
- `SanityCheck.m`: Function to perform a sanity check on the optimized parameters.

## Usage

**Run the Script**: Execute `InteriorPoint2.m` to perform the optimization.

## Script Details

### Initialization

- The script initializes the optimization problem by specifying the objective function, constraints, and bounds.
- Latin Hypercube Sampling (LHS) is used to generate multiple starting points for the optimization.

### Optimization Loop

- The script runs the optimizer iteratively for a specified number of iterations.
- For each iteration, the script:
  - Initializes the starting point.
  - Runs the `fmincon` function with the interior-point algorithm.
  - Stores the objective value for convergence plotting.
  - Checks if the solution is feasible and updates the best result if the current solution is better.

### Output

- The script displays the best optimized parameters and their objective value.
- A convergence plot is generated to visualize the optimization process.
- The `drawFrame` function is called to visualize the optimized frame.
- The `SanityCheck` function is called to verify the optimized parameters.

## Example

To run the optimization, simply execute the `InteriorPoint2.m` script in MATLAB:

```matlab
run('InteriorPoint2.m');