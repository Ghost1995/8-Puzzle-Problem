function [ newNode, status ] = moveRight( currentNode )

% This function shifts the blank space towards the right if possible and
% returns the new node generated. If moving towards right is not possible,
% then it returns the status as false.

blankPos = find(currentNode==0);
if (blankPos~=7)&&(blankPos~=8)&&(blankPos~=9)
    newBlankPos = blankPos+3;
    newNode = currentNode;
    newNode(blankPos) = currentNode(newBlankPos);
    newNode(newBlankPos) = currentNode(blankPos);
    status = true;
else
    newNode = [];
    status = false;
end

end

