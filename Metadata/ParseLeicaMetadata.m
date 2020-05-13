function [ rawMetadata ] = ParseLeicaMetadata( tree, metadataLocation )
%ParseXmlTree locates and extracts a specific value from a xml tree using a 
%specfic node address and attribute name. 
% - Format of metadataLocation is found in parent function ParseMetadata.
%   tree is an .xml that has been opened using xmlread. 
% - This program runs 3 steps: 
%       1) Trimming the tree to contain only the Attribute containing nodes
%          by navigating though the node hierarchy
%       2) Creating a data array to allow for dulicate attribute nodes
%          (e.g. repeat nodes containing different metadata pertaining to 
%          different aquisition channels   
%       3) Extraction of the metadata and conversion into cells of 
%          MATLAB strings or numerics. 

%(1) Go to Node Address 
shrub = tree; 
rootDepth = numel(metadataLocation{1});
currentDepth = 1; 
while currentDepth <= rootDepth
    
    %Find Index of node with name matching the metadata address value
    referenceLocation = metadataLocation{1}{currentDepth}; 
    [nodeIndex] = GetNamedNodeIndecies(shrub, referenceLocation); 
    
    %Enforce that there is only 1 node meeting location critera.  Update shrub
    %for next iteration of loop.      
    if numel(nodeIndex) == 1
        shrub = shrub.item(nodeIndex); 
        currentDepth = currentDepth + 1; 
    elseif isempty(nodeIndex)
        error(['No node was found for metadata location depth: ',num2str(currentDepth),...
                ' for "', referenceName]);
    else
        error(['Inforomation for metadata location depth: ',num2str(currentDepth),...
                ' for "', referenceName ,'" is not specific and '...
                'resulted in multiple Nodes being found valid. Double-check'...
                ' the specificity of this parameter in identifying this Node.']); 
    end
end

%(2) Determine the number of duplicate attribute nodes, create data arrays
[finalNodeIndex] = GetNamedNodeIndecies(shrub, metadataLocation{2});    
numData = numel(finalNodeIndex); 
rawMetadata = cell(numData, 1);
% Enforce existence of final Node
if isempty(numData) 
    warning([ 'The Final node ', metadataLocation{2}...
        'was  not found. Please check spelling and node address.']);
end

%(3) Extract metadata value
for dataNum = 1:numData
    dataElement = shrub.item(finalNodeIndex(dataNum)).getAttributes.getNamedItem(metadataLocation{3});
    
    % Enforce existence of attributte
    if ~isempty(dataElement)     
        rawMetadata{dataNum} = char(dataElement.getNodeValue);
    else
        warning([ 'The attribute ', metadataLocation{3}...
        'was  not found. Please check spelling and node address.'])
    end
end
end






