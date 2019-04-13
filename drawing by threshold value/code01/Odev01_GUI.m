function varargout = Odev01_GUI(varargin)
% ODEV01_GUI MATLAB code for Odev01_GUI.fig
%      ODEV01_GUI, by itself, creates a new ODEV01_GUI or raises the existing
%      singleton*.
%
%      H = ODEV01_GUI returns the handle to a new ODEV01_GUI or the handle to
%      the existing singleton*.
%
%      ODEV01_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ODEV01_GUI.M with the given input arguments.
%
%      ODEV01_GUI('Property','Value',...) creates a new ODEV01_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Odev01_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Odev01_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Odev01_GUI

% Last Modified by GUIDE v2.5 03-Jun-2013 11:20:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Odev01_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Odev01_GUI_OutputFcn, ...
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


% --- Executes just before Odev01_GUI is made visible.
function Odev01_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Odev01_GUI (see VARARGIN)

% Choose default command line output for Odev01_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes Odev01_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
warning off


% --- Outputs from this function are returned to the command line.
function varargout = Odev01_GUI_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in rbSonuc.
function rbSonuc_Callback(hObject, eventdata, handles)
% hObject    handle to rbSonuc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbSonuc


% --- Executes on button press in btnEkranaYaz.
function btnEkranaYaz_Callback(hObject, eventdata, handles)
% hObject    handle to btnEkranaYaz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image
disp(image);


% --- Executes on button press in btnEsik.
function btnEsik_Callback(hObject, eventdata, handles)
% hObject    handle to btnEsik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on slider movement.
function slEsik_Callback(hObject, eventdata, handles)
% hObject    handle to slEsik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global image filename;
image = imread(filename);
set(handles.txtEsik,'String',['Eþik Deðeri : ' num2str(get(handles.slEsik,'Value'))]);
image(image<=get(handles.slEsik,'Value'))=0;
image(image>get(handles.slEsik,'Value'))=255;
imshow(image);

% --- Executes during object creation, after setting all properties.
function slEsik_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slEsik (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in btnGri.
function btnGri_Callback(hObject, eventdata, handles)
% hObject    handle to btnGri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image filename;
image = imread(filename);
image(image<=50)=50;
image(image>50&image<=100)=100;
image(image>100&image<=150)=150;
image(image>150&image<=200)=200;
image(image>200)=255;
imshow(image);
