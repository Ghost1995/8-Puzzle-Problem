function plotPath(nodePath)
% This function visualizes the nodePath generated.

% Check if all variables were defined correctly
if nargin == 0
    disp('Node Path not defined');
    return;
elseif isempty(nodePath)
    disp('Node Path is empty');
    return;
elseif (size(nodePath, 1) ~= 3) || (size(nodePath, 2) ~= 3)
    disp('The size of Node Path should be 3 x 3 x N');
    return;
end

% Setup the figure/window for the game
figure('Name', 'Puzzle Solver');
plot(-1. -1)
axis([0 3 0 3])
set(gca, 'xTick', 0:3)
set(gca, 'yTick', 0:3)
set(gca, 'xTickLabel', '')
set(gca, 'yTickLabel', '')
shg
rectangle('Position', [0 0 3 3], 'FaceColor', [153 76 0]/255, 'EdgeColor', 'black', 'LineWidth', 3);
currentNode = nodePath(:, :, 1);
for i = 1:3
    for j = 1:3
        if currentNode(i, j) ~= 0
            rectangle('Position', [j-0.925 3.075-i 0.85 0.85], 'FaceColor', [255 255 204]/255, 'Curvature', 0.2);
            text(j-0.5, 3.5-i, num2str(currentNode(i, j)), 'FontSize', 24);
        end
    end
end

% Start the puzzle solver
pause on
index = [3 2 1];
[currRow, currCol] = find(currentNode == 0);
for n = 2:size(nodePath, 3)
    nextNode = nodePath(:, :, n);
    [nextRow, nextCol] = find(nextNode == 0);
    traverse = double([linspace(3.075-index(nextCol), 3.075-index(currCol)); linspace(index(nextRow)-0.925, index(currRow)-0.925);...
                       linspace(3.5-index(nextCol), 3.5-index(currCol)); linspace(index(nextRow)-0.5, index(currRow)-0.5)]);
    for t = 1:100
        cla
        rectangle('Position', [0 0 3 3], 'FaceColor', [153 76 0]/255, 'EdgeColor', 'black', 'LineWidth', 3);
        for i = 1:3
            for j = 1:3
                if (currentNode(i, j)~=0) && (nextNode(i, j)~=0)
                    rectangle('Position', [j-0.925 3.075-i 0.85 0.85], 'FaceColor', [255 255 204]/255, 'Curvature', 0.2);
                    text(j-0.5, 3.5-i, num2str(currentNode(i, j)), 'FontSize', 24)
                end
            end
        end
        rectangle('Position', [traverse(1, t) traverse(2, t) 0.85 0.85], 'FaceColor', [255 255 204]/255, 'Curvature', 0.2);
        text(traverse(3, t), traverse(4, t), num2str(currentNode(nextRow, nextCol)), 'FontSize', 24)
        pause(0.01);
    end
    currentNode = nextNode;
    currRow = nextRow;
    currCol = nextCol;
end

end
