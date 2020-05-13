% IccAnalysis_Template
% This script is for explaining the parmaters used to run IccAnalysis

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADD OPTIONS HERE
% Working example:
options.fileDir = '/Users/johnferrante/Desktop/V_lab/24/BMP/Eomes_T_Oct4/'; 



% Execute Analyisis Here
[ data_table ] = IccAnalysis(options);



%%%%%%%%%%%
imageName = 'blue_0hr_fixed_1.tif'; 
metadataLocation = [options.fileDir, 'Metadata/Project_Image022_Properties.xml'];
metadata = parseXml(metadataLocation); 

