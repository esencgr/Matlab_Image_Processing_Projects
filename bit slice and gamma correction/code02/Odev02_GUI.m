function varargout = Odev02_GUI(varargin)
% ODEV02_GUI MATLAB code for Odev02_GUI.fig
%      ODEV02_GUI, by itself, creates a new ODEV02_GUI or raises the existing
%      singleton*.
%
%      H = ODEV02_GUI returns the handle to a new ODEV02_GUI or the handle to
%      the existing singleton*.
%
%      ODEV02_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ODEV02_GUI.M with the given input arguments.
%
%      ODEV02_GUI('Property','Value',...) creates a new ODEV02_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Odev02_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Odev02_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Odev02_GUI

% Last Modified by GUIDE v2.5 05-Oct-2012 16:00:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Odev02_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Odev02_GUI_OutputFcn, ...
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


% --- Executes just before Odev02_GUI is made visible.
function Odev02_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Odev02_GUI (see VARARGIN)

% Choose default command line output for Odev02_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes Odev02_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
warning off


% --- Outputs from this function are returned to the command line.
function varargout = Odev02_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnPickImage.
function btnPickImage_Callback(hObject, eventdata, handles)
% hObject    handle to btnPickImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image filename;
filename = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files'},'resim.tif');
image = imread(filename);
set(handles.txtFileName,'String',filename);
imshow(image);


function txtFileName_Callback(hObject, eventdata, handles)
% hObject    handle to txtFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtFileName as text
%        str2double(get(hObject,'String')) returns contents of txtFileName as a double


% --- Executes during object creation, after setting all properties.
function txtFileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function slEsik_Callback(hObject, eventdata, handles)
% hObject    handle to slEsik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.txtEsik,'String',['Bit Deðeri : ' num2str(round(get(handles.slEsik,'Value')))]);
global image;
imgbin=bitget(image,round(get(handles.slEsik,'Value')));
imshow(imgbin,[])

% --- Executes during object creation, after setting all properties.
function slEsik_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slEsik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slGamma_Callback(hObject, eventdata, handles)
% hObject    handle to slGamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.txtGamma,'String',['Gamma Deðeri : ' num2str(get(handles.slGamma,'Value'))]);
global image;
get(handles.slGamma,'Value');
image_=(im2double(image).^(get(handles.slGamma,'Value')));
imshow(image_,[])


% --- Executes during object creation, after setting all properties.
function slGamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slGamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function txtC_Callback(hObject, eventdata, handles)
% hObject    handle to txtC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtC as text
%        str2double(get(hObject,'String')) returns contents of txtC as a double


% --- Executes during object creation, after setting all properties.
function txtC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
