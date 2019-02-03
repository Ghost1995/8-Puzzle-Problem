function [ newNode, status ] = moveUp( currentNode )

% This function shifts the blank space upwards if possible and returns the 
% new node generated. If moving upwards is not possible, then it returns
% the status as false.

blankPos = find(currentNode==0);
if (blankPos~=1)&&(blankPos~=4)&&(blankPos~=7)
    newBlankPos = blankPos-1;
    newNode = currentNode;
    newNode(blankPos) = currentNode(newBlankPos);
    newNode(newBlankPos) = currentNode(blankPos);
    status = true;
else
    newNode = [];
    status = false;
end

end

