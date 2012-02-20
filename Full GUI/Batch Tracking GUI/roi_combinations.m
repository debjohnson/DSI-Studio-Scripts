%%==============================================================================%%
%%                        BATCH TRACKING GUI FOR DSI STUDIO						%%
%%==============================================================================%%

%  
% roi_combinations.m
% 
% This GUI is designed for batch tracking in DSI studio.
% 
%   10/27/11: Wrote It. (D. Johnson)
%   10/27/11: Added text file output. (J. Pyles)
%	10/30/11: Added save/load tracking parameters functions; merged changes from J. Pyles (D. Johnson)
% 

function varargout = roi_combinations(varargin)
% ROI_COMBINATIONS M-file for roi_combinations.fig
%      ROI_COMBINATIONS, by itself, creates a new ROI_COMBINATIONS or raises the existing
%      singleton*.
%
%      H = ROI_COMBINATIONS returns the handle to a new ROI_COMBINATIONS or the handle to
%      the existing singleton*.
%
%      ROI_COMBINATIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROI_COMBINATIONS.M with the given input arguments.
%
%      ROI_COMBINATIONS('Property','Value',...) creates a new ROI_COMBINATIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before roi_combinations_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to roi_combinations_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help roi_combinations

% Last Modified by GUIDE v2.5 19-Feb-2012 20:32:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @roi_combinations_OpeningFcn, ...
                   'gui_OutputFcn',  @roi_combinations_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before roi_combinations is made visible.
function roi_combinations_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% Choose default command line output for roi_combinations
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes roi_combinations wait for user response (see UIRESUME)
% uiwait(handles.figure1);

setappdata(0, 'hMainGui', gcf);
hMainGui = getappdata(0, 'hMainGui');

if exist('extra_files/dsi_studio_path.mat') == 2;
	load('extra_files/dsi_studio_path.mat', 'dsi_studio_pointer');
	setappdata(hMainGui, 'dsi_studio_pointer', dsi_studio_pointer);
	set(handles.display_dsi_studio, 'string', dsi_studio_pointer);
end

roi_pairs       = {};
file_list       = {};
roi_outputnames = {};
roi_pairs_names = {};
output_list     = {};
output_dir      = [];
original_path = pwd;

setappdata(hMainGui, 'roi_pairs', roi_pairs);
setappdata(hMainGui, 'file_list', file_list);
setappdata(hMainGui, 'roi_outputnames', roi_outputnames);
setappdata(hMainGui, 'roi_pairs_names', roi_pairs_names);
setappdata(hMainGui, 'output_list', output_list);
setappdata(hMainGui, 'output_dir', output_dir);
setappdata(hMainGui, 'original_path', original_path);

% --- Outputs from this function are returned to the command line.
function varargout = roi_combinations_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);

% Get default command line output from handles structure
varargout{1} = handles.output;


% ----------------------------------------------------------------------------------

% ===================================================================================== %
% = 		 									 						FILE PATHS																		  =	%
% = 		 		Functions for setting, displaying, and clearing tracking file paths				= %
% ===================================================================================== %

%%==================================================================     DSI STUDIO
% ------ Function executes when dsi_studio_button is pressed. ------ %
% ------ Sets path for DSI studio application. ------ %

function dsi_studio_button_Callback(hObject, eventdata, handles)
	
	% Get any information currently stored in the GUI;
	hMainGui = getappdata(0, 'hMainGui');
		% This line of code is at the beginning of almost every function; 
		% It facilitates storing and retrieving variables to and from the GUI, 
		% and makes it so variables created within the function are accessible from other functions.
	
	% Open file browser window (uigetfile); 
	% Limit selectable files to those that have a .exe extension (*.exe)
	% Set variables [dsi_studio, dsi_studio_path] to the file name and path
	[dsi_studio, dsi_studio_path] = uigetfile('*.exe','Select DSI Studio');
	
	% Concatenate file name and path into one string (for sending to DSI Studio)
	dsi_studio_pointer = sprintf('%s%s',dsi_studio_path,dsi_studio);

	% Store the dsi_studio_pointer variable in the GUI.
	setappdata(hMainGui, 'dsi_studio_pointer', dsi_studio_pointer);
		% Without this line of code, dsi_studio_pointer will not be accessible from other functions
	
	% Display the path in the display_dsi_studio box in the GUI
	set(handles.display_dsi_studio, 'string', dsi_studio);
	
	% --- Executes on button press in checkbox_default_dsi_studio.
	function checkbox_default_dsi_studio_Callback(hObject, eventdata, handles)

%%===========================================================     SEED FILE
% ------ Function executes when seed_file_button is pressed. ------ %
% ------ Sets path for seed file. ------ %
% ------ See dsi_studio_button_Callback function for comments ------ %

function seed_file_button_Callback(hObject, eventdata, handles)

	hMainGui = getappdata(0, 'hMainGui');

	[seed, seedpath] = uigetfile('*.nii','Select the seed file'); % Path for the seed file
	seedfile         = sprintf('%s%s',seedpath,seed);

	setappdata(hMainGui, 'seedfile', seedfile);
	set(handles.display_seed_file, 'string', seed);

%%============================================================     FIB FILE
% ------ Function executes when fib_file_button is pressed. ------ %
% ------ Sets path for fib file. ------ %
% ------ See dsi_studio_button_Callback function for comments ------ %

function fib_file_button_Callback(hObject, eventdata, handles)

	hMainGui = getappdata(0, 'hMainGui');
	
	[fib, fibpath] = uigetfile('*.fib.gz','Select the .fib file'); % Path for .fib file
	fibfile        = sprintf('%s%s',fibpath,fib);

	setappdata(hMainGui, 'fibfile', fibfile);
	set(handles.display_fib_file, 'string', fib);

%%====================================================     OUTPUT FILE DIRECTORY
% ------ Function executes when outputdirectory_button is pressed. ------ %
% ------ Sets path for output file. ------ %

function outputdirectory_button_Callback(hObject, eventdata, handles)

		hMainGui   = getappdata(0, 'hMainGui');
		output_dir = getappdata(hMainGui, 'output_dir');

		prompt     = {'Output Directory:'};
		directory  = uigetdir('*.*','Select location for output file'); % Specifies location for output file
		output_dir = cat(1, output_dir, directory);
		spaces_finder = regexp(directory, '\s');
		
		if isequal(length(spaces_finder), 0);
			output_dir = cat(1, output_dir, directory);
			setappdata(hMainGui, 'output_dir', output_dir);
			set(handles.display_outputdir, 'string', output_dir);
		else
			msgbox('The path to the output directory may not contain spaces. Please select a different path, or modify the directory names in the desired path so they do not contain spaces.', 'Directory Path Cannot Contain Spaces', 'warn');
		end

%%================================================================     ROI FILES
% ------ Function executes when add_ROI_button is pressed. ------ %
% ------ Opens file selector window for user to select pairs of ROI files. ------ %

function add_ROI_button_Callback(hObject, eventdata, handles)

	hMainGui   = getappdata(0, 'hMainGui');
	file_list  = getappdata(hMainGui, 'file_list');
	output_dir = getappdata(hMainGui, 'output_dir');
	
	% If user has set an output directory already, cd to output_dir
	if length(output_dir) > 1;
		cd(output_dir); % added JP
	end
	
	[selected_files, roipath] = uigetfile('*.nii','Select ROI files', 'Multiselect', 'on');
	
	if iscell(selected_files);
		flie_list = cat(1, file_list, selected_files(:));
	else
		file_list = cat(1, file_list, selected_files);
	end

	setappdata(hMainGui, 'roipath', roipath);
	setappdata(hMainGui, 'file_list', file_list);
	set(handles.listbox, 'string', file_list);

% ==========================================================     CLEAR ROI FILE
% ------ Function executes when clear_button is pressed. ------ %

function clear_button_Callback(hObject, eventdata, handles)

	hMainGui     = getappdata(0, 'hMainGui');
 	file_list    = getappdata(hMainGui, 'file_list');
 
	item_selected = get(handles.listbox, 'Value');
	file_list(item_selected, :) = [];
 
	setappdata(hMainGui, 'file_list', file_list);
	set(handles.listbox, 'string', file_list);

%%======================================================     CLEAR ALL ROI FILES
% ------ Function executes when clear_all_button is pressed. ------ %

% --- Executes on button press in clear_all_button.
function clear_all_button_Callback(hObject, eventdata, handles)

 	hMainGui  = getappdata(0, 'hMainGui');
 	file_list = getappdata(hMainGui, 'file_list');
 
 	confirm_clear = questdlg('Are you sure you want to clear all ROI files?', 'Confirm Request to Clear ROI Files', 'Yes');
 
 	if isequal(confirm_clear, 'Yes');
 		file_list = {};
 	end
 
 	setappdata(hMainGui, 'file_list', file_list);
 	set(handles.listbox, 'string', file_list);
		
% ===================================================================================== %
% = 													    TRACKING PARAMETERS								  								=	%
% = 											Functions related to parameters input boxes					  			= %
% ===================================================================================== %

% ------------------------------ GENERATED BY GUIDE ------------------------------- %
%%===============================================================     SEED COUNT
function seed_count_input_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function seed_count_input_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%=============================================================     FA THRESHOLD
function fa_thresh_input_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function fa_thresh_input_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%================================================================     STEP SIZE
function step_size_input_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function step_size_input_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%============================================================     TURNING ANGLE
function turning_angle_input_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function turning_angle_input_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%================================================================     SMOOTHING
function smoothing_input_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function smoothing_input_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%===================================================================     MIN
function min_input_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function min_input_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%======================================================================     MAX
function max_input_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function max_input_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%=============================================================     THREAD COUNT
function thread_count_input_Callback(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
function thread_count_input_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --------------------------------------------------------------------------------- %

% --- Executes on selection change in listbox.
function listbox_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function listbox_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton_start_tracking.
function pushbutton_start_tracking_Callback(hObject, eventdata, handles)

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   GET ALL DATA FROM GUI   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	hMainGui           = getappdata(0, 'hMainGui');
	dsi_studio_pointer = getappdata(hMainGui, 'dsi_studio_pointer');
	seedfile           = getappdata(hMainGui, 'seedfile');
	fibfile            = getappdata(hMainGui, 'fibfile');
	seed_count         = str2num(strrep(get(handles.seed_count_input, 'string'), ',', ''));
	fa_threshold       = str2num(get(handles.fa_thresh_input, 'string'));
	step_size          = str2num(get(handles.step_size_input, 'string'));
	smoothing          = str2num(get(handles.smoothing_input, 'string'));
	turning_angle      = str2num(get(handles.turning_angle_input, 'string'));
	min_length         = str2num(get(handles.min_input, 'string'));
	max_length         = str2num(get(handles.max_input, 'string'));
	thread_count       = str2num(get(handles.thread_count_input, 'string'));
	output_dir         = getappdata(hMainGui, 'output_dir');
	file_list          = getappdata(hMainGui, 'file_list');
	roipath            = getappdata(hMainGui, 'roipath');
	roi_outputnames    = getappdata(hMainGui, 'roi_outputnames');
	output_list        = getappdata(hMainGui, 'output_list');
	original_path      = getappdata(hMainGui, 'original_path');
	
	% Check to see if the 'Make Default' checkbox is checked for DSI Studio Path
	if (get(handles.checkbox_default_dsi_studio,'Value') == get(handles.checkbox_default_dsi_studio,'Max'));
		% The box is checked, so make a file to store the path. This will be loaded automatically the next time the GUI is used
		filename = 'dsi_studio_path.mat';
		full_filename = sprintf('%s/extra_files/%s', original_path, filename);
		save(full_filename, 'dsi_studio_pointer');
	end

	roi_pairs = {}
	
	% Create array with all possible combinations of ROI files
	roi_pairs = nchoosek(file_list, 2);
	
	cd(output_dir);
	
	% Output file extension
	if (get(handles.radiobutton_track,'Value') == get(handles.radiobutton_track,'Max'))
		% Radio button is selected, take appropriate action
		output_extension = '.trk'
	else
		% Radio button is not selected, take appropriate action
		output_extension = '.txt'
	end
	
	for i = 1:size(roi_pairs);
		roi                             = sprintf('%s%s',roipath,char(roi_pairs(i)));
		roi2                            = sprintf('%s%s',roipath,char(roi_pairs(i, 2)));
		roi_pairs                       = cat(1, roi_pairs, {primary_roi, roi2});
		[pathstr, roi_outputname, ext]  = fileparts(char(roi_pairs(i)));
		[pathstr, roi2_outputname, ext] = fileparts(char(roi_pairs(i, 2)));
		roi_outputnames                 = cat(1, roi_outputnames, {roi_outputname, roi2_outputname});
		output_filename                 = sprintf('%s_TO_%s%s',roi_outputname,roi2_outputname,output_extension);
		output                          = sprintf('%s\\%s', char(output_dir), char(output_filename));
		output_list                     = cat(1, output_list, output);
	end

	%% Setup Output txt File %%
	timedate = datestr(now);
	time=fix(clock);
	hour=num2str(time(4));
	minute=num2str(time(5));
	fOut = strcat('BatchTracking_',date,'-',hour,'-',minute,'_log.txt');
	%fOut = strcat('BatchTracking_','_log.txt')
	fid = fopen(fOut,'a+');
	%fid = fopen(fOut)
	
	if fid == -1
		fprintf(1, 'File Not Opened Properly\n');
		%sysbeep;
	end;
	
	fprintf(fid, '%s \n', fOut);
	fprintf(fid, '%s\n', datestr(now));
	fprintf(fid, 'Number of Sets of rois to track: %i \n', size(roi_pairs,1));
	fprintf(fid, 'Fib File: %s \n', fibfile);
	fprintf(fid, 'Seed File: %s \n', seedfile);
	fprintf(fid, 'FA Threshold: %4.4f \n', fa_threshold);
	fprintf(fid, 'Step Size: %4.2f mm \n', step_size);
	fprintf(fid, 'Smoothing: %4.2f mm \n', smoothing);
	fprintf(fid, 'Turning Angle: %i \n', turning_angle);
	fprintf(fid, 'Min Length: %i mm \n', min_length);
	fprintf(fid, 'Max Length: %i mm \n', max_length);
	fprintf(fid, 'Thread Count: %i mm \n', thread_count);
	
	fprintf(fid, '------------------------------------------------------------- \n\n');


	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   START TRACKING   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	starttime=clock;
	
	for i = 1:size(roi_pairs, 1)
		
	    %Record Info
	    disp('*** BATCH FIBER TRACKING ***');
	    fprintf(sprintf('\n\n -- Tracking Set %i of %i -- \n',i,size(roi_pairs,1)));
	    fprintf(fid,'\n\n -- Tracking Set %i of %i -- \n',i,size(roi_pairs,1));
	    fprintf(fid, 'Tracking Pair: %s \n', char(output_list(i)));
	    fprintf(fid, 'Start: %s \n', datestr(now));
	    %fprintf(sprintf('Tracking Pair: %s \n', char(output_list(i))));
	    disp(sprintf('Tracking Pair: %s ', char(output_list(i))))
	    fprintf(sprintf('Start: %s \n', datestr(now)));
	     
		%%==============================================================     OUTPUT FILE
		[pathstr, roi_outputname, ext] = fileparts(char(roi_pairs(i)));
		[pathstr, roi2_outputname, ext] = fileparts(char(roi_pairs(i, 2)));
		output_filename = sprintf('%s_TO_%s%s',roi_outputname,roi2_outputname,output_extension);
		output = sprintf('%s\\%s', output_dir, output_filename);
	   
	    % Send Command to DSI Studio
    strn = sprintf('!  %s --action=trk --thread_count=%i --source=%s --method=0 --seed=%s --roi=%s --roi2=%s --seed_count=%i --fa_threshold=%i --turning_angle=%i --step_size=%i --smoothing=%i --min_length=%i --max_length=%i --output=%s',dsi_studio_pointer, thread_count, fibfile, seedfile, char(roi_pairs(i)), char(roi_pairs(i, 2)), seed_count, fa_threshold, turning_angle, step_size, smoothing, min_length, max_length, output);
    tic;
		eval(strn) % send command to DSI Studio
    tend=toc;
    
    % Record Info
    fprintf(fid, 'Command sent to DSI Studio: %s \n', strn);  
    fprintf(fid, 'End: %s \n', datestr(now));
    fprintf(fid, 'Track time: %d min and %2.4f secs \n\n',floor(tend/60),rem(tend,60));
    fprintf(sprintf('Track time: %d min and %2.4f secs \n',floor(tend/60),rem(tend,60)));
    fprintf(sprintf('\n Tracking Set %i Finished! \n',i));
	end

	endtime=clock;
	totaltime = etime(endtime,starttime);
	
	fprintf(fid, '\n\n ** Completed all at: %s **\n', datestr(now));
	fprintf(fid, '** Total time: %d min and %2.4f secs **\n',floor(totaltime/60),rem(totaltime,60));
	fprintf(sprintf('\n\n ** Completed all at: %s **\n', datestr(now)));
	fprintf(sprintf('** Total time: %d min and %2.4f secs **\n',floor(totaltime/60),rem(totaltime,60)));
	fprintf(sprintf('\n\n ALL FINISHED! \n'));
	fclose(fid);

% --- Executes on button press in save_button.
function save_button_Callback(hObject, eventdata, handles)

	original_path = getappdata(hMainGui, 'original_path');

	state.seed_count    = str2num(get(handles.seed_count_input, 'string'));
	state.fa_threshold  = str2num(get(handles.fa_thresh_input, 'string'));
	state.step_size     = str2num(get(handles.step_size_input, 'string'));
	state.smoothing     = str2num(get(handles.smoothing_input, 'string'));
	state.turning_angle = str2num(get(handles.turning_angle_input, 'string'));
	state.min_length    = str2num(get(handles.min_input, 'string'));
	state.max_length    = str2num(get(handles.max_input, 'string'));
	state.thread_count  = str2num(get(handles.thread_count_input, 'string'));
	
	prompt = {'File name:'};
	dlg_title = 'Enter name for default values set';
	num_lines = 1;
	filename = inputdlg(prompt,dlg_title,num_lines);
	
	default_params_filename = sprintf('%s/extra_files/saved_parameters/%s.mat', original_path, char(filename));
	
	save (default_params_filename,'state');
	
% --- Executes on button press in load_button.
function load_button_Callback(hObject, eventdata, handles)
	
	[defaults_file, defaults_filepath] = uigetfile('extra_files/saved_parameters','Select file to load saved defaults');
	defaults = sprintf('%s%s',defaults_filepath,defaults_file);

	load(defaults);
	
	set(handles.seed_count_input, 'string', state.seed_count);
	set(handles.fa_thresh_input, 'string', state.fa_threshold);
	set(handles.step_size_input, 'string', state.step_size);
	set(handles.smoothing_input, 'string', state.smoothing);
	set(handles.turning_angle_input, 'string', state.turning_angle);
	set(handles.min_input, 'string', state.min_length);
	set(handles.max_input, 'string', state.max_length);
	set(handles.thread_count_input, 'string', state.thread_count);

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)

	delete(hObject);


% --- Executes on button press in outputdirectory_button.
function outputdirectory_button_Callback(hObject, eventdata, handles)
% hObject    handle to outputdirectory_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
