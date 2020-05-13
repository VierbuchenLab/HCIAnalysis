function [nodeNames] = GetSubNodeNames(tree,nodeInds)
% Get all the names of the nodes from items of a specified index  
if isempty(nodeInds)
    [nodeInds] = GetXmlSubNodesInds(tree);
end

numNodes = numel(nodeInds);
nodeNames = cell(numNodes,1);
for nodeNum = 1:numNodes
    nodeNames{nodeNum} = char(tree.item(nodeInds(nodeNum)).getTagName); 
end
end