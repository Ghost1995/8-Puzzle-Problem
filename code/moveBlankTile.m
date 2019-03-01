function [newNode, status] = moveBlankTile(currentNode, direction)
% This function shifts the blank space in the given direction if possible
% and returns the new node generated. If moving in the given direction is
% not possible, then it returns the status as false.

[row, col] = find(currentNode == 0);
if strcmp(direction, 'up') && (row ~= 1)
    newRow = row - 1;
    newCol = col;
elseif strcmp(direction, 'down') && (row ~= 3)
    newRow = row + 1;
    newCol = col;
elseif strcmp(direction, 'left') && (col ~= 1)
    newRow = row;
    newCol = col - 1;
elseif strcmp(direction, 'right') && (col ~= 3)
    newRow = row;
    newCol = col + 1;
else
    newNode = [];
    status = false;
    return;
end
newNode = currentNode;
newNode(row, col) = currentNode(newRow, newCol);
newNode(newRow, newCol) = currentNode(row, col);
status = true;

end
