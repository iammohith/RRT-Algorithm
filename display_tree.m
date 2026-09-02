function display_tree(m, n, startCell, goalCell, obstacles, tree, path, success)
    % Display the RRT tree growth on the grid
    % Shows all tree edges and nodes, highlighting the path from start to goal
    % Inputs:
    %   m, n      - Grid dimensions
    %   startCell - Linear index of the start cell
    %   goalCell  - Linear index of the goal cell
    %   obstacles - Array of obstacle cell indices
    %   tree      - Nx3 matrix [row, col, parentIndex] from rrt_algorithm
    %   path      - Px2 matrix [row, col] from start to goal
    %   success   - Boolean indicating if the goal was reached

    % Create the grid figure
    figure;
    hold on;
    title('RRT Tree Growth');
    axis equal;
    xlim([0 n]);
    ylim([0 m]);
    set(gca, 'XTick', [], 'YTick', []);
    axis off;

    % Draw the base grid cells
    for row = 1:m
        for col = 1:n
            cellIndex = (row - 1) * n + col;

            if any(obstacles == cellIndex)
                color = [0 0 0]; % Black for obstacles
            elseif cellIndex == goalCell
                color = [1 0 0]; % Red for goal
            elseif cellIndex == startCell
                color = [0 1 0]; % Green for start
            else
                color = [1 1 1]; % White for free cells
            end

            rectangle('Position', [col-1, m-row, 1, 1], 'EdgeColor', 'k', 'FaceColor', color);
        end
    end

    % Animate tree edge growth
    for i = 2:size(tree, 1)
        parentIdx = tree(i, 3);

        % Child and parent positions (centered in cells)
        childCol = tree(i, 2) - 0.5;
        childRow = m - tree(i, 1) + 0.5;
        parentCol = tree(parentIdx, 2) - 0.5;
        parentRow = m - tree(parentIdx, 1) + 0.5;

        % Draw tree edge (light blue)
        plot([parentCol, childCol], [parentRow, childRow], ...
            'Color', [0.4 0.6 0.9], 'LineWidth', 1.5);

        % Draw tree node
        plot(childCol, childRow, 'o', 'MarkerSize', 6, ...
            'MarkerFaceColor', [0.3 0.5 0.8], 'MarkerEdgeColor', 'k');

        pause(0.15); % Animate the growth
    end

    % Draw start node prominently
    [startRow, startCol] = index_to_rowcol(startCell, m, n);
    plot(startCol - 0.5, m - startRow + 0.5, 'o', 'MarkerSize', 10, ...
        'MarkerFaceColor', [0 0.8 0], 'MarkerEdgeColor', 'k', 'LineWidth', 2);

    % Highlight the path from start to goal (if found)
    if success && ~isempty(path)
        for i = 1:size(path, 1) - 1
            p1Col = path(i, 2) - 0.5;
            p1Row = m - path(i, 1) + 0.5;
            p2Col = path(i + 1, 2) - 0.5;
            p2Row = m - path(i + 1, 1) + 0.5;

            % Draw path edge (thick red)
            plot([p1Col, p2Col], [p1Row, p2Row], 'r-', 'LineWidth', 3);
            pause(0.3); % Animate path highlighting
        end

        % Draw goal node prominently
        [goalRow, goalCol] = index_to_rowcol(goalCell, m, n);
        plot(goalCol - 0.5, m - goalRow + 0.5, 'o', 'MarkerSize', 10, ...
            'MarkerFaceColor', [1 0 0], 'MarkerEdgeColor', 'k', 'LineWidth', 2);
    else
        text(n/2, m/2, 'Goal Not Reached!', ...
            'HorizontalAlignment', 'center', 'Color', 'r', ...
            'FontSize', 14, 'FontWeight', 'bold');
    end

    % Display tree statistics
    text(n/2, -0.3, sprintf('Tree Nodes: %d  |  Path Length: %d steps', ...
        size(tree, 1), max(0, size(path, 1) - 1)), ...
        'HorizontalAlignment', 'center', 'FontSize', 10, 'FontWeight', 'bold');

    hold off;
end
