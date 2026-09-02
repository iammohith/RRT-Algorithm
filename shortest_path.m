function shortest_path(m, n, startCell, goalCell, obstacles, tree, path, success)
    % Visualize the RRT path with animated robot movement
    % Uses pre-computed tree and path from rrt_algorithm (passed as arguments)
    % Inputs:
    %   m, n      - Grid dimensions
    %   startCell - Linear index of the start cell
    %   goalCell  - Linear index of the goal cell
    %   obstacles - Array of obstacle cell indices
    %   tree      - Nx3 matrix [row, col, parentIndex] from rrt_algorithm
    %   path      - Px2 matrix [row, col] from start to goal
    %   success   - Boolean indicating if the goal was reached

    % Create the base grid
    display_grid(m, n, startCell, goalCell, obstacles);

    hold on;

    % Draw all tree edges (faint background)
    for i = 2:size(tree, 1)
        parentIdx = tree(i, 3);
        childCol = tree(i, 2) - 0.5;
        childRow = m - tree(i, 1) + 0.5;
        parentCol = tree(parentIdx, 2) - 0.5;
        parentRow = m - tree(parentIdx, 1) + 0.5;

        plot([parentCol, childCol], [parentRow, childRow], ...
            'Color', [0.8 0.85 0.95], 'LineWidth', 1);
    end

    if success && ~isempty(path)
        % Draw the path edges (red)
        for i = 1:size(path, 1) - 1
            p1Col = path(i, 2) - 0.5;
            p1Row = m - path(i, 1) + 0.5;
            p2Col = path(i + 1, 2) - 0.5;
            p2Row = m - path(i + 1, 1) + 0.5;

            plot([p1Col, p2Col], [p1Row, p2Row], 'r-', 'LineWidth', 2.5);
        end

        % Animate robot along the path
        for idx = 1:size(path, 1)
            row = path(idx, 1);
            col = path(idx, 2);

            draw_robot(col - 0.5, m - row + 0.5);

            % Display step number
            text(col - 0.5, m - row + 0.5, num2str(idx - 1), ...
                'HorizontalAlignment', 'center', 'Color', 'k', ...
                'FontSize', 12, 'FontWeight', 'bold');

            pause(0.75);
        end

        % Display path length
        text(n/2, -0.3, sprintf('Path Length: %d steps', size(path, 1) - 1), ...
            'HorizontalAlignment', 'center', 'FontSize', 10, 'FontWeight', 'bold');
    else
        % Goal not reached
        [startRow, startCol] = index_to_rowcol(startCell, m, n);
        draw_robot(startCol - 0.5, m - startRow + 0.5);
        text(n/2, m/2, 'Goal Not Reached!', ...
            'HorizontalAlignment', 'center', 'Color', 'r', ...
            'FontSize', 14, 'FontWeight', 'bold');
    end

    hold off;
end
