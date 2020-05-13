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
  % - At each Node a check will be performed for nodes of the same name, if
  %   multiple are data will be extraced from each 
  % - If only specific nodes of the same name at the same level is desired, 
  %   specify the Node as a cell containing:
  %      {Node, Attribute, AtrributeValue}
  %        
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
      {{'Attachement', 'Name', 'HardwareSetting'}, 'ATLCameraSettingDefinition', 'WideFieldChannelConfigurator'}, 'WideFieldChannelInfo', 'LUT';...
      {{'Attachement', 'Name', 'HardwareSetting'}, 'ATLCameraSettingDefinition', 'WideFieldChannelConfigurator'}, 'WideFieldChannelInfo', 'FluoCubeName';...
      {{'Attachement', 'Name', 'HardwareSetting'}, 'ATLCameraSettingDefinition', 'WideFieldChannelConfigurator'}, 'WideFieldChannelInfo', 'FluoCubePos';...
      {{'Attachement', 'Name', 'HardwareSetting'}, 'ATLCameraSettingDefinition', 'WideFieldChannelConfigurator'}, 'WideFieldChannelInfo', 'UserDefName';...
      {{'Attachement', 'Name', 'HardwareSetting'}, 'ATLCameraSettingDefinition', 'WideFieldChannelConfigurator'}, 'WideFieldChannelInfo', 'EmissionWavelength';...
      {{'Attachement', 'Name', 'HardwareSetting'}, 'ATLCameraSettingDefinition', 'WideFieldChannelConfigurator'}, 'WideFieldChannelInfo', 'GammaValue';...
      {{'Attachement', 'Name', 'HardwareSetting'}, 'ATLCameraSettingDefinition', 'WideFieldChannelConfigurator'}, 'WideFieldChannelInfo', 'Gain';...
      {{'Attachement', 'Name', 'HardwareSetting'}, 'ATLCameraSettingDefinition', 'WideFieldChannelConfigurator'}, 'WideFieldChannelInfo', 'GEMGain';...
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
tree = readxml(filename); 

%Parse xml


%Covert extracted data into struct

end

                 

