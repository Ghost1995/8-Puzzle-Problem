function nodePath = reachGoal(NodeSet, saveVar, saveType)
% This function reaches the goal node from the initial node

% Check if all variables were defined correctly
if nargin == 0
    disp('NodeSet not defined');
    nodePath = [];
    return;
elseif ~checkVars(NodeSet)
    nodePath = [];
    return;
elseif nargin == 1 || ~islogical(saveVar)
    saveVar = false;
elseif nargin == 2 || (saveVar && ~strcmp(saveType,'.mat') && ~strcmp(saveType,'.txt'))
    saveType = '.mat';
end

% Initialize all variables
nodePath = NodeSet.Nodes(:, :, end);
parentNode = NodeSet.NodesInfo(NodeSet.NodesInfo(:, 1) == nodeNumber(nodePath), 2);

% Start developing the path
while parentNode ~= 0
    parentNodePos = find(NodeSet.NodesInfo(:, 1) == parentNode);
    nodePath = cat(3, nodePath, NodeSet.Nodes(:, :, parentNodePos));
    parentNode = NodeSet.NodesInfo(parentNodePos, 2);
end
nodePath = flip(nodePath, 3);

% Save variables, if asked
if saveVar
    if strcmp(saveType,'.mat')
        save ../output/nodePath.mat nodePath
    elseif strcmp(saveType,'.txt')
        path = permute(nodePath, [2 1 3]);
        path = reshape(path, 9, [])';
        if ispc || ismac
            dlmwrite('../output/nodePath.txt', path, 'delimiter', '\t', 'newline','pc')
        elseif isunix
             dlmwrite('../output/nodePath.txt', path, 'delimiter', '\t', 'newline','unix')
        end
    end
end

end

function status = checkVars(NodeSet)
% This function checks for the validity of the inputs

if isempty(NodeSet)
    disp('NodeSet is empty');
    status = false;
elseif ~isstruct(NodeSet)
    disp('NodeSet is not a structure');
    status = false;
elseif ~isfield(NodeSet, 'Nodes')
    disp('NodeSet does not have Nodes field');
    status = false;
elseif isempty(NodeSet.Nodes)
    disp('Nodes field of NodeSet is empty');
    status = false;
elseif (size(NodeSet.Nodes, 1) ~= 3) || (size(NodeSet.Nodes, 2) ~= 3)
    disp('The size of Nodes field of NodeSet should be 3 x 3 x N');
    status = false;
elseif ~isfield(NodeSet, 'NodesInfo')
    disp('NodeSet does not have NodesInfo field');
    status = false;
elseif isempty(NodeSet.NodesInfo)
    disp('NodesInfo field of NodeSet is empty');
    status = false;
elseif size(NodeSet.NodesInfo, 2) ~= 3
    disp('The size of NodesInfo field of NodeSet should be N x 3');
    status = false;
elseif size(NodeSet.NodesInfo, 1) ~= size(NodeSet.Nodes, 3)
    disp('Nodes field of NodeSet and NodesInfo field of NodeSet are not of the same size');
    status = false;
else
    status = true;
end

end
