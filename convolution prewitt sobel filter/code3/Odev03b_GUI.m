function varargout = Odev03b_GUI(varargin)
% ODEV03B_GUI MATLAB code for Odev03b_GUI.fig
%      ODEV03B_GUI, by itself, creates a new ODEV03B_GUI or raises the existing
%      singleton*.
%
%      H = ODEV03B_GUI returns the handle to a new ODEV03B_GUI or the handle to
%      the existing singleton*.
%
%      ODEV03B_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ODEV03B_GUI.M with the given input arguments.
%
%      ODEV03B_GUI('Property','Value',...) creates a new ODEV03B_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Odev03b_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Odev03b_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Odev03b_GUI

% Last Modified by GUIDE v2.5 23-Oct-2012 22:57:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Odev03b_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @Odev03b_GUI_OutputFcn, ...
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


% --- Executes just before Odev03b_GUI is made visible.
function Odev03b_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Odev03b_GUI (see VARARGIN)

% Choose default command line output for Odev03b_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes Odev03b_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
warning off


% --- Outputs from this function are returned to the command line.
function varargout = Odev03b_GUI_OutputFcn(hObject, eventdata, handles)
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
[m,n] = size(image);
if(m~=n)
    disp('Resim Kare olmalýdýr')
    return;
end
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


% --- Executes on button press in btnConv.
function btnConv_Callback(hObject, eventdata, handles)
% hObject    handle to btnConv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global maske image maskSize;
maske = cell2mat(get(handles.tblMaske,'data'));
maskSize = length(maske);
[m,n] = size(image);
tempImage=zeros(m+maskSize-1,n+maskSize-1);
tempImage((maskSize+1)/2:m+(maskSize-1)/2,(maskSize+1)/2:n+(maskSize-1)/2) = image;
lastImage=zeros(m+maskSize-1,n+maskSize-1);

for i=1+((maskSize-1)/2):m+((maskSize-1)/2)
    for j=1+((maskSize-1)/2):n+((maskSize-1)/2)
        for k=1:maskSize
            for l=1:maskSize
                lastImage(i,j)=lastImage(i,j)+maske(k,l)*tempImage(i-((maskSize-1)/2)+k-1,j-((maskSize-1)/2)+l-1);
            end
        end
    end
end

lastImage=lastImage(1+((maskSize-1)/2):m+((maskSize-1)/2),1+((maskSize-1)/2):n+((maskSize-1)/2));

set(handles.tblMaske,'visible','off');
set(handles.axes10,'visible','on');
imshow(lastImage,'parent',handles.axes10);

% --- Executes on button press in rb5.
function rb5_Callback(hObject, eventdata, handles)
% hObject    handle to rb5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb5
set(handles.tblMaske,'Data',num2cell(ones(5,5)./25));
set(handles.tblMaske,'ColumnWidth',{40});
set(handles.tblMaske,'ColumnEditable',false(1,5));
set(handles.tblMaske,'visible','on');
set(handles.axes10,'visible','off');
set(handles.rb9,'Value',0)


% --- Executes on button press in rb9.
function rb9_Callback(hObject, eventdata, handles)
% hObject    handle to rb9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb9
set(handles.tblMaske,'Data',num2cell(ones(9,9)./81));
set(handles.tblMaske,'ColumnWidth',{40});
set(handles.tblMaske,'ColumnEditable',false(1,9));
set(handles.tblMaske,'visible','on');
set(handles.axes10,'visible','off');
set(handles.rb5,'Value',0)