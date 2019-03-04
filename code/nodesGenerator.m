function NodeSet = nodesGenerator(initialNode, goalNode)
% This function takes as input the initial node. The output of the
% function is a struct containing all possible nodes from initial node to
% the goal node.

    % Check if all variables were defined
    if nargin == 0
        disp('Initial Node not defined');
        NodeSet = [];
        return;
    elseif nargin == 1
        goalNode = [1 2 3; 4 5 6; 7 8 0];
    end

    % Check if all variables were correctly defined
    if isempty(initialNode)
        disp('Initial Node is empty');
        NodeSet = [];
        return;
    elseif any(size(initialNode) ~= [3 3])
        disp('The size of Initial Node should be 3 x 3');
        NodeSet = [];
        return;
    elseif isempty(goalNode) || any(size(goalNode) ~= [3 3])
        goalNode = [1 2 3; 4 5 6; 7 8 0];
    end

    % Initialize all variables
    Nodes = zeros(3, 3, factorial(9));
    Nodes(:,:,1) = initialNode;
    NodesInfo = zeros(factorial(9), 3); % NodesInfo = [Node #, Parent node #, CostToCome]
    NodesInfo(1,:) = [1 0 0];
    NodesNumList = containers.Map(nodeNumber(initialNode), 1);
    goalNodeNum = nodeNumber(goalNode);

    % Start exploration
    currNodeIndex = 0;
    newNodeIndex = 1;
    oldCost = 0;
    while currNodeIndex < NodesNumList.Count
        currNodeIndex = currNodeIndex + 1;
        c2c = NodesInfo(currNodeIndex,3) + 1;
        if c2c > oldCost
            disp(['Currently at Layer ' num2str(c2c) ' of the Search Tree']);
            oldCost = c2c;
        end
        % Move the blank space
        [status, newNode, newNodeNum] = moveBlankTile(Nodes(:,:,currNodeIndex));
        for i = 1:4
            if status(i) && ~NodesNumList.isKey(newNodeNum(i))
                newNodeIndex = newNodeIndex + 1;
                NodesNumList(newNodeNum(i)) = newNodeIndex;
                Nodes(:,:,newNodeIndex) = newNode(:,:,i);
                NodesInfo(newNodeIndex,:) = [newNodeIndex, currNodeIndex, c2c];
                if newNodeNum(i) == goalNodeNum
                    currNodeIndex = inf;
                    break;
                end
            end
        end
    end

    % Create struct
    if NodesNumList.isKey(goalNodeNum)
        goalNodePos = NodesNumList(goalNodeNum);
        NodeSet.Nodes = Nodes(:,:,1:goalNodePos);
        NodeSet.NodesInfo = NodesInfo(1:goalNodePos,:);
        NodeSet.GoalReached = true;
    else
        NodeSet.Nodes = Nodes(:,:,1:newNodeIndex);
        NodeSet.NodesInfo = NodesInfo(1:newNodeIndex,:);
        NodeSet.GoalReached = false;
    end

end
