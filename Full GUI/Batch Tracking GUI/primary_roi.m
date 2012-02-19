%%==============================================================================%%
%%                  BATCH TRACKING GUI FOR DSI STUDIO: VERSION 2								%%
%%==============================================================================%%

%  
% primary_roi.m
% 
% This GUI is designed for batch tracking in DSI studio. In this verison, the user selects one
% primary ROI, and tracking is performed between the primary ROI and all others selected.
%
%
%   10/27/11: Wrote It. (D. Johnson)
% 
%
%

function varargout = primary_roi(varargin)
% PRIMARY_ROI M-file for primary_roi.fig
%      PRIMARY_ROI, by itself, creates a new PRIMARY_ROI or raises the existing
%      singleton*.
%
%      H = PRIMARY_ROI returns the handle to a new PRIMARY_ROI or the handle to
%      the existing singleton*.
%
%      PRIMARY_ROI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRIMARY_ROI.M with the given input arguments.
%
%      PRIMARY_ROI('Property','Value',...) creates a new PRIMARY_ROI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before primary_roi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to primary_roi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help primary_roi

% Last Modified by GUIDE v2.5 17-Feb-2012 17:51:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @primary_roi_OpeningFcn, ...
                   'gui_OutputFcn',  @primary_roi_OutputFcn, ...
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


% --- Executes just before primary_roi is made visible.
function primary_roi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to primary_roi (see VARARGIN)

% Choose default command line output for primary_roi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes primary_roi wait for user response (see UIRESUME)
% uiwait(handles.figure1);

setappdata(0, 'hMainGui', gcf);
hMainGui = getappdata(0, 'hMainGui');

if exist('./extra_files/dsi_studio_path.mat') == 2;
	load('./extra_files/dsi_studio_path.mat', 'dsi_studio_pointer');
end

roi_pairs = {};
roi2files = {};
roi_outputnames = {};
roi_pairs_names = {};
output_list = {};
original_path = pwd;

setappdata(hMainGui, 'roi_pairs', roi_pairs);
setappdata(hMainGui, 'roi2files', roi2files);
setappdata(hMainGui, 'roi_outputnames', roi_outputnames);
setappdata(hMainGui, 'roi_pairs_names', roi_pairs_names);
setappdata(hMainGui, 'output_list', output_list);
setappdata(hMainGui, 'original_path', original_path);

% --- Outputs from this function are returned to the command line.
function varargout = primary_roi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Get default command line output from handles structure
varargout{1} = handles.output;



% --------------------------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   SPECIFY FILE PATHS   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%==========================================================     DSI STUDIO

% --- Executes on button press in pushbutton_dsi_studio.
function pushbutton_dsi_studio_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dsi_studio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hMainGui = getappdata(0, 'hMainGui');

[dsi_studio, dsi_studio_path] = uigetfile('*.exe','Select DSI Studio'); % Path for DSI Studio
dsi_studio_pointer = sprintf('%s%s',dsi_studio_path,dsi_studio);

setappdata(hMainGui, 'dsi_studio_pointer', dsi_studio_pointer);
set(handles.display_dsi_studio, 'string', dsi_studio);

%%===========================================================     SEED FILE

% --- Executes on button press in pushbutton_seed_file.
function pushbutton_seed_file_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_seed_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hMainGui = getappdata(0, 'hMainGui');

[seed, seedpath] = uigetfile('*.nii','Select the seed file'); % Path for the seed file
seedfile = sprintf('%s%s',seedpath,seed);

setappdata(hMainGui, 'seedfile', seedfile);
set(handles.display_seed_file, 'string', seed);

%%============================================================     FIB FILE

% --- Executes on button press in pushbutton_fib_file.
function pushbutton_fib_file_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_fib_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hMainGui = getappdata(0, 'hMainGui');

[fib, fibpath] = uigetfile('*.fib.gz','Select the .fib file'); % Path for .fib file
fibfile = sprintf('%s%s',fibpath,fib);

setappdata(hMainGui, 'fibfile', fibfile);
set(handles.display_fib_file, 'string', fib);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   TRACKING PARAMETERS   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%===============================================================     SEED COUNT

% --- Executes during object creation, after setting all properties.
function seed_count_input_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%=============================================================     FA THRESHOLD

% --- Executes during object creation, after setting all properties.
function fa_thresh_input_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%================================================================     STEP SIZE

% --- Executes during object creation, after setting all properties.
function step_size_input_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%============================================================     TURNING ANGLE

% --- Executes during object creation, after setting all properties.
function turning_angle_input_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%================================================================     SMOOTHING

% --- Executes during object creation, after setting all properties.
function smoothing_input_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%===================================================================     MIN

% --- Executes during object creation, after setting all properties.
function min_input_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%======================================================================     MAX

% --- Executes during object creation, after setting all properties.
function max_input_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%=============================================================     THREAD COUNT

% --- Executes during object creation, after setting all properties.
function thread_count_input_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%====================================================     OUTPUT FILE DIRECTORY

% --- Executes on button press in pushbutton_outputfile.
function pushbutton_outputfile_Callback(hObject, eventdata, handles)

hMainGui = getappdata(0, 'hMainGui');

prompt = {'Output Directory:'};
output_dir = uigetdir('*.*','Select location for output file'); % Specifies location for output file

setappdata(hMainGui, 'output_dir', output_dir);
set(handles.display_outputdir, 'string', output_dir);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   SPECIFY ROI FILES/PAIRS   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%==============================================================     PRIMARY ROI

% --- Executes on button press in pushbutton_primary_roi.
function pushbutton_primary_roi_Callback(hObject, eventdata, handles)

	hMainGui = getappdata(0, 'hMainGui');
	
	[roifile, roipath] = uigetfile('*.nii','Select primary ROI file');
	% If user clicks cancel after opening dialog box, clear the variables roifile, roipath
	if isequal(roifile, 0);
		clearvars roifile roipath;
	else
		primary_roi = sprintf('%s%s',roipath,roifile);
		primary_roi_filename = roifile;
    [pathstr, primary_roi_outputname, ext] = fileparts(primary_roi);
		% Set variables so they are accessible from other functions
		setappdata(hMainGui, 'primary_roi', primary_roi);
		setappdata(hMainGui, 'primary_roi_filename', primary_roi_filename);
		setappdata(hMainGui, 'primary_roi_outputname', primary_roi_outputname);
		setappdata(hMainGui, 'default_directory', roipath);
		setappdata(hMainGui, 'roipath', roipath);
		set(handles.display_primary_roi, 'string', roifile);	
	end

%%===============================================================     OTHER ROIS

% --- Executes on button press in pushbutton_add_ROI.
function pushbutton_add_ROI_Callback(hObject, eventdata, handles)

	hMainGui               = getappdata(0, 'hMainGui');
	default_directory      = getappdata(hMainGui, 'default_directory');
	roi2files              = getappdata(hMainGui, 'roi2files');

	[selected_files, roi2path] = uigetfile('*.nii','Select second ROI file', default_directory, 'Multiselect', 'on');

	if iscell(selected_files);
		roi2files = cat(1, roi2files, selected_files(:));
	else
		roi2files = cat(1, roi2files, selected_files);
	end

	setappdata(hMainGui, 'roi2files', roi2files);
	set(handles.listbox, 'string', roi2files);

% --- Executes on selection change in listbox.
function listbox_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function listbox_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% ==========================================================     CLEAR ROI FILE

% --- Executes on button press in pushbutton_clear.
function clear_button_Callback(hObject, eventdata, handles)

	hMainGui     = getappdata(0, 'hMainGui');
	roi2files    = getappdata(hMainGui, 'roi2files');
	
	item_selected = get(handles.listbox, 'Value');
	roi2files(item_selected, :) = [];
	
	setappdata(hMainGui, 'roi2files', roi2files);
	set(handles.listbox, 'string', roi2files);
	
%%======================================================     CLEAR ALL ROI FILES

% --- Executes on button press in clear_all_button.
function clear_all_button_Callback(hObject, eventdata, handles)	
	hMainGui  = getappdata(0, 'hMainGui');
	roi2files = getappdata(hMainGui, 'roi2files');

	confirm_clear = questdlg('Are you sure you want to clear all ROI files?', 'Confirm Request to Clear ROI Files', 'Yes');

	if isequal(confirm_clear, 'Yes');
		roi2files = {};
	end

	setappdata(hMainGui, 'roi2files', roi2files);
	set(handles.listbox, 'string', roi2files);
		
% --- Executes on button press in pushbutton_start_tracking.
function pushbutton_start_tracking_Callback(hObject, eventdata, handles)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   GET ALL DATA FROM GUI   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hMainGui               = getappdata(0, 'hMainGui');
dsi_studio_pointer     = getappdata(hMainGui, 'dsi_studio_pointer');
seedfile               = getappdata(hMainGui, 'seedfile');
fibfile                = getappdata(hMainGui, 'fibfile');
seed_count             = str2num(strrep(get(handles.seed_count_input, 'string'), ',', ''));
fa_threshold           = str2num(get(handles.fa_thresh_input, 'string'));
step_size              = str2num(get(handles.step_size_input, 'string'));
smoothing              = str2num(get(handles.smoothing_input, 'string'));
turning_angle          = str2num(get(handles.turning_angle_input, 'string'));
min_length             = str2num(get(handles.min_input, 'string'));
max_length             = str2num(get(handles.max_input, 'string'));
thread_count           = str2num(get(handles.thread_count_input, 'string'));
roi_pairs              = getappdata(hMainGui, 'roi_pairs');
output_list            = getappdata(hMainGui, 'output_list');
output_dir             = getappdata(hMainGui, 'output_dir');
primary_roi            = getappdata(hMainGui, 'primary_roi');
primary_roi_filename   = getappdata(hMainGui, 'primary_roi_filename');
primary_roi_outputname = getappdata(hMainGui, 'primary_roi_outputname');
roi_pairs_names        = getappdata(hMainGui, 'roi_pairs_names');
roipath                = getappdata(hMainGui, 'roipath');
roi_outputnames        = getappdata(hMainGui, 'roi_outputnames');
roi2files              = getappdata(hMainGui, 'roi2files');
roi_pairs              = getappdata(hMainGui, 'roi_pairs');
original_path      = getappdata(hMainGui, 'original_path');

% Check to see if the 'Make Default' checkbox is checked for DSI Studio Path
if (get(handles.checkbox_default_dsi_studio,'Value') == get(handles.checkbox_default_dsi_studio,'Max'));
	% The box is checked, so make a file to store the path. This will be loaded automatically the next time the GUI is used
	filename = 'dsi_studio_path.mat';
	full_filename = sprintf('%s/extra_files/%s', original_path, filename);
	save(full_filename, 'dsi_studio_pointer');
end

% Output file extension
if (get(handles.radiobutton_track,'Value') == get(handles.radiobutton_track,'Max'))
	% Radio button is selected, take appropriate action
	output_extension = '.trk'
else
	% Radio button is not selected, take appropriate action
	output_extension = '.txt'
end

for i = 1:size(roi2files);
	roi2            = sprintf('%s%s',roipath,char(roi2files(i)));
	roi_pairs       = cat(1, roi_pairs, {primary_roi, roi2});
	roi_pairs_names = cat (1, roi_pairs_names, {primary_roi_filename, roi2files(i)});
	[pathstr, roi2_outputname, ext] = fileparts(char(roi2));
	roi_outputnames = cat(1, roi_outputnames, {primary_roi_outputname, roi2_outputname});
	output_filename = sprintf('%s_TO_%s%s',primary_roi_outputname,roi2_outputname,output_extension);
	output          = sprintf('%s\\%s', char(output_dir), char(output_filename));
	output_list     = cat(1, output_list, output);
end

cd(output_dir);

%% Setup Output txt File %%
timedate = datestr(now);
time     = fix(clock);
hour     = num2str(time(4));
minute   = num2str(time(5));
fOut     = strcat('BatchTracking_',date,'-',hour,'-',minute,'_log.txt');
%fOut    = strcat('BatchTracking_','_log.txt')
fid      = fopen(fOut,'a+');
%fid     = fopen(fOut)


if fid == -1
	fprintf(1, 'File Not Opened Properly\n');
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

  	% Send Command to DSI Studio
	  strn = sprintf('!  %s --action=trk --thread_count=%i --source=%s --method=0 --seed=%s --roi=%s --roi2=%s --seed_count=%i --fa_threshold=%i --turning_angle=%i --step_size=%i --smoothing=%i --min_length=%i --max_length=%i --output=%s',dsi_studio_pointer, thread_count, fibfile, seedfile, char(roi_pairs(i)), char(roi_pairs(i, 2)), seed_count, fa_threshold, turning_angle, step_size, smoothing, min_length, max_length, char(output_list(i)));
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

state.seed_count = str2num(get(handles.seed_count_input, 'string'));
state.fa_threshold = str2num(get(handles.fa_thresh_input, 'string'));
state.step_size = str2num(get(handles.step_size_input, 'string'));
state.smoothing = str2num(get(handles.smoothing_input, 'string'));
state.turning_angle = str2num(get(handles.turning_angle_input, 'string'));
state.min_length = str2num(get(handles.min_input, 'string'));
state.max_length = str2num(get(handles.max_input, 'string'));
state.thread_count = str2num(get(handles.thread_count_input, 'string'));

prompt = {'File name:'};
dlg_title = 'Enter name for default values set';
num_lines = 1;
filename = inputdlg(prompt,dlg_title,num_lines);

defaults_filename = sprintf('%s.mat',char(filename));

save (defaults_filename,'state');

% --- Executes on button press in load_button.
function load_button_Callback(hObject, eventdata, handles)

[defaults_file, defaults_filepath] = uigetfile('*.mat','Select file to load saved defaults');
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
