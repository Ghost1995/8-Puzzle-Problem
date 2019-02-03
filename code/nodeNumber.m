function [ state ] = nodeNumber( node )

% This function converts the node into state, that is, it assigns a unique 
% number to the given node

node = reshape(node',[1,9]);
nodeConverter = [9^0; 9^1; 9^2; 9^3; 9^4; 9^5; 9^6; 9^7; 9^8];
state = node*nodeConverter;

end

