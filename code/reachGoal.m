function [ nodePath ] = reachGoal( NodeSet, varargin )

% This function reaches the goal node, that is, the first node in the
% NodeSet, from the specified initial node. If no initial node is
% specified, then it uses the last node in the NodeSet as the initial node.

if isempty(NodeSet)
    disp('NodeSet has not been specified.');
    nodePath = [];
    return;
end
if nargin==2
    if ~any(NodeSet.NodesInfo(:,1)==nodeNumber(varargin{1}))
        disp('Initial Node not present in the given NodeSet.');
        nodePath = [];
        return;
    end
    initialNode = varargin{1};
else
    initialNode = NodeSet.Nodes(:,:,size(NodeSet.Nodes,3));
end

i = 1;
nodePath(:,:,i) = initialNode;
parentNode = NodeSet.NodesInfo(NodeSet.NodesInfo(:,1)==nodeNumber(initialNode),2);
while parentNode~=0
    i = i+1;
    parentNodePos = find(NodeSet.NodesInfo(:,1)==parentNode);
    nodePath(:,:,i) = NodeSet.Nodes(:,:,parentNodePos);
    parentNode = NodeSet.NodesInfo(parentNodePos,2);
end

end