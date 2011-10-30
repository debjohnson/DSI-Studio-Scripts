%%==============================================================================%%
%%                  BATCH TRACKING GUI FOR DSI STUDIO: VERSION 2				%%
%%==============================================================================%%

%  
% Batch_Tracking.m
% 
% This GUI is designed for batch tracking in DSI studio. In this verison, the user selects one
% primary ROI, and tracking is performed between the primary ROI and all others selected.
%
%
%   10/27/11: Wrote It. (D. Johnson)
% 
%
%

function varargout = Batch_Tracking(varargin)
% BATCH_TRACKING M-file for Batch_Tracking.fig
%      BATCH_TRACKING, by itself, creates a new BATCH_TRACKING or raises the existing
%      singleton*.
%
%      H = BATCH_TRACKING returns the handle to a new BATCH_TRACKING or the handle to
%      the existing singleton*.
%
%      BATCH_TRACKING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BATCH_TRACKING.M with the given input arguments.
%
%      BATCH_TRACKING('Property','Value',...) creates a new BATCH_TRACKING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Batch_Tracking_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Batch_Tracking_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Batch_Tracking

% Last Modified by GUIDE v2.5 29-Oct-2011 15:43:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Batch_Tracking_OpeningFcn, ...
                   'gui_OutputFcn',  @Batch_Tracking_OutputFcn, ...
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


% --- Executes just before Batch_Tracking is made visible.
function Batch_Tracking_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Batch_Tracking (see VARARGIN)

% Choose default command line output for Batch_Tracking
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes Batch_Tracking wait for user response (see UIRESUME)
% uiwait(handles.figure1);

setappdata(0, 'hMainGui', gcf);
% set(handles.seed_count_input, 'string', 113,586,000);
% set(handles.fa_thresh_input, 'string', 0.0241);
% set(handles.step_size_input, 'string', 0.5);
% set(handles.turning_angle_input, 'string', 80);
% set(handles.smoothing_input, 'string', .85);
% set(handles.min_input, 'string', 20);
% set(handles.max_input, 'string', 140);
% set(handles.thread_count_input, 'string', 1);

% --- Outputs from this function are returned to the command line.
function varargout = Batch_Tracking_OutputFcn(hObject, eventdata, handles) 
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

function seed_count_input_Callback(hObject, eventdata, handles)
% hObject    handle to seed_count_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of seed_count_input as text
%        str2double(get(hObject,'String')) returns contents of seed_count_input as a double

hMainGui = getappdata(0, 'hMainGui');
setappdata(hMainGui, 'seed_count', get(hObject, 'string'))

% --- Executes during object creation, after setting all properties.
function seed_count_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seed_count_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%=============================================================     FA THRESHOLD

function fa_thresh_input_Callback(hObject, eventdata, handles)
% hObject    handle to fa_thresh_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fa_thresh_input as text
%        str2double(get(hObject,'String')) returns contents of fa_thresh_input as a double

hMainGui = getappdata(0, 'hMainGui');
setappdata(hMainGui, 'fa_threshold', get(hObject, 'string'))

% --- Executes during object creation, after setting all properties.
function fa_thresh_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fa_thresh_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%================================================================     STEP SIZE

function step_size_input_Callback(hObject, eventdata, handles)
% hObject    handle to step_size_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of step_size_input as text
%        str2double(get(hObject,'String')) returns contents of step_size_input as a double

hMainGui = getappdata(0, 'hMainGui');
setappdata(hMainGui, 'step_size', get(hObject, 'string'))

% --- Executes during object creation, after setting all properties.
function step_size_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step_size_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%============================================================     TURNING ANGLE

function turning_angle_input_Callback(hObject, eventdata, handles)
% hObject    handle to turning_angle_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of turning_angle_input as text
%        str2double(get(hObject,'String')) returns contents of turning_angle_input as a double

hMainGui = getappdata(0, 'hMainGui');
setappdata(hMainGui, 'turning_angle', get(hObject, 'string'))

% --- Executes during object creation, after setting all properties.
function turning_angle_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to turning_angle_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%================================================================     SMOOTHING

function smoothing_input_Callback(hObject, eventdata, handles)
% hObject    handle to smoothing_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of smoothing_input as text
%        str2double(get(hObject,'String')) returns contents of smoothing_input as a double

hMainGui = getappdata(0, 'hMainGui');
setappdata(hMainGui, 'smoothing', get(hObject, 'string'))

% --- Executes during object creation, after setting all properties.
function smoothing_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smoothing_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%===================================================================     MIN

function min_input_Callback(hObject, eventdata, handles)
% hObject    handle to min_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min_input as text
%        str2double(get(hObject,'String')) returns contents of min_input as a double

hMainGui = getappdata(0, 'hMainGui');
setappdata(hMainGui, 'min_length', get(hObject, 'string'))

% --- Executes during object creation, after setting all properties.
function min_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%======================================================================     MAX

function max_input_Callback(hObject, eventdata, handles)
% hObject    handle to max_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_input as text
%        str2double(get(hObject,'String')) returns contents of max_input as a double

hMainGui = getappdata(0, 'hMainGui');
setappdata(hMainGui, 'max_length', get(hObject, 'string'))

% --- Executes during object creation, after setting all properties.
function max_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%=============================================================     THREAD COUNT

function thread_count_input_Callback(hObject, eventdata, handles)
% hObject    handle to thread_count_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thread_count_input as text
%        str2double(get(hObject,'String')) returns contents of thread_count_input as a double

hMainGui = getappdata(0, 'hMainGui');
setappdata(hMainGui, 'thread_count', get(hObject, 'string'))

% --- Executes during object creation, after setting all properties.
function thread_count_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thread_count_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%====================================================     OUTPUT FILE DIRECTORY

% --- Executes on button press in pushbutton_outputfile.
function pushbutton_outputfile_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_outputfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hMainGui = getappdata(0, 'hMainGui');

prompt = {'Output Directory:'};
output_dir = uigetdir('*.*','Select location for output file'); % Specifies location for output file

setappdata(hMainGui, 'output_dir', output_dir);
set(handles.display_outputdir, 'string', output_dir);

function counter_Callback(hObject, eventdata, handles)
% hObject    handle to counter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of counter as text
%        str2double(get(hObject,'String')) returns contents of counter as a
%        double

% --- Executes during object creation, after setting all properties.
function counter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to counter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   SPECIFY ROI FILES/PAIRS   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%==============================================================     PRIMARY ROI

% --- Executes on button press in pushbutton_primary_roi.
function pushbutton_primary_roi_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_primary_roi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hMainGui = getappdata(0, 'hMainGui');

[roifile, roipath] = uigetfile('*.nii','Select primary ROI file'); 
% [roifile, roipath] = uigetfile('/Users/Deb/Desktop/*.nii','Select primary ROI file'); 
primary_roi = sprintf('%s%s',roipath,roifile);
primary_roi_filename = roifile;
[pathstr, primary_roi_outputname, ext] = fileparts(primary_roi);

setappdata(hMainGui, 'primary_roi', primary_roi);
setappdata(hMainGui, 'primary_roi_filename', primary_roi_filename);
setappdata(hMainGui, 'primary_roi_outputname', primary_roi_outputname);
set(handles.display_primary_roi, 'string', roifile);

%%===============================================================     OTHER ROIS

% --- Executes on button press in pushbutton_add_ROI.
function pushbutton_add_ROI_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_add_ROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hMainGui = getappdata(0, 'hMainGui');
output_dir = getappdata(hMainGui, 'output_dir');
primary_roi = getappdata(hMainGui, 'primary_roi');
primary_roi_filename = getappdata(hMainGui, 'primary_roi_filename');
primary_roi_outputname = getappdata(hMainGui, 'primary_roi_outputname');

if ~iscell(get(handles.temp_roi_pairs, 'string'));

	[roi2file, roi2path] = uigetfile('*.nii','Select second ROI file');
	% [roi2file, roi2path] = uigetfile('/Users/Deb/Desktop/*.nii','Select second ROI file');
	roi2 = sprintf('%s%s',roi2path,roi2file);
	
	roi_pairs = {primary_roi, roi2}; % Create array to store paths for first two ROI files
	roi_pairs_names = {primary_roi_filename, roi2file};
	
	%%==============================================     File names for output files
	
	[pathstr, roi2_outputname, ext] = fileparts(roi2);
	roi_outputnames = {primary_roi_outputname, roi2_outputname};
	
	% Output file extension
	if (get(handles.radiobutton_track,'Value') == get(handles.radiobutton_track,'Max'))
		% Radio button is selected, take appropriate action
		output_extension = '.trk'
	else
		% Radio button is not selected, take appropriate action
		output_extension = '.txt'
	end

	output_filename = sprintf('%s_TO_%s%s',primary_roi_outputname,roi2_outputname,output_extension);
	output = sprintf('%s\\%s', output_dir, output_filename);
	output_list = {output};
	
	setappdata(hMainGui, 'roi_pairs', roi_pairs);
	setappdata(hMainGui, 'roi_pairs_names', roi_pairs_names);
    setappdata(hMainGui, 'roi_outputnames', roi_outputnames);
	setappdata(hMainGui, 'output_list', output_list);

    set(handles.temp_roi_pairs, 'string', roi_pairs);
    set(handles.listbox, 'string', sprintf('%s',roi2file));
else
	hMainGui = getappdata(0, 'hMainGui');
	roi_pairs = getappdata(hMainGui, 'roi_pairs');
	roi_pairs_names = getappdata(hMainGui, 'roi_pairs_names');
	roi_outputnames = getappdata(hMainGui, 'roi_outputnames');
	output_list = getappdata(hMainGui, 'output_list');
	
    original_list = get(handles.listbox, 'string');
    
	[roi2file, roi2path] = uigetfile('*.nii','Select first ROI file');
	% [roi2file, roi2path] = uigetfile('/Users/Deb/Desktop/*.nii','Select first ROI file');
	roi2 = sprintf('%s%s',roi2path,roi2file);

	[pathstr, roi2_outputname, ext] = fileparts(roi2);

	% Output file extension
	if (get(handles.radiobutton_track,'Value') == get(handles.radiobutton_track,'Max'))
		% Radio button is selected, take appropriate action
		output_extension = '.trk'
	else
		% Radio button is not selected, take appropriate action
		output_extension = '.txt'
	end

	output_filename = sprintf('%s_TO_%s%s',primary_roi_outputname,roi2_outputname,output_extension);
	output = sprintf('%s\\%s', output_dir, output_filename);

	current_roi_pairs = cat(1, roi_pairs, {primary_roi, roi2});
    current_roi_pairs_names = cat(1, roi_pairs_names, {primary_roi_filename, roi2file});
	current_roi_outputnames = cat(1, roi_outputnames, {primary_roi_outputname, roi2_outputname});
	output_list(end+1) = {output};
    
	setappdata(hMainGui, 'roi_pairs', current_roi_pairs);
	setappdata(hMainGui, 'roi_pairs_names', current_roi_pairs_names);
	setappdata(hMainGui, 'roi_outputnames', current_roi_outputnames);
	setappdata(hMainGui, 'output_list', output_list);
 
    newlist_items = sprintf('%s',roi2file);
    t=[original_list; {newlist_items}]
    set(handles.listbox, 'string', t);
end

% --- Executes on selection change in listbox.
function listbox_Callback(hObject, eventdata, handles)
% hObject    handle to listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox

% --- Executes during object creation, after setting all properties.
function listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% ==========================================================     CLEAR ROI FILES
% 
% % --- Executes on button press in pushbutton_clear.
% function pushbutton_clear_Callback(hObject, eventdata, handles)
% % hObject    handle to pushbutton_clear (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% set(handles.temp_roi_pairs, 'string', '');

% --- Executes on button press in pushbutton_start_tracking.
function pushbutton_start_tracking_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_start_tracking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   GET ALL DATA FROM GUI   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hMainGui = getappdata(0, 'hMainGui');

dsi_studio_pointer = getappdata(hMainGui, 'dsi_studio_pointer');
seedfile = getappdata(hMainGui, 'seedfile');
fibfile = getappdata(hMainGui, 'fibfile');
seed_count = str2num(get(handles.seed_count_input, 'string'));
fa_threshold = str2num(get(handles.fa_thresh_input, 'string'));
step_size = str2num(get(handles.step_size_input, 'string'));
smoothing = str2num(get(handles.smoothing_input, 'string'));
turning_angle = str2num(get(handles.turning_angle_input, 'string'));
min_length = str2num(get(handles.min_input, 'string'));
max_length = str2num(get(handles.max_input, 'string'));
thread_count = str2num(get(handles.thread_count_input, 'string'));
roi_pairs = getappdata(hMainGui, 'roi_pairs');
output_list = getappdata(hMainGui, 'output_list');
output_dir = getappdata(hMainGui, 'output_dir');

cd(output_dir);

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
% hObject    handle to save_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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
% hObject    handle to load_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
