function [ data_table ] = IccAnalysis( varargin )
%IccAnalysis - Function for the Vierbuchen Lab that analyzes immunohisotchemical
%images.
%   Input Arguments: 
%
%   %Output Arguments: 
%--------------------------------------------------------------------------
parser = inputParser();
  parser.KeepUnmatched = true; % allow extra options
  parser.addParameter('fileDir', '') %Specify 
  parser.addParameter('namingOrder', {'405_LED','GFP','TXR','CY5'}) %Specify channel number to  
  parser.addParameter('nuclearMaskingImage', {'405_LED'} )%1GB limit of
  parser.addParameter('maskingImageNameExcluded', true )% the name of the masking image is not listed
  parser.addParameter('', 10e12 )%1GB limit of
  parser.addParameter('', 10e12 )%1GB limit of
  parser.addParameter('', 10e12 )%1GB limit of
  parser.addParameter('', 10e12 )%1GB limit of
 
  parser.parse(varargin{:});
  options = parser.Results;
  
  % keep unmatched fields
  unmatchedFields = fieldnames( parser.Unmatched );
  for n = 1:length(unmatchedFields)
    options.(unmatchedFields{n}) = parser.Unmatched.(unmatchedFields{n});
  end
%--------------------------------------------------------------------------

if isempty(options.fileDir) && isempty( options.images)
      options.batchDir = uigetdir(); 
end



end

