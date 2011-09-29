% function dsi_studio_track(fibfile,seedfile,roi,roi2,output); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Set Paths for Files   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[dsi_studio, dsi_studio_path] = uigetfile('C:\Users\*.exe','Select DSI Studio'); % Path for DSI Studio
dsi_studio_pointer = sprintf('%s%s',dsi_stuio,dsi_stuido_path);

[fib, fibpath] = uigetfile('C:\Users\*.fib.gz','Select the .fib file'); % Path for .fib file
fibfile = sprintf('%s%s',fib,fibpath);

[seed, seedpath] = uigetfile('C:\Users\*.nii','Select the seed file'); % Path for the seed file
seedfile = sprintf('%s%s',fib,fibpath);

%%======================================================     Paths for ROI Files

% Set paths for first and second ROI files
[roifile, roipath] = uigetfile('C:\Users\*.nii','Select first ROI file'); 
roi = sprintf('%s%s',roipath,roifile);
[roi2file, roi2path] = uigetfile('C:\Users\*.nii','Select second ROI file');
roi2 = sprintf('%s%s',roi2path,roi2file);

roi_pairs = {roi, roi2}; % Create array to store paths for first two ROI files

% Loop for adding more pairs of ROI files
while isequal(questdlg('Would you like to select more ROI pairs?','Select more?'), 'Yes');
	
	[roifile, roipath] = uigetfile('C:\Users\*.nii','Select first ROI file');
	roi = sprintf('%s%s',roipath,roifile);
	[roi2file, roi2path] = uigetfile('C:\Users\*.nii','Select first ROI file');
	roi2 = sprintf('%s%s',roi2path,roi2file);

	roi_pairs = cat(1, roi_pairs, {roi, roi2}); % Concatenate pairs of ROI pahts into roi_pairs cell array
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Output File   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Specifies location for output file
output_dir = uigetdir('C:\Users\*.*','Select location for output file');
extension = questdlg('Select a format for output file','Output File Format','.trk','.txt')
output = sprintf('%soutput%s',output_dir,extension)

if isequal(format_quest, '.trk')
	
else
	
end



% Loop for executing DSI Studio command in command prompt
for i = 1:size(roi_pairs, 1)
	strn = sprintf('! %s --action=trk --source=%s --method=0 --seed=%s --roi=%s --roi2=%s --seed_count=%i --fa_threshold=%i --turning_angle=%i --step_size=%i --smoothing=%i --min_length=%i --max_length=%i --output=%s',dsi_studio_pointer, fibfile, seedfile, char(roi_pairs(i)), char(roi_pairs(i, 2)), seed_count, fa_threshold, turning_angle, step_size, smoothing, min_length, max_length, output)
end

eval(strn);