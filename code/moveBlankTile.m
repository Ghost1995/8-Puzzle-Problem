function [status, newNode, newNodeNum] = moveBlankTile(currentNode)
% This function shifts the blank space in all possible directions and
% returns the new node generated. If moving in the given direction is
% not possible, then it returns the status as false.

    movement = [1 0; 0 1; -1 0; 0 -1]; % [up, right, down, left]
    status = false(4,1);
    newNode = zeros(3,3,4);
    newNodeNum = zeros(4,1);
    [row, col] = find(currentNode == 0);
    for i = 1:4
        newPos = [row, col] + movement(i,:);
        status(i) = all(newPos > 0) && all(newPos < 4);
        if status(i)
            newNode(:,:,i) = currentNode;
            newNode(row,col,i) = newNode(newPos(1),newPos(2),i);
            newNode(newPos(1),newPos(2),i) = 0;
            newNodeNum(i) = nodeNumber(newNode(:,:,i));
        end
    end

end
