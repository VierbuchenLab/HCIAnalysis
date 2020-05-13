function nodeIndex = IdentifyNodeByAttributeValue(shrub, indBool, nodeInds, nodeNameAndAttribute)
%Find xml subnode that has specific attribute value 

validNodeInds = nodeInds(indBool);
validNodeNum = numel(validNodeInds);
attributeList =cell(validNodeNum, 1);
attrName = nodeNameAndAttribute{2}; 
attrVal = nodeNameAndAttribute{3};
for ii = 1:validNodeNum
    try 
        attribute = char( shrub.item(validNodeInds(ii)).getAttribute(attrName) );
    catch
        warning( 'Attribute not found, value coereced to empty'); 
        attribute = ''; 
    end
    attributeList{ii} = attribute; 
end
indBoolNew = cell2mat(arrayfun( @(a) strcmp(a, attrVal), attributeList, 'un', 0));
nodeIndex = validNodeInds(indBoolNew);
end