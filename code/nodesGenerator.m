function NodeSet = nodesGenerator(initialNode, goalNode, checkSolvability, saveVar, saveType)
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
    checkSolvability = false;
    saveVar = false;
elseif nargin == 2
    checkSolvability = false;
    saveVar = false;
elseif nargin == 3 || ~islogical(saveVar)
    saveVar = false;
elseif nargin == 4 || (saveVar && ~strcmp(saveType,'.mat') && ~strcmp(saveType,'.txt'))
    saveType = '.mat';
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

% Check solvability, if asked
if islogical(checkSolvability) && checkSolvability && ~isSolvable(initialNode, goalNode)
    disp('The given set of initial node and goal node does not have a solution')
    NodeSet = [];
    return;
end

% Initialize all variables
Nodes = initialNode;
NodesInfo = [nodeNumber(Nodes(:,:,1)), 0, 0]; % NodesInfo = [Node #, Parent node #, CostToCome]
movement = {'up', 'right', 'down', 'left'};
goalNodeNum = nodeNumber(goalNode);

% Start exploration
index = 0;
oldCost = 0;
goalReached = false;
while ~goalReached && (index < size(Nodes, 3))
    index = index + 1;
    currentNode = Nodes(:, :, index);
    c2c = NodesInfo(index, 3) + 1;
    if c2c > oldCost
        disp(['Currently at Layer ' num2str(c2c) ' of the Search Tree']);
        oldCost = c2c;
    end
    % Move the blank space
    for i = 1:4
        [newNode, status] = moveBlankTile(currentNode, movement{i});
        if status && ~any(NodesInfo(:, 1) == nodeNumber(newNode))
            newNodeNum = nodeNumber(newNode);
            Nodes = cat(3, Nodes, newNode);
            NodesInfo(size(Nodes, 3), :) = [newNodeNum, NodesInfo(index, 1), c2c];
            if newNodeNum == goalNodeNum
                goalReached = true;
                break;
            end
        end
    end
end

% Check if the goal was reached
if ~goalReached
    disp('The given set of initial node and goal node does not have a solution')
end

% Create struct
NodeSet.Nodes = Nodes;
NodeSet.NodesInfo = NodesInfo;

% Save variables, if asked
if saveVar
    if strcmp(saveType,'.mat')
        save ../output/NodeSet.mat NodeSet
    elseif strcmp(saveType,'.txt')
        nodes = permute(NodeSet.Nodes, [2 1 3]);
        nodes = reshape(nodes, 9, [])';
        fileID = fopen('../output/NodesInfo.txt','w');
        if ispc || ismac
            dlmwrite('../output/Nodes.txt', nodes, 'delimiter', '\t', 'newline','pc')
            fprintf(fileID,'%09d\t%09d\t%d\r\n',NodeSet.NodesInfo');
        elseif isunix
            dlmwrite('../output/Nodes.txt', nodes, 'delimiter', '\t', 'newline','unix')
            fprintf(fileID,'%09d\t%09d\t%d\n',NodeSet.NodesInfo');
        end
        fclose(fileID);
    end
end

end
