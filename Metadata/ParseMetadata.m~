function [metadata] = ParseMetadata(varargin)
%Function operates on 
parser = inputParser();
  parser.KeepUnmatched = true; % allow extra options
  
  % User or program calling should specify metadata file to parse
  parser.addParameter('fileName', '')  
  
  %List of referenced Metadata Values. 
  % - Each medata entry is a column in the metadataList array. 
  % - Each entry is comprised of 3 elements: Node Address, Attribute Node
  %       Name, and Metadata Item Name. Format:
  %
  %      { Node Address }, Attribute Node, Metadata Item Name; 
  %
  % - The Node address is a cell array containing the names of the nodes above
  %   the node containing attributes to access.
  % - The Attribute Node is the .xml node containing the attributes to be
  %   accessed 
  % - The Metadata Item name is the name of the attribute to be retrieved
  % - At the attribute node a check will be performed for nodes of the same name, if
  %   multiple are present a loop will be performed and data will be 
  %   extracted from each 
  % - If only specific nodes of the same name at the same level is desired, 
  %   specify the Node as a cell containing:
  %
  %      {Node, Attribute, AtrributeValue}
  % - The metadataRoot parameter preceedes the         
  parser.addParameter('metadataRoot', {'Data', 'Image'})
  parser.addParameter('metadataList', { ...
      {'ImageDescription', 'Channels'}, 'ChannelDescription', 'LUTName';...
      {'ImageDescription', 'Channels'}, 'ChannelDescription', 'Resolution';...
      {'ImageDescription', 'Channels'}, 'ChannelDescription', 'OpticalResolutionXY';...
      {'ImageDescription', 'Dimensions'}, 'DimensionDescription', 'DimID';...
      {'ImageDescription', 'Dimensions'}, 'DimensionDescription', 'NumberOfElements';...
      {'ImageDescription', 'FluoDescription'}, 'FluoDescriptionRecord', 'Name';...
      {'ImageDescription', 'FluoDescription'}, 'FluoDescriptionRecord', 'Cube';...
      {'ImageDescription', 'FluoDescription'}, 'FluoDescriptionRecord', 'Excitation';...
      {'ImageDescription', 'FluoDescription'}, 'FluoDescriptionRecord', 'Emission';...
      {{'Attachment', 'Name', 'HardwareSetting'}, 'ATLCameraSettingDefinition', 'WideFieldChannelConfigurator'}, 'WideFieldChannelInfo', 'LUT';...
      {{'Attachment', 'Name', 'HardwareSetting'}, 'ATLCameraSettingDefinition', 'WideFieldChannelConfigurator'}, 'WideFieldChannelInfo', 'FluoCubeName';...
      {{'Attachment', 'Name', 'HardwareSetting'}, 'ATLCameraSettingDefinition', 'WideFieldChannelConfigurator'}, 'WideFieldChannelInfo', 'FluoCubePos';...
      {{'Attachment', 'Name', 'HardwareSetting'}, 'ATLCameraSettingDefinition', 'WideFieldChannelConfigurator'}, 'WideFieldChannelInfo', 'UserDefName';...
      {{'Attachment', 'Name', 'HardwareSetting'}, 'ATLCameraSettingDefinition', 'WideFieldChannelConfigurator'}, 'WideFieldChannelInfo', 'EmissionWavelength';...
      {{'Attachment', 'Name', 'HardwareSetting'}, 'ATLCameraSettingDefinition', 'WideFieldChannelConfigurator'}, 'WideFieldChannelInfo', 'GammaValue';...
      {{'Attachment', 'Name', 'HardwareSetting'}, 'ATLCameraSettingDefinition', 'WideFieldChannelConfigurator'}, 'WideFieldChannelInfo', 'Gain';...
      {{'Attachment', 'Name', 'HardwareSetting'}, 'ATLCameraSettingDefinition', 'WideFieldChannelConfigurator'}, 'WideFieldChannelInfo', 'EMGain';...
      })
  
  parser.addParameter('test', false)
  parser.parse(varargin{:});
  options = parser.Results;
  
  % keep unmatched fields
  unmatchedFields = fieldnames( parser.Unmatched );
  for n = 1:length(unmatchedFields)
    options.(unmatchedFields{n}) = parser.Unmatched.(unmatchedFields{n});
  end
%--------------------------------------------------------------------------

%Get Metadata file if not specified by used
fileName = options.fileName;
if isempty(fileName)
    if options.test
        fileName = '/Users/johnferrante/Desktop/V_lab/12/BMP/Eomes_T_Oct4/MetaData/Project_Image071_Properties.xml'; 
    else
        fileName = uigetdir();
    end
end

%Load File
tree = xmlread(fileName); 

%Combine place metadataRoot into Node Address
numParams = size(options.metadataList, 1); 
for paramNum = 1:numParams
    options.metadataList{paramNum,1} = [options.metadataRoot, options.metadataList{paramNum,1} ]; 
end


%Iterate and retreive each metadata value
rawMetadata = cell(numParams, 1); 
metadataNames = cell(numParams, 2); 

for paramNum = 1:numParams
    %Get Metadata values
    rawMetadata{paramNum} = ParseLeicaMetadata(tree,options.metadataList(paramNum,:));
    
   %Get Lookup values for each final node type 
    attributeNode = options.metadataList{paramNum,2}; 
    switch class(attributeNode)
        case 'cell'
            attributeNodeName = attributeNode{1}; 
        case 'char'
            attributeNodeName = attributeNode; 
        otherwise
            warning('Metadata Location improperly foramtted'); 
    end
    
    %Define which variable will be used to perform channel matching
    switch attributeNodeName
        case 'ChannelDescription'
            matchingAttribute = 'LUTName';
        case 'DimensionDescription'
            matchingAttribute = '';
        case 'FluoDescriptionRecord'
            matchingAttribute = 'Name';
        case 'WideFieldChannelInfo'
            matchingAttribute = 'LUT';
        otherwise
            error( [ '"', attribureNodeName, '" is not a supported metadata'...
                ' category, please define it as a case in the above switch/case']); 
    end  

    metadataNames(paramNum,:) = {attributeNodeName,matchingAttribute};
    
end




foo  = rawMetadata; 

%Locate Attribute Node


%Covert extracted data into struct

end

                 

