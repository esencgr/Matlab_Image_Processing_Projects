function varargout = Odev03c_GUI(varargin)
% ODEV03C_GUI MATLAB code for Odev03c_GUI.fig
%      ODEV03C_GUI, by itself, creates a new ODEV03C_GUI or raises the existing
%      singleton*.
%
%      H = ODEV03C_GUI returns the handle to a new ODEV03C_GUI or the handle to
%      the existing singleton*.
%
%      ODEV03C_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ODEV03C_GUI.M with the given input arguments.
%
%      ODEV03C_GUI('Property','Value',...) creates a new ODEV03C_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Odev03c_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Odev03c_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Odev03c_GUI

% Last Modified by GUIDE v2.5 23-Oct-2012 23:45:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Odev03c_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @Odev03c_GUI_OutputFcn, ...
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


% --- Executes just before Odev03c_GUI is made visible.
function Odev03c_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Odev03c_GUI (see VARARGIN)

% Choose default command line output for Odev03c_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes Odev03c_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
warning off


% --- Outputs from this function are returned to the command line.
function varargout = Odev03c_GUI_OutputFcn(hObject, eventdata, handles)
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
imshow(image,'parent',handles.axes01);


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

% --- Executes during object creation, after setting all properties.
function txtMaske_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtMaske (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnDetectEdges.
function btnDetectEdges_Callback(hObject, eventdata, handles)
% hObject    handle to btnDetectEdges (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image maskSize maskeSize maskeDikey maskeYatay maske filename;
image = imread(filename);
set(handles.txtStatus,'String','Ýþlem Uygulanýyor...');
drawnow;
maskSize = 3;
maskeSize = 5;
[m,n] = size(image);
tempImage=zeros(m+maskeSize-1,n+maskeSize-1);
tempImageDikey=zeros(m+maskSize-1,n+maskSize-1);
tempImageYatay=zeros(m+maskSize-1,n+maskSize-1);
% tempImage((maskSize+1)/2:m+(maskSize-1)/2,(maskSize+1)/2:n+(maskSize-1)/2) = image;
lastImage=zeros(m+maskSize-1,n+maskSize-1);

for i=1:m
    for j=1:n
        tempImage(i:i+maskeSize-1,j:j+maskeSize-1) = tempImage(i:i+maskeSize-1,j:j+maskeSize-1) + double(image(i,j))*maske;
    end
end
tempImage = tempImage(1+(maskSize-1)/2:end-(maskSize-1)/2 , 1+(maskSize-1)/2:end-(maskSize-1)/2);

for i=1:m
    for j=1:n
        tempImageYatay(i:i+maskSize-1,j:j+maskSize-1) = tempImageYatay(i:i+maskSize-1,j:j+maskSize-1) + double(tempImage(i,j))*maskeYatay;
    end
end

for i=1:m
    for j=1:n
        tempImageDikey(i:i+maskSize-1,j:j+maskSize-1) = tempImageDikey(i:i+maskSize-1,j:j+maskSize-1) + double(tempImage(i,j))*maskeDikey;
    end
end

lastImage = abs(tempImageYatay) + abs(tempImageDikey);
lastImage = lastImage(1+(maskSize-1)/2:end-(maskSize-1)/2 , 1+(maskSize-1)/2:end-(maskSize-1)/2);
set(handles.axes10,'visible','on');
imshow(lastImage,[0,255],'parent',handles.axes10);
set(handles.txtStatus,'String','Ýþlem Tamamlandý.');

% --- Executes on button press in rbPrewitt.
function rbPrewitt_Callback(hObject, eventdata, handles)
% hObject    handle to rbPrewitt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbPrewitt
global maskeDikey maskeYatay maske;
maske=ones(5,5);
maskeDikey = [-1,0,1;-1,0,1 ;-1,0,1];
maskeYatay = [-1,-1,-1;0,0,0;1,1,1];
set(handles.rbSobel,'Value',0)
set(handles.rbFSobel,'Value',0)
set(handles.rbFPrewitt,'Value',0)


% --- Executes on button press in rbSobel.
function rbSobel_Callback(hObject, eventdata, handles)
% hObject    handle to rbSobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbSobel
global maskeDikey maskeYatay maske;
maske=ones(5,5);
maskeDikey = [-1,-2,-1;0,0,0;1,2,1];
maskeYatay = [-1,0,1;-2,0,2;-1,0,1];
set(handles.rbPrewitt,'Value',0)
set(handles.rbFSobel,'Value',0)
set(handles.rbFPrewitt,'Value',0)


% --- Executes on button press in rbFPrewitt.
function rbFPrewitt_Callback(hObject, eventdata, handles)
% hObject    handle to rbFPrewitt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbFPrewitt
global maskeDikey maskeYatay maske;
maske=ones(5,5)./25;
maskeDikey = [-1,0,1;-1,0,1 ;-1,0,1];
maskeYatay = [-1,-1,-1;0,0,0;1,1,1];
set(handles.rbPrewitt,'Value',0)
set(handles.rbFSobel,'Value',0)
set(handles.rbSobel,'Value',0)


% --- Executes on button press in rbFSobel.
function rbFSobel_Callback(hObject, eventdata, handles)
% hObject    handle to rbFSobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbFSobel
global maskeDikey maskeYatay maske;
maske=ones(5,5)./25;
maskeDikey = [-1,-2,-1;0,0,0;1,2,1];
maskeYatay = [-1,0,1;-2,0,2;-1,0,1];
set(handles.rbPrewitt,'Value',0)
set(handles.rbFPrewitt,'Value',0)
set(handles.rbSobel,'Value',0)
