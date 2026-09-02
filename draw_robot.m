function draw_robot(x, y)
    % Draw the body of the robot (rectangle)
    bodyWidth = 0.6; % Width of the robot body
    bodyLength = 0.3; % Length of the robot body
    bodyX = [-bodyWidth/2, bodyWidth/2, bodyWidth/2, -bodyWidth/2]; % Robot body outline
    bodyY = [-bodyLength/2, -bodyLength/2, bodyLength/2, bodyLength/2]; % Robot body outline
    
    % Draw the robot body in blue
    fill(x + bodyX, y + bodyY, [0, 0, 1], 'EdgeColor', 'k'); % Body color (blue)
    
    % Draw the wheels (circles)
    wheelRadius = 0.085; % Increased radius of the wheels
    % Positions of the wheels (adjusted to be closer to the body)
    wheelPositions = [
        -bodyWidth/2 + 0.05, -bodyLength/2 - 0.05; % Left front 
        bodyWidth/2 - 0.1, -bodyLength/2 - 0.05;   % Right front
        -bodyWidth/2 + 0.05, bodyLength/2 - 0.02;  % Left rear
        bodyWidth/2 - 0.1, bodyLength/2 - 0.02     % Right rear
    ];
    
    % Draw wheels at each corner
    for i = 1:size(wheelPositions, 1)
        rectangle('Position', [x + wheelPositions(i, 1), y + wheelPositions(i, 2), wheelRadius, wheelRadius], ...
                  'Curvature', [1, 1], 'FaceColor', 'k'); % Wheels are black
    end
    
    % Draw the circular top mount (in orange) centered on the body
    topMountRadius = 0.13; % Radius of the top mount
    topMountX = x; % X position for the center of the top mount
    topMountY = y; % Y position at the center of the body
    
    % Draw the top mount
    rectangle('Position', [topMountX - topMountRadius, topMountY - topMountRadius, topMountRadius * 2, topMountRadius * 2], ...
              'Curvature', [1, 1], 'FaceColor', [1, 0.5, 0], 'EdgeColor', 'k'); % Circle in orange
end
