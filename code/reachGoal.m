function nodePath = reachGoal(NodeSet)
% This function reaches the goal node from the initial node

    % Check if all variables were defined correctly
    if nargin == 0
        disp('NodeSet not defined');
        nodePath = [];
        return;
    elseif ~checkVars(NodeSet)
        nodePath = [];
        return;
    end

    % Initialize all variables
    nodePath = zeros(3, 3, NodeSet.NodesInfo(end,3) + 1);
    nodePath(:,:,end) = NodeSet.Nodes(:,:,end);
    parentNodePos = NodeSet.NodesInfo(end,2);

    % Start developing the path
    for i = size(nodePath,3)-1:-1:1
        nodePath(:,:,i) = NodeSet.Nodes(:,:,parentNodePos);
        parentNodePos = NodeSet.NodesInfo(parentNodePos,2);
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
    elseif isfield(NodeSet, 'GoalReached') && islogical(NodeSet.GoalReached) && ~NodeSet.GoalReached
        disp('NodeSet does not have the goal node');
        status = false;
    else
        status = true;
    end

end
