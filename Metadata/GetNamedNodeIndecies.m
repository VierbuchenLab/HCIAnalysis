function  [nodeIndex, nodeNames, nodeInds, indBool] = GetNamedNodeIndecies(tree, referenceLocation)
%Find a subnode of xml tree that matches reference Location. Format:
%   1) 'nodeName'
%   2) {nodeName, attribueName, attribute value} 

%Get indeces of subnodes 
[nodeInds] = GetXmlSubNodesInds(tree);

%Get names of the subnodes
[nodeNames] = GetSubNodeNames(tree,nodeInds);

%Compare reference name to names of subnodes. Return indecies of matching
%nodes. 
switch class(referenceLocation)
    case 'cell'  %Case for multiplicative Nodes
        referenceName = referenceLocation{1}; 
        indBool = cell2mat(arrayfun( @(a) strcmp(a,referenceName), nodeNames,...
            'un', 0));
        nodeIndex = IdentifyNodeByAttributeValue(tree, indBool, nodeInds,...
            referenceLocation);
    case 'char'   %Case for singular Nodes          
        referenceName = referenceLocation;
        indBool = cell2mat(arrayfun( @(a) strcmp(a,referenceName), nodeNames,...
            'un', 0));
        nodeIndex = nodeInds(indBool); 
    otherwise
        error(['The format of the metadata location depth: ',num2str(currentDepth),...
            ' for "', metadataLocation{end} ,'" is not supported. ',...
            'Check formatting guidlines in "ParseMetadata.m" ']);
end
end