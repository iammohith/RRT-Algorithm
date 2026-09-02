function [tree, path, success] = rrt_algorithm(m, n, startCell, goalCell, obstacles, maxIter)
    % RRT (Rapidly-exploring Random Tree) Algorithm for pathfinding
    % Builds a tree by randomly sampling cells and extending toward them.
    % This is a probabilistic (sampling-based) planner — the tree and path
    % may differ between runs due to randomness.
    % Inputs:
    %   m, n      - Grid dimensions (rows, columns)
    %   startCell - Linear index of the start cell (row-major order)
    %   goalCell  - Linear index of the goal cell (row-major order)
    %   obstacles - Array of linear indices representing obstacle cells
    %   maxIter   - Maximum number of iterations (default: 1000)
    % Outputs:
    %   tree    - Nx3 matrix where each row is [row, col, parentIndex]
    %   path    - Px2 matrix of [row, col] from start to goal (empty if failed)
    %   success - Boolean indicating if the goal was reached

    % Default max iterations
    if nargin < 6
        maxIter = 1000;
    end

    % Convert to row-column indices
    [startRow, startCol] = index_to_rowcol(startCell, m, n);
    [goalRow, goalCol] = index_to_rowcol(goalCell, m, n);

    % Create obstacle map
    obstacle_map = false(m, n);
    for i = 1:length(obstacles)
        [obsRow, obsCol] = index_to_rowcol(obstacles(i), m, n);
        obstacle_map(obsRow, obsCol) = true;
    end

    % Initialize tree with start node
    % Tree format: [row, col, parentIndex] (parentIndex = 0 for root)
    tree = [startRow, startCol, 0];
    in_tree = false(m, n);
    in_tree(startRow, startCol) = true;

    success = false;

    % Directions for moving: up, down, left, right (4-connectivity)
    directions = [0, 1; 0, -1; -1, 0; 1, 0];

    for iter = 1:maxIter
        % === Step 1: Random Sampling with Goal Bias ===
        % 30% chance to sample the goal (goal bias accelerates convergence)
        if rand() < 0.3
            sampleRow = goalRow;
            sampleCol = goalCol;
        else
            sampleRow = randi(m);
            sampleCol = randi(n);
        end

        % Skip if sample is an obstacle or already in tree
        if obstacle_map(sampleRow, sampleCol)
            continue;
        end

        % === Step 2: Find Nearest Node in Tree ===
        minDist = Inf;
        nearestIdx = 1;
        for i = 1:size(tree, 1)
            d = abs(tree(i, 1) - sampleRow) + abs(tree(i, 2) - sampleCol);
            if d < minDist
                minDist = d;
                nearestIdx = i;
            end
        end

        nearRow = tree(nearestIdx, 1);
        nearCol = tree(nearestIdx, 2);

        % === Step 3: Steer — Move One Step Toward Sample ===
        bestNewRow = 0;
        bestNewCol = 0;
        bestDist = Inf;
        found = false;

        for d = 1:size(directions, 1)
            newRow = nearRow + directions(d, 1);
            newCol = nearCol + directions(d, 2);

            % Check bounds
            if newRow >= 1 && newRow <= m && newCol >= 1 && newCol <= n
                % Check not obstacle and not already in tree
                if ~obstacle_map(newRow, newCol) && ~in_tree(newRow, newCol)
                    dist = abs(newRow - sampleRow) + abs(newCol - sampleCol);
                    if dist < bestDist
                        bestDist = dist;
                        bestNewRow = newRow;
                        bestNewCol = newCol;
                        found = true;
                    end
                end
            end
        end

        % Skip if no valid move found
        if ~found
            continue;
        end

        % === Step 4: Add New Node to Tree ===
        tree(end + 1, :) = [bestNewRow, bestNewCol, nearestIdx];
        in_tree(bestNewRow, bestNewCol) = true;

        % === Step 5: Check if Goal Reached ===
        if bestNewRow == goalRow && bestNewCol == goalCol
            success = true;
            break;
        end
    end

    % === Extract Path from Tree ===
    path = extract_path(tree, success);
end
