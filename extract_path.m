function path = extract_path(tree, success)
    % Extract the path from start to goal by backtracking through the RRT tree
    % Inputs:
    %   tree    - Nx3 matrix [row, col, parentIndex] representing the RRT tree
    %   success - Boolean indicating if the goal was reached
    % Output:
    %   path    - Px2 matrix of [row, col] from start to goal
    %             Returns empty matrix if goal was not reached

    if ~success
        path = [];
        return;
    end

    % Start from the last node (goal node) and backtrack to root
    path = [];
    idx = size(tree, 1); % Last added node is the goal

    while idx > 0
        path = [tree(idx, 1:2); path]; % Prepend to path
        idx = tree(idx, 3); % Move to parent
    end
end
