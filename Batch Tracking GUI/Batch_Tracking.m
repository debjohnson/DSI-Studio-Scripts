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

% Last Modified by GUIDE v2.5 18-Oct-2011 12:59:56

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

% --- Executes on button press in pushbutton_dsi_studio.
function pushbutton_dsi_studio_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dsi_studio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[dsi_studio, dsi_studio_path] = uigetfile('Users/','Select DSI Studio'); % Path for DSI Studio
dsi_studio_pointer = sprintf('%s%s',dsi_studio_path,dsi_studio);

set(handles.display_dsi_studio, 'string', dsi_studio_pointer);

% --- Executes on button press in pushbutton_seed_file.
function pushbutton_seed_file_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_seed_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[seed, seedpath] = uigetfile('Users/*.nii','Select the seed file'); % Path for the seed file
seedfile = sprintf('%s%s',seedpath,seed);

set(handles.display_seed_file, 'string', seedfile);

% --- Executes on button press in pushbutton_fib_file.
function pushbutton_fib_file_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_fib_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[fib, fibpath] = uigetfile('Users/*.fib.gz','Select the .fib file'); % Path for .fib file
fibfile = sprintf('%s%s',fibpath,fib);

set(handles.display_fib_file, 'string', fibfile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   TRACKING PARAMETERS   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function fa_thresh_input_Callback(hObject, eventdata, handles)
% hObject    handle to fa_thresh_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fa_thresh_input as text
%        str2double(get(hObject,'String')) returns contents of fa_thresh_input as a double

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

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function step_size_input_Callback(hObject, eventdata, handles)
% hObject    handle to step_size_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of step_size_input as text
%        str2double(get(hObject,'String')) returns contents of step_size_input as a double

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

function turning_angle_input_Callback(hObject, eventdata, handles)
% hObject    handle to turning_angle_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of turning_angle_input as text
%        str2double(get(hObject,'String')) returns contents of turning_angle_input as a double

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

function smoothing_input_Callback(hObject, eventdata, handles)
% hObject    handle to smoothing_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of smoothing_input as text
%        str2double(get(hObject,'String')) returns contents of smoothing_input as a double

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

function min_input_Callback(hObject, eventdata, handles)
% hObject    handle to min_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min_input as text
%        str2double(get(hObject,'String')) returns contents of min_input as a double

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

function max_input_Callback(hObject, eventdata, handles)
% hObject    handle to max_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_input as text
%        str2double(get(hObject,'String')) returns contents of max_input as a double

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

function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double

% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

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

% --- Executes on button press in pushbutton_add_ROI.
function pushbutton_add_ROI_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_add_ROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% if isequal(get(handles.counter,'string'),'a');
% 	[roifile, roipath] = uigetfile('Users/*.nii','Select first ROI file'); 
% 	roi = sprintf('%s%s',roipath,roifile);
% 	[roi2file, roi2path] = uigetfile('Users/*.nii','Select second ROI file');
% 	roi2 = sprintf('%s%s',roi2path,roi2file);
% 	
% 	roi_pairs = {roi, roi2}; % Create array to store paths for first two ROI files
% 	set(handles.display_roi_pairs, 'string', roi_pairs);
% 	set(handles.counter, 'string', 'b');
% else
% 	roi_pairs = get(handles.display_roi_pairs, 'string')
% 	[roifile, roipath] = uigetfile('Users/*.nii','Select first ROI file');
% 	roi = sprintf('%s%s',roipath,roifile);
% 	[roi2file, roi2path] = uigetfile('Users/*.nii','Select first ROI file');
% 	roi2 = sprintf('%s%s',roi2path,roi2file);
% 
% 	roi_pairs_new = cat(1, roi_pairs, {roi, roi2}); % Concatenate pairs of ROI pahts into roi_pairs cell array
%     set(handles.display_roi_pairs, 'string', roi_pairs_new);
% end

if ~iscell(get(handles.display_roi_pairs, 'string'));
	[roifile, roipath] = uigetfile('Users/Deb/*.nii','Select first ROI file'); 
	roi = sprintf('%s%s',roipath,roifile);
	[roi2file, roi2path] = uigetfile('Users/Deb/*.nii','Select second ROI file');
	roi2 = sprintf('%s%s',roi2path,roi2file);
	
	roi_pairs = {roi, roi2}; % Create array to store paths for first two ROI files
	set(handles.display_roi_pairs, 'string', roi_pairs);
	set(handles.counter, 'string', 'b');
else
	initial_roi_pairs=(get(handles.display_roi_pairs, 'string'))';
	[roifile, roipath] = uigetfile('Users/Deb/*.nii','Select first ROI file');
	roi = sprintf('%s%s',roipath,roifile);
	[roi2file, roi2path] = uigetfile('Users/Deb/*.nii','Select first ROI file');
	roi2 = sprintf('%s%s',roi2path,roi2file);

	current_roi_pairs = cat(1, initial_roi_pairs, {roi, roi2}); % Concatenate pairs of ROI pahts into roi_pairs cell array
    set(handles.display_roi_pairs, 'string', current_roi_pairs);
end


% --- Executes on button press in pushbutton_clear.
function pushbutton_clear_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.display_roi_pairs, 'string', '')