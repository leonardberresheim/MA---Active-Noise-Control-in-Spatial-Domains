function varargout = GUI_SSH(varargin)
% GUI_SSH M-file for GUI_SSH.fig
%      GUI_SSH, by itself, creates a new GUI_SSH or raises the existing
%      singleton*.
%
%      H = GUI_SSH returns the handle to a new GUI_SSH or the handle to
%      the existing singleton*.
%
%      GUI_SSH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SSH.M with the given input arguments.
%
%      GUI_SSH('Property','Value',...) creates a new GUI_SSH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_SSH_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_SSH_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_SSH

% Last Modified by GUIDE v2.5 19-Feb-2013 01:01:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GUI_SSH_OpeningFcn, ...
    'gui_OutputFcn',  @GUI_SSH_OutputFcn, ...
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
end

% --- Executes just before GUI_SSH is made visible.
function GUI_SSH_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_SSH (see VARARGIN)

% Choose default command line output for GUI_SSH
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_SSH wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = GUI_SSH_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
end

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
end

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
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=str2double(get(handles.edit1,'string'));
m=str2double(get(handles.edit2,'string'));

if n==0
    warndlg({'The Degree value must be greater than zero!','Please choose a different Degree value!'})
    set(handles.text11,'string','')
    return
end

if m>n
    warndlg({'The Order value must be smaller than or equal to the Degree value!','Please choose a different Order value!'})
    set(handles.text11,'string','')
    return
end

if get(handles.radiobutton5,'value')==1
    type='R';
else
    type='S';
end

if get(handles.radiobutton9,'value')==1
    shape='sphere';
elseif get(handles.radiobutton10,'value')==1
    shape='ellipsoid';
elseif get(handles.radiobutton12,'value')==1
    shape='classic';
elseif get(handles.radiobutton13,'value')==1
    shape='sphere3d';
end

if get(handles.radiobutton7,'value')==1
    sign='yes';
else
    sign='no';
end

cla
Show_SSHarmonic(type,n,m,shape,sign)
rotate3d on
pos=get(handles.text11,'Position');
pos(1,3)=50;
set(handles.text11,'Position',pos)

if m==0
    set(handles.text11,'string','Zonal Spherical Harmonic')
elseif m==n
    set(handles.text11,'string','Sectoral Spherical Harmonic')
else
    set(handles.text11,'string','Tesseral Spherical Harmonic')
end

end

function [ output ] = Show_SSHarmonic(type,n,m,projection,sign_change)
theta=0:0.5:180;
phi=theta-90;
lamda=-180:1:180;
[LAMDA,THETA]=meshgrid(lamda,theta);
[LAMDA,PHI]=meshgrid(lamda,phi);
[max_i, max_j]=size(LAMDA);
DATA=zeros(max_i,max_j);
DATA2=zeros(max_i,max_j);
x=zeros(max_i,max_j);
y=zeros(max_i,max_j);
z=zeros(max_i,max_j);
for i=1:max_i
    for j=1:max_j
        if strcmp(type,'R')==1
            DATA(i,j)=SSHarmonic_R(n,m,THETA(i,j)*pi/180,LAMDA(i,j)*pi/180);
        elseif strcmp(type,'S')==1
            DATA(i,j)=SSHarmonic_S(n,m,THETA(i,j)*pi/180,LAMDA(i,j)*pi/180);
        end
        if DATA(i,j)>0
            DATA2(i,j)=1;
        elseif DATA(i,j)<0
            DATA2(i,j)=-1;
        else
            DATA2(i,j)=0;
        end
    end
end

if nargin==3
    [x y z]=sphere(360);
    surf(x,y,z,DATA);
    axis equal
    shading interp
elseif nargin==4
    if strcmp(projection,'ellipsoid')==1
        [x y z]=ellipsoid(0,0,0,1,1,0.8,360);
        surf(x,y,z,DATA)
        axis equal
        shading interp
        colormap jet
    elseif strcmp(projection,'sphere')==1
        [x y z]=sphere(360);
        surf(x,y,z,DATA);
        axis equal
        shading interp
        colormap jet
    elseif strcmp(projection,'classic')==1
        for i=1:max_i
            for j=1:max_j
                [x(i,j),y(i,j),z(i,j)]=sph2cart(LAMDA(i,j)*pi/180,PHI(i,j)*pi/180,abs(DATA(i,j)));
            end
        end
        surf(x,y,z,DATA)
        axis equal
        shading interp
        colormap jet
    elseif strcmp(projection,'sphere3d')==1
        max_DATA=max(max(DATA));
        for i=1:max_i
            for j=1:max_j
                [x(i,j),y(i,j),z(i,j)]=sph2cart(LAMDA(i,j)*pi/180,PHI(i,j)*pi/180,max_DATA+DATA(i,j));
            end
        end
        surf(x,y,z,DATA)
        axis equal
        shading interp
        colormap jet
    end
elseif nargin==5
    if strcmp(projection,'ellipsoid')==1
        if strcmp(sign_change,'yes')==1
            [x y z]=ellipsoid(0,0,0,1,1,0.8,360);
            surf(x,y,z,DATA2)
            axis equal
            shading flat
            colormap gray
        elseif strcmp(sign_change,'no')==1
            [x y z]=ellipsoid(0,0,0,1,1,0.8,360);
            surf(x,y,z,DATA)
            axis equal
            shading interp
            colormap jet
        end
    elseif strcmp(projection,'sphere')==1
        if strcmp(sign_change,'yes')==1
            [x y z]=sphere(360);
            surf(x,y,z,DATA2);
            axis equal
            shading flat
            colormap gray
        elseif strcmp(sign_change,'no')==1
            [x y z]=sphere(360);
            %figure
            surf(x,y,z,DATA);
            axis equal
            shading interp
            colormap jet
        end
    elseif strcmp(projection,'classic')==1
        if strcmp(sign_change,'yes')==1
            for i=1:max_i
                for j=1:max_j
                    [x(i,j),y(i,j),z(i,j)]=sph2cart(LAMDA(i,j)*pi/180,PHI(i,j)*pi/180,abs(DATA(i,j)));
                end
            end
            surf(x,y,z,DATA2);
            axis equal
            shading flat
            colormap gray
        elseif strcmp(sign_change,'no')==1
            for i=1:max_i
                for j=1:max_j
                    [x(i,j),y(i,j),z(i,j)]=sph2cart(LAMDA(i,j)*pi/180,PHI(i,j)*pi/180,abs(DATA(i,j)));
                end
            end
            surf(x,y,z,DATA);
            axis equal
            shading interp
            colormap jet
        end
    elseif strcmp(projection,'sphere3d')==1
        if strcmp(sign_change,'yes')==1
            max_DATA=max(max(DATA));
            for i=1:max_i
                for j=1:max_j
                    [x(i,j),y(i,j),z(i,j)]=sph2cart(LAMDA(i,j)*pi/180,PHI(i,j)*pi/180,max_DATA+DATA(i,j));
                end
            end
            surf(x,y,z,DATA2);
            axis equal
            shading flat
            colormap gray
        elseif strcmp(sign_change,'no')==1
            max_DATA=max(max(DATA));
            for i=1:max_i
                for j=1:max_j
                    [x(i,j),y(i,j),z(i,j)]=sph2cart(LAMDA(i,j)*pi/180,PHI(i,j)*pi/180,max_DATA+DATA(i,j));
                end
            end
            surf(x,y,z,DATA);
            axis equal
            shading interp
            colormap jet
        end
    end
end
if strcmp(type,'R')==1
    title(strcat('R','(',num2str(n),',',num2str(m),')'),'FontWeight','bold','FontSize',18);
elseif strcmp(type,'S')==1
    title(strcat('S','(',num2str(n),',',num2str(m),')'),'FontWeight','bold','FontSize',18);
end
axis off
%colorbar
if strcmp(type,'R')==1
    output=strcat('Spherical Harmonic: ','R','(',num2str(n),',',num2str(m),') ','computation DONE!');
elseif strcmp(type,'S')==1
    output=strcat('Spherical Harmonic: ','S','(',num2str(n),',',num2str(m),') ','computation DONE!');
end
end

function [ output ] = SSHarmonic_R(n,m,theta,lamda)
output = NLegendre_Fun(n, m, cos(theta)) * cos(m * lamda);
end

function [ output ] = SSHarmonic_S(n,m,theta,lamda)
output = NLegendre_Fun(n, m, cos(theta)) * sin(m * lamda);
end

function [output] = NLegendre_Fun(n,m,t)
output=zeros(n+1,m+1);
output(1,1)=1;
output(2,1)=sqrt(3)*t;
output(2,2)=sqrt(3)*sqrt(1-t^2);

%Recursively compute the elements of the diagonal until degree m
for i=3:m+1
    nn=i-1;
    output(i,i)=sqrt((2*nn+1)/(2*nn))*sqrt(1-t^2)*output(i-1,i-1);
end

%Recursively compute P(m+1,m)
if n>m
    nn=m+1;
    output(m+2,m+1)=sqrt(2*nn+1)*t*output(m+1,m+1);
end

%Recursively compute P(n,m)
if n>m+1
    for i=m+3:n+1
        nn=i-1;
        output(i,m+1)=sqrt(((2*nn-1)*(2*nn+1))/((nn-m)*(nn+m)))*t*output(i-1,m+1) - sqrt(((2*nn+1)*(nn+m-1)*(nn-m-1))/((2*nn-3)*(nn+m)*(nn-m)))*output(i-2,m+1);
    end
end

output=output(n+1,m+1);
end
