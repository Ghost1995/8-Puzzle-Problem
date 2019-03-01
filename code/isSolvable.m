function status = isSolvable(initialNode, goalNode)
% This function checks whether the given initial node can reach the given
% goal node or not. If not, the function returns a false status.

% Reshape the matrices into row matrices
initialNode = reshape(initialNode',[1 9]);
goalNode = reshape(goalNode',[1 9]);

% Count the number of inversions
count = 0;
for i = 1:8
    for j = i+1:9
        if all(initialNode([i,j]) ~= 0) && (find(goalNode == initialNode(i)) > find(goalNode == initialNode(j)))
            count = count + 1;
        end
    end
end

% Check if the number of inversions are even or not
if rem(count,2) ~= 0
    status = false;
else
    status = true;
end

end
