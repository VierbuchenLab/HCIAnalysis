function [nodeInds] = GetXmlSubNodesInds(tree)
% Get the indecies of sub nodes from an xml tree

%   Note: This apache class may not be accurate for all nodes and may be
%   specific to Lecia's metadata .xml. Someone with more .xml
%   experience, please make this more generalizable. This function has only
%   been tested for Lieca Metadata version 1.0 from a model XXXXXX
%   microscope. 

%Get number of children in node
numChildren = tree.getLength;
childInds = 0:numChildren-1; 
indBool = false(numChildren,1);

%Find which chidren are subnodes 
for childNum = 1:numChildren
    indBool(childNum) =  isa( tree.item(childInds(childNum)),...
        'org.apache.xerces.dom.DeferredElementImpl');
end

%Make new index list of subNodes;  
nodeInds = childInds(indBool); 
end
