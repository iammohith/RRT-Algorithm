function start_simulation(m, n, startCell, goalCell, obstacles)
    % RRT (Rapidly-exploring Random Tree) Pathfinding Simulation
    % Entry point that orchestrates the complete simulation workflow:
    %   1. Display the problem statement (grid with start, goal, obstacles)
    %   2. Display the RRT tree growth (animated)
    %   3. Animate the shortest path simulation along the extracted path
    %
    % RRT is run ONCE and results are shared across all visualization steps
    % to ensure consistent tree and path display.

    % First output: Grid display (Problem Statement)
    display_grid(m, n, startCell, goalCell, obstacles);
    title('Problem Statement');
    pause(5); % Pause for 5 seconds to view the grid

    % Run RRT algorithm ONCE — share results across all visualizations
    [tree, path, success] = rrt_algorithm(m, n, startCell, goalCell, obstacles);

    % Second output: RRT tree growth (animated)
    display_tree(m, n, startCell, goalCell, obstacles, tree, path, success);
    title('RRT Tree Growth');
    pause(5); % Pause for 5 seconds to view the tree

    % Third output: Shortest path simulation (uses same tree and path)
    shortest_path(m, n, startCell, goalCell, obstacles, tree, path, success);
    title('RRT Path Simulation');
end
