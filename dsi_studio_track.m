function dsi_studio_track(fibfile,seedfile,roi,roi2,output);

% Set path for DSI Studio
[dsi_studio, dsi_studio_path] = uigetfile('C:\Users\*.exe','Select DSI Studio');
dsi_studio_pointer = sprintf('%s%s',dsi_stuio,dsi_stuido_path);

% Set path for the .fib file
[fib, fibpath] = uigetfile('*.fib.gz','Select the .fib.gz file');
fibfile = sprintf('%s%s',fib,fibpath);

% Set path for the seed file
[seed, seedpath] = uigetfile('*.nii','Select the seed file');
seedfile = sprintf('%s%s',fib,fibpath);

% Set paths for first and second ROI files
[roifile, roipath] = uigetfile('*.nii','Select first ROI file');
roi = sprintf('%s%s',roipath,roifile);
[roi2file, roi2path] = uigetfile('*.nii','Select second ROI file');
roi2 = sprintf('%s%s',roi2path,roi2file);

% Create array to store paths for first and second ROI files
roi_pairs = {roi, roi2};

% Loop for adding pairs of ROI files
while isequal(questdlg('Would you like to select more ROI pairs?','Select more?'), 'Yes');
	
	[roifile, roipath] = uigetfile('*.nii','Select first ROI file');
	roi = sprintf('%s%s',roipath,roifile);
	[roi2file, roi2path] = uigetfile('*.nii','Select first ROI file');
	roi2 = sprintf('%s%s',roi2path,roi2file);
	
	% Concatenate pairs of ROI pahts into roi_pairs cell array
	roi_pairs = cat(1, roi_pairs, {roi, roi2}); 
end


for i = 1:size(roi_pairs, 1)
	strn = sprintf('%s %s', char(roi_pairs(i)), char(roi_pairs(i, 2)))
end

% Specifies output file format and path
output = sprintf('%strack.trk',fibpath)

strn = sprintf('! %s --action=trk --source=%s --method=0 --seed=%s --roi=%s --roi2=%s --seed_count=%i --fa_threshold=%i --turning_angle=%i --step_size=%i --smoothing=%i --min_length=%i --max_length=%i --output=%s', dsi_studio_pointer, fibfile, seedfile, roi, roi2, seed_count, fa_threshold, turning_angle, step_size, smoothing, min_length, max_length, output);
    
eval(strn);
