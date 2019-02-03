function [ newNode, status ] = moveDown( currentNode )
% This function shifts the blank space downwards if possible and returns 
% the new node generated. If moving downwards is not possible, then it 
% returns the status as false.

blankPos = find(currentNode==0);
if (blankPos~=3)&&(blankPos~=6)&&(blankPos~=9)
    newBlankPos = blankPos+1;
    newNode = currentNode;
    newNode(blankPos) = currentNode(newBlankPos);
    newNode(newBlankPos) = currentNode(blankPos);
    status = true;
else
    newNode = [];
    status = false;
end

end

