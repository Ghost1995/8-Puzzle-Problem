function state = nodeNumber(node)
% This function converts the node into state, that is, it assigns a unique 
% number to the given node

node = reshape(node', [1, 9]);
nodeConverter = [10^8; 10^7; 10^6; 10^5; 10^4; 10^3; 10^2; 10^1; 10^0];
state = node*nodeConverter;

end
