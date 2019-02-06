function [ newNode, status ] = moveLeft( currentNode )

% This function shifts the blank space towards the left if possible and
% returns the new node generated. If moving towards left is not possible,
% then it returns the status as false.

blankPos = find(currentNode==0);
if (blankPos~=1)&&(blankPos~=2)&&(blankPos~=3)
    newBlankPos = blankPos-3;
    newNode = currentNode;
    newNode(blankPos) = currentNode(newBlankPos);
    newNode(newBlankPos) = currentNode(blankPos);
    status = true;
else
    newNode = [];
    status = false;
end

end

