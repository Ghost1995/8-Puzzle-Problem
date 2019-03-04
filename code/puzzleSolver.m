function puzzleSolver(initialNode, goalNode, checkSolvability, visualize, saveVars, saveType)
% This function is the main code which solves the puzzle for the given
% input parameters. It calls all the other functions in the folder.

    % Check if initialNode is correctly defined
    if nargin == 0
        disp('Initial Node not defined. Setting the initial node randomly.');
        initialNode = reshape(randperm(9) - 1, 3, 3);
    elseif isempty(initialNode)
        disp('Initial Node is empty. Setting the initial node randomly.');
        initialNode = reshape(randperm(9) - 1, 3, 3);
    elseif any(size(initialNode) ~= [3 3])
        disp('The size of Initial Node should be 3 x 3. Setting the initial node randomly.');
        initialNode = reshape(randperm(9) - 1, 3, 3);
    end
    
    % Check if goalNode is correctly defined
    if nargin == 1
        disp('Goal Node not defined. Setting it to default.');
        goalNode = [1 2 3; 4 5 6; 7 8 0];
    elseif isempty(goalNode)
        disp('Goal Node is empty. Setting it to default.');
        goalNode = [1 2 3; 4 5 6; 7 8 0];
    elseif any(size(goalNode) ~= [3 3])
        disp('The size of Goal Node should be 3 x 3. Setting it to default.');
        goalNode = [1 2 3; 4 5 6; 7 8 0];
    end
    
    % Check if checkSolvability is correctly defined
    if nargin == 2
        disp('checkSolvability flag not defined. Setting it to false.');
        checkSolvability = false;
    elseif ~islogical(checkSolvability)
        disp('checkSolvability flag is not defined as a logical variable. Setting it to false.');
        checkSolvability = false;
    end
    
    % Check solvability, if asked
    if checkSolvability && ~isSolvable(initialNode, goalNode)
        disp('The given set of initial node and goal node does not have a solution.')
        NodeSet.Nodes = [];
        NodeSet.NodesInfo = [];
        nodePath = [];
    else
        % Generate nodes
        NodeSet = nodesGenerator(initialNode, goalNode);
        if ~NodeSet.GoalReached
            disp('The given set of initial node and goal node does not have a solution.')
            nodePath = [];
        else
            % Generate path from initial node to goal node
            nodePath = reachGoal(NodeSet);
            
            % Check if visualize is correctly defined
            if nargin == 3
                disp('Visualize flag not defined. Setting it to false.');
                visualize = false;
            elseif ~islogical(visualize)
                disp('Visualize flag is not defined as a logical variable. Setting it to false.');
                visualize = false;
            end
            
            % Visualize the path, if asked
            if visualize
                plotPath(nodePath)
            end
        end
    end
    
    % Check if saveVars is correctly defined
    if nargin == 4
        disp('saveVars flag not defined. Setting it to false.');
        saveVars = false;
    elseif ~islogical(saveVars)
        disp('saveVars flag is not defined as a logical variable. Setting it to false.');
        saveVars = false;
    end
    
    % Save the variables, if asked
    if saveVars
        % Check if saveType is correctly defined
        if nargin == 5
            disp('Save Type not defined. Files will be saved as MAT files.');
            saveType = '.mat';
        elseif ~strcmp(saveType, '.mat') && ~strcmp(saveType, '.txt')
            disp('Save Type is invalid. Files will be saved as MAT files.');
            saveType = '.mat';
        end
        
        % Save variables
        if strcmp(saveType, '.mat')
            % Create variables to save
            Nodes = NodeSet.Nodes;
            NodesInfo = NodeSet.NodesInfo;
            
            % Save the variables to MAT files
            save ../output/Nodes.mat Nodes
            save ../output/NodesInfo.mat NodesInfo
            save ../output/nodePath.mat nodePath
        elseif strcmp(saveType, '.txt')
            % Format nodes to be printed in text file
            if ~isempty(NodeSet.Nodes)
                nodes = permute(NodeSet.Nodes, [2 1 3]);
                nodes = reshape(nodes, 9, [])';
            else
                nodes = [];
            end
            
            % Format path to be printed in text file
            if ~isempty(nodePath)
                path = permute(nodePath, [2 1 3]);
                path = reshape(path, 9, [])';
            else
                path = [];
            end
            
            % Write the variables to text files
            if ispc || ismac
                dlmwrite('../output/Nodes.txt', nodes, 'delimiter', '\t', 'newline', 'pc')
                dlmwrite('../output/NodesInfo.txt', NodeSet.NodesInfo, 'delimiter', '\t', 'newline', 'pc')
                dlmwrite('../output/nodePath.txt', path, 'delimiter', '\t', 'newline', 'pc')
            elseif isunix
                dlmwrite('../output/Nodes.txt', nodes, 'delimiter', '\t', 'newline', 'unix')
                dlmwrite('../output/NodesInfo.txt', NodeSet.NodesInfo, 'delimiter', '\t', 'newline', 'unix')
                dlmwrite('../output/nodePath.txt', path, 'delimiter', '\t', 'newline', 'unix')
            end
        end
    end

end
