function [ NodeSet ] = nodesGenerator( varargin )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project 1: Generation of 100,000 nodes by shifting the blank space in a
% 3x3 space and storing the data for later reference.
% 
% Submitted by: Ashwin Goyal
% UID: 115526297
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This function takes as input the goal node, that is, the node that need
% to be reached. By default it is set as [1 2 3; 4 5 6; 7 8 0]. The output
% of the function is NodeSet which contains all 100,000 nodes and their
% information, that is, node #, parent node #, cost to come.

Nodes = [];
NodesInfo = []; % NodeInfo = [ Node #, Parent node #, CostToCome ]

if nargin==1
    Nodes(:,:,1) = varargin{1};
else
    Nodes(:,:,1) = [1 2 3; 4 5 6; 7 8 0];
end
NodesInfo(1,:) = [nodeNumber(Nodes(:,:,1)),0,0];

i = 0;
while size(Nodes,3)<=100000
    i = i+1;
    currentNode = Nodes(:,:,i);
    [newNode, status] = moveLeft(currentNode);
    if (status)&&(~any(NodesInfo(:,1) == nodeNumber(newNode)))
        Nodes(:,:,size(Nodes,3)+1) = newNode;
        NodesInfo(size(Nodes,3),:) = [nodeNumber(newNode), nodeNumber(currentNode), 0];
    end
    [newNode, status] = moveRight(currentNode);
    if (status)&&(~any(NodesInfo(:,1) == nodeNumber(newNode)))
        Nodes(:,:,size(Nodes,3)+1) = newNode;
        NodesInfo(size(Nodes,3),:) = [nodeNumber(newNode), nodeNumber(currentNode), 0];
    end
    [newNode, status] = moveUp(currentNode);
    if (status)&&(~any(NodesInfo(:,1) == nodeNumber(newNode)))
        Nodes(:,:,size(Nodes,3)+1) = newNode;
        NodesInfo(size(Nodes,3),:) = [nodeNumber(newNode), nodeNumber(currentNode), 0];
    end
    [newNode, status] = moveDown(currentNode);
    if (status)&&(~any(NodesInfo(:,1) == nodeNumber(newNode)))
        Nodes(:,:,size(Nodes,3)+1) = newNode;
        NodesInfo(size(Nodes,3),:) = [nodeNumber(newNode), nodeNumber(currentNode), 0];
    end
end

NodeSet.Nodes = Nodes(:,:,1:100000);
NodeSet.NodesInfo = NodesInfo(1:100000,:);

end