function display_grid(m, n, startCell, goalCell, obstacles)
    % Validate input arguments
    totalCells = m * n;
    
    % Check if startCell is within range
    if startCell < 1 || startCell > totalCells
        error('Start cell is out of range. It must be between 1 and %d.', totalCells);
    end
    
    % Check if goalCell is within range
    if goalCell < 1 || goalCell > totalCells
        error('Goal cell is out of range. It must be between 1 and %d.', totalCells);
    end
    
    % Check if any obstacle is out of range
    if any(obstacles < 1) || any(obstacles > totalCells)
        error('One or more obstacle cells are out of range. Each must be between 1 and %d.', totalCells);
    end

    % Create the grid figure
    figure;
    hold on;
    title('Problem Statement');
    axis equal;
    grid on;
    xlim([0 n]);
    ylim([0 m]);
    set(gca, 'XTick', [], 'YTick', []); % Hide axis ticks
    axis off; % Hide the axis

    % Draw the grid cells
    for row = 1:m
        for col = 1:n
            % Draw the cell with default white background
            rectangle('Position', [col-1, m-row, 1, 1], 'EdgeColor', 'k', 'FaceColor', 'w');
        end
    end

    % Convert linear indices to row-column for row-major order
    [startRow, startCol] = index_to_rowcol(startCell, m, n);
    [goalRow, goalCol] = index_to_rowcol(goalCell, m, n);

    % Highlight the start cell in green
    rectangle('Position', [startCol-1, m-startRow, 1, 1], 'EdgeColor', 'k', 'FaceColor', 'g');

    % Highlight the goal cell in red
    rectangle('Position', [goalCol-1, m-goalRow, 1, 1], 'EdgeColor', 'k', 'FaceColor', 'r');

    % Highlight the obstacle cells in black
    for i = 1:length(obstacles)
        [obsRow, obsCol] = index_to_rowcol(obstacles(i), m, n);
        rectangle('Position', [obsCol-1, m-obsRow, 1, 1], 'EdgeColor', 'k', 'FaceColor', 'k');
    end

    % Draw the robot at the start cell
    draw_robot(startCol - 0.5, m - startRow + 0.5); % Center the robot at the start cell

    hold off;
end
