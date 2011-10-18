%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This is a script that can be used to automate fiber tracking in DSI Studio.
% In this version of the script, the user selects individual ROI files
% in pairs. After selecting the second file in the pair, the user is
% asked whether they want to select another pair of files.
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Specify Tracking Parameters   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prompt = {'Seed Count:', 'FA Threshold:', 'Step Size:', 'Turning Angle:', 'Smoothing:', 'Minimum Length:','Maximum Length:', 'Thread Count:'};
dlg_title = 'Specify Parameters for Batch Tracking';
def_ans = {'113,586,000','0.0241','0.5','80','0.85','20','140','1'};
num_lines = 1;
params_answers = inputdlg(prompt,dlg_title,num_lines,def_ans);

seed_count = str2num(char(strrep((params_answers(1)), ',', '')));
fa_threshold = str2num(char(params_answers(2)));
step_size = str2num(char(params_answers(3)));
turning_angle = str2num(char(params_answers(4)));
smoothing = str2num(char(params_answers(5)));
min_length = str2num(char(params_answers(6)));
max_length = str2num(char(params_answers(7)));
thread_count = str2num(char(params_answers(8)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Set Paths for Files   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[dsi_studio, dsi_studio_path] = uigetfile('C:\Users\*.exe','Select DSI Studio'); % Path for DSI Studio
dsi_studio_pointer = sprintf('%s%s',dsi_studio_path,dsi_studio);

[fib, fibpath] = uigetfile('C:\Users\*.fib.gz','Select the .fib file'); % Path for .fib file
fibfile = sprintf('%s%s',fibpath,fib);

[seed, seedpath] = uigetfile('C:\Users\*.nii','Select the seed file'); % Path for the seed file
seedfile = sprintf('%s%s',seedpath,seed);

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

output_dir = uigetdir('C:\Users\*.*','Select location for output file'); % Specifies location for output file
extension = questdlg('Select a format for output file','Output File Format','.trk','.txt','.trk'); % Specify output file format
output = sprintf('%s/track%s',output_dir,extension);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   Loop for Executing DSI Studio Command   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:size(roi_pairs, 1)
	strn = sprintf('!  %s --action=trk --source=%s --method=0 --seed=%s --roi=%s --roi2=%s --seed_count=%i --fa_threshold=%i --turning_angle=%i --step_size=%i --smoothing=%i --min_length=%i --max_length=%i --output=%s',dsi_studio_pointer, fibfile, seedfile, char(roi_pairs(i)), char(roi_pairs(i, 2)), seed_count, fa_threshold, turning_angle, step_size, smoothing, min_length, max_length, output)
end

eval(strn);