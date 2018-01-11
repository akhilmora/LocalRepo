function varargout = New_Updated_Tool(varargin)
% NEW_UPDATED_TOOL MATLAB code for New_Updated_Tool.fig
%      NEW_UPDATED_TOOL, by itself, creates a new NEW_UPDATED_TOOL or raises the existing
%      singleton*.
%
%      H = NEW_UPDATED_TOOL returns the handle to a new NEW_UPDATED_TOOL or the handle to
%      the existing singleton*.
%
%      NEW_UPDATED_TOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEW_UPDATED_TOOL.M with the given input arguments.
%
%      NEW_UPDATED_TOOL('Property','Value',...) creates a new NEW_UPDATED_TOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before New_Updated_Tool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to New_Updated_Tool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help New_Updated_Tool

% Last Modified by GUIDE v2.5 21-Sep-2017 05:50:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @New_Updated_Tool_OpeningFcn, ...
                   'gui_OutputFcn',  @New_Updated_Tool_OutputFcn, ...
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


% --- Executes just before New_Updated_Tool is made visible.
function New_Updated_Tool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to New_Updated_Tool (see VARARGIN)

% Choose default command line output for New_Updated_Tool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes New_Updated_Tool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = New_Updated_Tool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
profile on
tic
filenames = uigetfile({'*.txt','Text-files (*.txt)'}, 'Pick a file','MultiSelect','on');
[m n] = size(filenames);
filechars = cell2mat(filenames);
[a b] = size(filechars);
k = b/n;
z = 0;
for i = 1:n
    data{i} = importfile(filechars((i-z+k*(i-1)):b*i/n),6,inf-1);
    z = z+1;
end
%
data = data';
data = cell2mat(data);
[rw cw] = size(data);

% Time vector
rate = 5;
t = 1/rate; 
tot_time = 0:t:rw*t-t;
tot_time = tot_time';

% Final data
finaldata = [tot_time data];
finaldata(any(isnan(finaldata),2),:) = [];

% File generation with correct header
fileID = fopen('ENDyy-xx_complete_test.txt','w');
fprintf(fileID,'%4s\r\n','BEGIN');
fprintf(fileID,'%4s\r\n','CHANNELNAME = [Time,Temp,Pressure Pos3,Pressure Pos1,Pressure Pos5]');
fprintf(fileID,'%4s\r\n','MINIMUM=[0,0,-20,-20,-20]');
fprintf(fileID,'%4s\r\n','MAXIMUM=[1296e3,200,400,400,400]');
fprintf(fileID,'%4s\r\n','UNIT=[sec,°C,kPa,kPa,kPa]');
fprintf(fileID,'%4s\r\n','START=0.0');
fprintf(fileID,'%4s\r\n','RATE=5');
fprintf(fileID,'%4s\r\n','END');
fprintf(fileID,'%4.2f %4.2f  %4.2f  %4.2f  %4.2f\r\n',finaldata'); 
fclose(fileID);
toc
assignin('base','finaldata',finaldata);
handles.finaldata =finaldata;
guidata(hObject, handles);
profile off
profile report


%% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
filenames = uigetfile({'*.txt','Text-files (*.txt)'}, 'Pick a file','MultiSelect','on');
[m n] = size(filenames);
filechars = cell2mat(filenames);
[a b] = size(filechars);
k = b/n;
z = 0;
for i = 1:n
    data{i} = importfile(filechars((i-z+k*(i-1)):b*i/n),7,inf-1);
    z = z+1;
end
data = data';
%´
data = cell2mat(data);
data = data(1:end,3:end);
data(any(isnan(data),2),:) = [];

%
[rw cw] = size(data);
% Time vector
rate = 0.5;
t = 1/rate;
tot_time = 0:t:rw*t-t;
tot_time = tot_time';

% Final data
finaldata = [tot_time data];
finaldata(any(isnan(finaldata),2),:) = [];

% File generation with correct header
fileID = fopen('ENDyy-xx_complete_test.txt','w');
fprintf(fileID,'%4s\r\n','BEGIN');
fprintf(fileID,'%4s\r\n','CHANNELNAME = [Time,Temp in 1,Temp out 1,Temp in 2,Temp out 2,Pressure in 1,Pressure in 2,Flow 1,Flow 2]');
fprintf(fileID,'%4s\r\n','MINIMUM=[0,-20,-20,-20,-20,-20,-20,0,0]');
fprintf(fileID,'%4s\r\n','MAXIMUM=[1296e3,150,150,150,150,400,400,200,200]');
fprintf(fileID,'%4s\r\n','UNIT=[sec,°C,°C,°C,°C,kPa,kPa,l/min,l/min]');
fprintf(fileID,'%4s\r\n','START=0.0');
fprintf(fileID,'%4s\r\n','RATE=0.5');
fprintf(fileID,'%4s\r\n','END');
fprintf(fileID,'%4.2f %4.2f  %4.2f  %4.2f  %4.2f  %4.2f  %4.2f  %4.2f  %4.2f\r\n',finaldata'); 
fclose(fileID);
toc
assignin('base','finaldata',finaldata);
handles.finaldata =finaldata;
guidata(hObject, handles);


%% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
filenames = uigetfile({'*.txt','Text-files (*.txt)'}, 'Pick a file','MultiSelect','on');
[m n] = size(filenames);
filechars = cell2mat(filenames);
[a b] = size(filechars);
k = b/n;
z = 0;
for i = 1:n
    data{i} = importfile3(filechars((i-z+k*(i-1)):b*i/n),6,inf);
    z = z+1;
end
%
data = data';
data = cell2mat(data);
data = data(1:end,3:end);
[rw cw] = size(data);
% Time vector
rate = 5;
t = 1/rate;
tot_time = 0:t:rw*t-t;
tot_time = tot_time';

% Final data
finaldata = [tot_time data];
finaldata(any(isnan(finaldata),2),:) = [];

% File generation with correct header
fileID = fopen('ENDyy-xx_complete_test.txt','w');
fprintf(fileID,'%4s\r\n','BEGIN');
fprintf(fileID,'%4s\r\n','CHANNELNAME = [Time,Temp,Pressure]');
fprintf(fileID,'%4s\r\n','MINIMUM=[0,0,-20]');
fprintf(fileID,'%4s\r\n','MAXIMUM=[1296e3,300,400]');
fprintf(fileID,'%4s\r\n','UNIT=[sec,°C,kPa]');
fprintf(fileID,'%4s\r\n','START=0.0');
fprintf(fileID,'%4s\r\n','RATE=5');
fprintf(fileID,'%4s\r\n','END');
fprintf(fileID,'%4.2f %4.2f  %4.2f\r\n',finaldata'); 
fclose(fileID);
toc
assignin('base','finaldata',finaldata);
handles.finaldata =finaldata;
guidata(hObject, handles);


%% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
filenames = uigetfile({'*.txt','Text-files (*.txt)'}, 'Pick a file','MultiSelect','on');
[m n] = size(filenames);
filechars = cell2mat(filenames);
[a b] = size(filechars);
k = b/n;
z = 0;
for i = 1:n
    data{i} = importfile5(filechars((i-z+k*(i-1)):b*i/n),6,inf-1);
    z = z+1;
end
%
data = data';
data = cell2mat(data);
data = data(:,3:end);
[rw cw] = size(data);
% Time vector
rate = 5;
t = 1/rate;
tot_time = 0:t:rw*t-t;
tot_time = tot_time';

% Final data
finaldata = [tot_time data];
finaldata(any(isnan(finaldata),2),:) = [];

% File generation with correct header
fileID = fopen('ENDyy-xx_complete_test1.txt','w');
fprintf(fileID,'%4s\r\n','BEGIN');
fprintf(fileID,'%4s\r\n','CHANNELNAME = [Time,Temp in 1,Temp out 1,Temp in 2, Temp out 2, Temp in 3, Temp out 3,Pressure in 1,Pressure in 2,Pressure in 3]');
fprintf(fileID,'%4s\r\n','MINIMUM=[0,0,0,0,0,0,0,-20,-20,-20]');
fprintf(fileID,'%4s\r\n','MAXIMUM=[1296e3,300,300,300,300,300,300,400,400,400]');
fprintf(fileID,'%4s\r\n','UNIT=[sec,°C,°C,°C,°C,°C,°C,kPa,kPa,kPa]');
fprintf(fileID,'%4s\r\n','START=0.0');
fprintf(fileID,'%4s\r\n','RATE=5');
fprintf(fileID,'%4s\r\n','END');
fprintf(fileID,'%4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f %4.2f\r\n',finaldata'); 
fclose(fileID);
toc
assignin('base','finaldata',finaldata);
handles.finaldata =finaldata;
guidata(hObject, handles);


%% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
filenames = uigetfile({'*.txt','Text-files (*.txt)'}, 'Pick a file','MultiSelect','on');
[m n] = size(filenames);
filechars = cell2mat(filenames);
[a b] = size(filechars);
k = b/n;
z = 0;
for i = 1:n
    data{i} = importfile6(filechars((i-z+k*(i-1)):b*i/n),6,inf);
    z = z+1;
end
%
data = data';
data = cell2mat(data);
data = data(1:end,3:end);
[rw cw] = size(data);

% Time vector
rate = 0.5;
t = 1/rate;
tot_time = 0:t:rw*t-t;
tot_time = tot_time';

% Final data
finaldata = [tot_time data];
finaldata(any(isnan(finaldata),2),:) = [];

% File generation with correct header
fileID = fopen('ENDyy-xx_complete_test.txt','w');
fprintf(fileID,'%4s\r\n','BEGIN');
fprintf(fileID,'%4s\r\n','CHANNELNAME = [Time,Temp in 1,Temp out 1,Temp in 2,Temp out 2]');
fprintf(fileID,'%4s\r\n','MINIMUM=[0,0,0,0,0]');
fprintf(fileID,'%4s\r\n','MAXIMUM=[1296e3,300,300,300,300]');
fprintf(fileID,'%4s\r\n','UNIT=[sec,°C,°C,°C,°C]');
fprintf(fileID,'%4s\r\n','START=0.0');
fprintf(fileID,'%4s\r\n','RATE=0.5');
fprintf(fileID,'%4s\r\n','END');
fprintf(fileID,'%4.2f  %4.2f  %4.2f  %4.2f  %4.2f\r\n',finaldata'); 
fclose(fileID);
toc
assignin('base','finaldata',finaldata);
handles.finaldata =finaldata;
guidata(hObject, handles);


%% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tic
filenames = uigetfile({'*.txt','Text-files (*.txt)'}, 'Pick a file','MultiSelect','on');
[m n] = size(filenames);
filechars = cell2mat(filenames);
[a b] = size(filechars);
k = b/n;
z = 0;
for i = 1:n
    data{i} = importfile(filechars((i-z+k*(i-1)):b*i/n),6,inf-1);
    z = z+1;
end

data = data';
data = cell2mat(data);
data = data(:,3:end);
[rw cw] = size(data);

% Time vector
rate = 0.5;
t = 1/rate;
tot_time = 0:t:rw*t-t;
tot_time = tot_time';

% Final data
finaldata = [tot_time data];
finaldata(any(isnan(finaldata),2),:) = [];

% File generation with correct header
fileID = fopen('ENDyy-xx_complete_test.txt','w');
fprintf(fileID,'%4s\r\n','BEGIN');
fprintf(fileID,'%4s\r\n','CHANNELNAME = [Time,Temp in 1,Temp out 1,Temp in 2,Temp out 2,Temp in 3,Temp out 3,Temp in 4,Temp out 4,Pressure 1_3,Pressure 2_4]');
fprintf(fileID,'%4s\r\n','MINIMUM=[0,0,0,0,0,0,0,0,0,-20,-20]');
fprintf(fileID,'%4s\r\n','MAXIMUM=[1296e3,300,300,300,300,300,300,300,300,400,400]');
fprintf(fileID,'%4s\r\n','UNIT=[sec,°C,°C,°C,°C,°C,°C,°C,°C,kPa,kPa]');
fprintf(fileID,'%4s\r\n','START=0.0');
fprintf(fileID,'%4s\r\n','RATE=0.5');
fprintf(fileID,'%4s\r\n','END');
fprintf(fileID,'%4.2f %4.2f %4.2f %4.2f  %4.2f  %4.2f  %4.2f  %4.2f  %4.2f  %4.2f  %4.2f\r\n',finaldata'); 
fclose(fileID);
toc
assignin('base','finaldata',finaldata);
handles.finaldata =finaldata;
guidata(hObject, handles);


%% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
profile on
tic
filenames = uigetfile({'*.txt','Text-files (*.txt)'}, 'Pick a file','MultiSelect','on');
[m n] = size(filenames);
filechars = cell2mat(filenames);
[a b] = size(filechars);
k = b/n;
z = 0;
for i = 1:n
    data{i} = importfile(filechars((i-z+k*(i-1)):b*i/n),6,inf-1);
    z = z+1;
end
%
data = data';
data = cell2mat(data);
data= data(:,3:end);
[rw cw] = size(data);

% Time vector
rate = 0.5;
t = 1/rate; 
tot_time = 0:t:rw*t-t;
tot_time = tot_time';

% Final data
finaldata = [tot_time data];
finaldata(any(isnan(finaldata),2),:) = [];

% File generation with correct header
fileID = fopen('ENDyy-xx_complete_test.txt','w');
fprintf(fileID,'%4s\r\n','BEGIN');
fprintf(fileID,'%4s\r\n','CHANNELNAME = [Time,Temp in LV1,Temp out LV1,Temp in LV2,Temp out LV2,Pressure LV1,Pressure LV2,Flow LV1,Flow LV2]');
fprintf(fileID,'%4s\r\n','MINIMUM=[0,-20,-20,-20,-20,-20,-20,0,0]');
fprintf(fileID,'%4s\r\n','MAXIMUM=[1296e3,150,150,150,150,400,400,200,200]');
fprintf(fileID,'%4s\r\n','UNIT=[sec,°C,°C,°C,°C,kPa,kPa,l/min,l/min]');
fprintf(fileID,'%4s\r\n','START=0.0');
fprintf(fileID,'%4s\r\n','RATE=0.5');
fprintf(fileID,'%4s\r\n','END');
fprintf(fileID,'%4.2f %4.2f  %4.2f  %4.2f  %4.2f  %4.2f  %4.2f  %4.2f  %4.2f\r\n',finaldata'); 
fclose(fileID);
toc
assignin('base','finaldata',finaldata);
handles.finaldata =finaldata;
guidata(hObject, handles);
profile off
profile report

%% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t1 = plot(handles.finaldata(:,1),handles.finaldata(:,2));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t1,'Ch1','jpg');

%% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t2 = plot(handles.finaldata(:,1),handles.finaldata(:,3));
xlabel('Time [sec]','fontsize',12);
ylabel('Pressure Pos3 [kPa]','fontsize',12);
title('Time history','fontsize',14);
saveas(t2,'Ch2','jpg');

%% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t3 = plot(handles.finaldata(:,1),handles.finaldata(:,4));
xlabel('Time [sec]','fontsize',12);
ylabel('Pressure Pos1 [kPa]','fontsize',12);
title('Time history','fontsize',14);
saveas(t3,'Ch3','jpg');

%% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t4 = plot(handles.finaldata(:,1),handles.finaldata(:,5));
xlabel('Time [sec]','fontsize',12);
ylabel('Pressure Pos5 [kPa]','fontsize',12);
title('Time history','fontsize',14)
saveas(t4,'Ch4','jpg');


%% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,2);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
sg = sg';
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',760);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',790);
id = [pks vls];
sid = sort(id);
tps = sg(sid);
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end
lln=sort(ll,'descend');
lln1=lln-0.0001;
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end
ss=ss(:,2:3);
ss=sort(ss,2);
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end
A=ud(3,:);
B=ud(4,:);
f1 = plot(B,A,'LineWidth',2);
grid on;
xlabel('Number of cycles');
ylabel('Temperature');
title('Level Crossing Curve');
saveas(f1,'Ch1','jpg');

%% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,3);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
sg = sg';
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',4);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',4);
id = [pks vls];
sid = sort(id);
tps = sg(sid);
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end
lln=sort(ll,'descend');
lln1=lln-0.0001;
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end
ss=ss(:,2:3);
ss=sort(ss,2);
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end
A=ud(3,:);
B=ud(4,:);
f2 = plot(B,A,'LineWidth',2);
grid on;
xlabel('Number of cycles');
ylabel('Pressure Pos 3');
title('Level Crossing Curve');
saveas(f2,'Ch2','jpg');


%% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,4);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
sg = sg';
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',4.2);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',4.2);
id = [pks vls];
sid = sort(id);
tps = sg(sid);
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end
lln=sort(ll,'descend');
lln1=lln-0.0001;
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end
ss=ss(:,2:3);
ss=sort(ss,2);
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end
A=ud(3,:);
B=ud(4,:);
f3 = plot(B,A,'LineWidth',2);
grid on;
xlabel('Number of cycles');
ylabel('Pressure Pos 1');
title('Level Crossing Curve');
saveas(f3,'Ch3','jpg');

%% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,5);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
sg = sg';
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',4);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',4);
id = [pks vls];
sid = sort(id);
tps = sg(sid);
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end
lln=sort(ll,'descend');
lln1=lln-0.0001; 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end
ss=ss(:,2:3);
ss=sort(ss,2);
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end
A=ud(3,:);
B=ud(4,:);
f4 = plot(B,A,'LineWidth',2);
grid on;
xlabel('Number of cycles');
ylabel('Pressure Pos 5');
title('Level Crossing Curve');
saveas(f4,'Ch4','jpg');


%% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t1 = plot(handles.finaldata(:,1),handles.finaldata(:,2));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp in 1 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t1,'Ch1','jpg');


%% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t2 = plot(handles.finaldata(:,1),handles.finaldata(:,3));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp out 1 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t2,'Ch2','jpg');

%% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t3 = plot(handles.finaldata(:,1),handles.finaldata(:,4));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp in 2 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t3,'Ch3','jpg');

%% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t4 = plot(handles.finaldata(:,1),handles.finaldata(:,5));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp out 2 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t4,'Ch4','jpg');

%% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,2);
sg = sg';
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',200);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',220);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

%%
f1 = plot(B,A,'LineWidth',2)
xlabel('Number of cycles');
ylabel('Temp in 1');
title('Level Crossing Curve');
saveas(f1,'LCC_Ch1','jpg');

%% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,3);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',230);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',230);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
tps = tps(3:end);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

%%
f2 = plot(B,A,'LineWidth',2)
xlabel('Number of cycles');
ylabel('Temp out 1');
title('Level Crossing Curve');
saveas(f2,'LCC_Ch2','jpg');

% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,4);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
sg = sg';
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',230);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',235);
id = [pks vls];
sid = sort(id);
tps = sg(sid);
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end
lln=sort(ll,'descend');
lln1=lln-0.0001;
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end
ss=ss(:,2:3);
ss=sort(ss,2);
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end
A=ud(3,:);
B=ud(4,:);
f3 = plot(B,A,'LineWidth',2)
xlabel('Number of cycles');
ylabel('Temp in 2');
title('Level Crossing Curve');
saveas(f3,'LCC_Ch3','jpg');

%% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,7);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',242);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',225);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);


f6 = plot(B,A,'LineWidth',2)
xlabel('Number of cycles');
ylabel('Pressure in 2');
title('Level Crossing Curve');
saveas(f6,'LCC_Ch6','jpg')

%% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t5 = plot(handles.finaldata(:,1),handles.finaldata(:,6));
xlabel('Time [sec]','fontsize',12);
ylabel('Pressure in 1 [kPa]','fontsize',12);
title('Time history','fontsize',14);
saveas(t5,'Ch5','jpg');

%% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t6 =  plot(handles.finaldata(:,1),handles.finaldata(:,7));
xlabel('Time [sec]','fontsize',12);
ylabel('Pressure in 2 [kPa]','fontsize',12);
title('Time history','fontsize',14);
saveas(t6,'Ch6','jpg');


%% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t7 = plot(handles.finaldata(:,1),handles.finaldata(:,8));
xlabel('Time [sec]','fontsize',12);
ylabel('Flow in 1 [l/min]','fontsize',12);
title('Time history','fontsize',14);
saveas(t7,'Ch7','jpg');

%% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t8 = plot(handles.finaldata(:,1),handles.finaldata(:,9));
xlabel('Time [sec]','fontsize',12);
ylabel('Flow in 2 [l/min]','fontsize',12);
title('Time history','fontsize',14);
saveas(t8,'Ch8','jpg');


%% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,6);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',250);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',245);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f5 = plot(B,A,'LineWidth',2)
xlabel('Number of cycles');
ylabel('Pressure in 1');
title('Level Crossing Curve');
saveas(f5,'LCC_Ch5','jpg')

% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,8);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',240);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',240);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f7 = plot(B,A,'LineWidth',2)
xlabel('Number of cycles');
ylabel('Flow 1');
title('Level Crossing Curve');
saveas(f7,'LCC_Ch7','jpg')

%% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,9);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',200);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',240);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);
tps = tps(2:end);
tps = tps(3:end);
%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

%%
f8 = plot(B,A,'LineWidth',2)
xlabel('Number of cycles');
ylabel('Flow 2');
title('Level Crossing Curve');
saveas(f8,'LCC_Ch8','jpg')

%% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t2 = plot(handles.finaldata(:,1),handles.finaldata(:,3));
xlabel('Time [sec]','fontsize',12);
ylabel('Pressure [kPa]','fontsize',12);
title('Time history','fontsize',14);
saveas(t2,'Ch2','jpg');

%% --- Executes on button press in pushbutton35.
function pushbutton35_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,2);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;


%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',650);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',690);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f1 = plot(B,A,'LineWidth',2)
xlabel('Number of cycles');
ylabel('Temperature');
title('Level Crossing Curve');
saveas(f1,'LCC_Ch1','jpg')

%% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,3);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',4.8);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',4.8);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f2 = plot(B,A,'LineWidth',2)
xlabel('Number of cycles');
ylabel('Pressure');
title('Level Crossing Curve');
saveas(f2,'LCC_Ch2','jpg')

%% --- Executes on button press in pushbutton43.
function pushbutton43_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t3 = plot(handles.finaldata(:,1),handles.finaldata(:,4));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp in 3 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t3,'Ch3','jpg')

%% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t1 = plot(handles.finaldata(:,1),handles.finaldata(:,2));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t1,'Ch1','jpg');

%% --- Executes on button press in pushbutton45.
function pushbutton45_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t5 = plot(handles.finaldata(:,1),handles.finaldata(:,6));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp in 3 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t5,'Ch5','jpg');

%% --- Executes on button press in pushbutton38.
function pushbutton38_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%% --- Executes on button press in pushbutton47.
function pushbutton47_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t7 = plot(handles.finaldata(:,1),handles.finaldata(:,8));
xlabel('Time [sec]','fontsize',12);
ylabel('Pressure in 2 [kPa]','fontsize',12);
title('Time history','fontsize',14);
saveas(t7,'Ch7','jpg');


%% --- Executes on button press in pushbutton37.
function pushbutton37_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%% --- Executes on button press in pushbutton49.
function pushbutton49_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton49 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t9 = plot(handles.finaldata(:,1),handles.finaldata(:,10));
xlabel('Time [sec]','fontsize',12);
ylabel('Pressure in 3 [kPa]','fontsize',12);
title('Time history','fontsize',14);
saveas(t9,'Ch9','jpg');

%% --- Executes on button press in pushbutton40.
function pushbutton40_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%% --- Executes on button press in pushbutton51.
function pushbutton51_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,3);

msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',4.4);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',4.4);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f2 = plot(B,A,'LineWidth',2);
xlabel('Number of cycles');
ylabel('Temp out 1');
title('Level Crossing Curve');
saveas(f2,'LCC_Ch2','jpg')


%% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t1 = plot(handles.finaldata(:,1),handles.finaldata(:,2));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp in 1 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t1,'Ch1','jpg');

%% --- Executes on button press in pushbutton42.
function pushbutton42_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t2 = plot(handles.finaldata(:,1),handles.finaldata(:,3));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp out 1 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t2,'Ch2','jpg');

%% --- Executes on button press in pushbutton44.
function pushbutton44_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t4 = plot(handles.finaldata(:,1),handles.finaldata(:,5));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp out 2 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t4,'Ch4','jpg');

%% --- Executes on button press in pushbutton46.
function pushbutton46_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t6 = plot(handles.finaldata(:,1),handles.finaldata(:,7));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp out 3 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t6,'Ch6','jpg');

%% --- Executes on button press in pushbutton48.
function pushbutton48_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t8 = plot(handles.finaldata(:,1),handles.finaldata(:,9));
xlabel('Time [sec]','fontsize',12);
ylabel('Pressure in 2 [kPa]','fontsize',12);
title('Time history','fontsize',14);
saveas(t8,'Ch8','jpg');

%% --- Executes on button press in pushbutton50.
function pushbutton50_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton50 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,2);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;

%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',4.4);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',4.4);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f1 = plot(B,A,'LineWidth',2);
xlabel('Number of cycles');
ylabel('Temp in 1');
title('Level Crossing Curve');
saveas(f1,'LCC_Ch1','jpg')


%% --- Executes on button press in pushbutton52.
function pushbutton52_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton52 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,4);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',4.4);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',3.6);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f3 = plot(B,A,'LineWidth',2);
xlabel('Number of cycles');
ylabel('Temp in 2');
title('Level Crossing Curve');
saveas(f3,'LCC_Ch3','jpg')


%% --- Executes on button press in pushbutton53.
function pushbutton53_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,5);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',4.4);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',4.4);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);


f4 = plot(B,A,'LineWidth',2);
xlabel('Number of cycles');
ylabel('Temp out 2');
title('Level Crossing Curve');
saveas(f4,'LCC_Ch4','jpg');


%% --- Executes on button press in pushbutton54.
function pushbutton54_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,6);

msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',240.5,'MinPeakDistance',4.4);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-242,'MinPeakDistance',4.4);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);


f5 = plot(B,A,'LineWidth',2);
xlabel('Number of cycles');
ylabel('Temp in 3');
title('Level Crossing Curve');
saveas(f5,'LCC_Ch5','jpg')


%% --- Executes on button press in pushbutton55.
function pushbutton55_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton55 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,7);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',30,'MinPeakDistance',4.4);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-41,'MinPeakDistance',4.4);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f6 = plot(B,A,'LineWidth',2);
xlabel('Number of cycles');
ylabel('Temp out 3');
title('Level Crossing Curve');
saveas(f6,'LCC_Ch6','jpg')

%% --- Executes on button press in pushbutton56.
function pushbutton56_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton56 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,8);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',4.8);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',4.8);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f7 = plot(B,A,'LineWidth',2);
xlabel('Number of cycles');
ylabel('Pressure in 1');
title('Level Crossing Curve');
ylim([-50 400]);
saveas(f7,'LCC_Ch7','jpg')

%% --- Executes on button press in pushbutton57.
function pushbutton57_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton57 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,9);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;

%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',4.6);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',4.8);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f8 = plot(B,A,'LineWidth',2);
xlabel('Number of cycles');
ylabel('Pressurein 2');
title('Level Crossing Curve');
ylim([-50 400]);
saveas(f8,'LCC_Ch8','jpg')

%% --- Executes on button press in pushbutton58.
function pushbutton58_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,10);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',4.6);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',4.2);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f9 = plot(B,A,'LineWidth',2);
xlabel('Number of cycles');
ylabel('Pressure in 3');
title('Level Crossing Curve');
ylim([-20 400]);
saveas(f9,'LCC_Ch9','jpg')

%% --- Executes on button press in pushbutton59.
function pushbutton59_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t1 = plot(handles.finaldata(:,1),handles.finaldata(:,2));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp in 1 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t1,'Ch1','jpg')

%% --- Executes on button press in pushbutton60.
function pushbutton60_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t2 = plot(handles.finaldata(:,1),handles.finaldata(:,3));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp out 1 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t2,'Ch2','jpg')

%% --- Executes on button press in pushbutton61.
function pushbutton61_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton61 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t3 = plot(handles.finaldata(:,1),handles.finaldata(:,4));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp in 2 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t3,'Ch3','jpg')

%% --- Executes on button press in pushbutton62.
function pushbutton62_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton62 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t4 = plot(handles.finaldata(:,1),handles.finaldata(:,5));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp out 2 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t4,'Ch4','jpg')

%% --- Executes on button press in pushbutton63.
function pushbutton63_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton63 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,2);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',200);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',200);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');
%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f1 = plot(B,A,'LineWidth',2)
xlabel('Number of cycles');
ylabel('Temp in 1');
title('Level Crossing Curve');
saveas(f1,'LCC_Ch1','jpg')

%% --- Executes on button press in pushbutton64.
function pushbutton64_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton64 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,3);

msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',200);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',200);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');
%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f2 = plot(B,A,'LineWidth',2)
xlabel('Number of cycles');
ylabel('Temp out 1');
title('Level Crossing Curve');
 saveas(f2,'LCC_Ch2','jpg')

%% --- Executes on button press in pushbutton65.
function pushbutton65_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton65 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,4);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',238.5,'MinPeakDistance',200);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-44.5,'MinPeakDistance',200);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);


f3 = plot(B,A,'LineWidth',2)
xlabel('Number of cycles');
ylabel('Temp in 2');
title('Level Crossing Curve');
saveas(f3,'LCC_Ch3','jpg')

%% --- Executes on button press in pushbutton66.
function pushbutton66_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton66 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = finaldata(:,1);
sg = finaldata(:,5);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;

%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',190);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',200);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f4 = plot(B,A,'LineWidth',2)
xlabel('Number of cycles');
ylabel('Temp out 2');
title('Level Crossing Curve');
saveas(f4,'LCC_Ch4','jpg')

%% --- Executes on button press in pushbutton67.
function pushbutton67_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t1 = plot(handles.finaldata(:,1),handles.finaldata(:,2));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp in 1 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t1,'Ch1','jpg')

%% --- Executes on button press in pushbutton68.
function pushbutton68_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton68 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t2 = plot(handles.finaldata(:,1),handles.finaldata(:,3));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp out 1 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t2,'Ch2','jpg')

%% --- Executes on button press in pushbutton69.
function pushbutton69_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton69 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t3 = plot(handles.finaldata(:,1),handles.finaldata(:,4));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp in 2 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t3,'Ch3','jpg')

%% --- Executes on button press in pushbutton70.
function pushbutton70_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton70 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t4 = plot(handles.finaldata(:,1),handles.finaldata(:,5));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp out 2 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t4,'Ch4','jpg')

%% --- Executes on button press in pushbutton72.
function pushbutton72_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton72 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t6 = plot(handles.finaldata(:,1),handles.finaldata(:,7));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp out 3 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t6,'Ch6','jpg')

%% --- Executes on button press in pushbutton73.
function pushbutton73_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton73 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t7 = plot(handles.finaldata(:,1),handles.finaldata(:,8));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp in 4 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t7,'Ch7','jpg')


%% --- Executes on button press in pushbutton74.
function pushbutton74_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton74 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t8 = plot(handles.finaldata(:,1),handles.finaldata(:,9));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp out 4 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t8,'Ch8','jpg')

%% --- Executes on button press in pushbutton75.
function pushbutton75_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton75 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t9 = plot(handles.finaldata(:,1),handles.finaldata(:,10));
xlabel('Time [sec]','fontsize',12);
ylabel('Pressure 1_3 [kPa]','fontsize',12);
title('Time history','fontsize',14);
saveas(t9,'Ch9','jpg')

%% --- Executes on button press in pushbutton71.
function pushbutton71_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton71 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t5 = plot(handles.finaldata(:,1),handles.finaldata(:,6));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp in 3 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t5,'Ch5','jpg')

%% --- Executes on button press in pushbutton76.
function pushbutton76_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton76 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t10 = plot(handles.finaldata(:,1),handles.finaldata(:,12));
xlabel('Time [sec]','fontsize',12);
ylabel('Pressure 2_4 [kPa]','fontsize',12);
title('Time history','fontsize',14);
saveas(t10,'Ch10','jpg')

%% --- Executes on button press in pushbutton77.
function pushbutton77_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton77 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,2);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',220,'MinPeakDistance',170);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-41,'MinPeakDistance',190);


%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);
%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');
%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f1 = plot(B,A,'LineWidth',2);
xlabel('Number of cycles');
ylabel('Temp in 1');
title('Level Crossing Curve');
saveas(f1,'LCC_Ch1','jpg');

%% --- Executes on button press in pushbutton78.
function pushbutton78_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton78 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,3);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',170);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',190);


%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);
%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');
%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);


f2 = plot(B,A,'LineWidth',2);
xlabel('Number of cycles');
ylabel('Temp out 1');
title('Level Crossing Curve');
saveas(f2,'LCC_Ch2','jpg');

%% --- Executes on button press in pushbutton79.
function pushbutton79_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton79 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,4);

msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',180);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',190);


%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);
%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');
%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f3 = plot(B,A,'LineWidth',2);
xlabel('Number of cycles');
ylabel('Temp in 2');
title('Level Crossing Curve');
saveas(f3,'LCC_Ch3','jpg');

%% --- Executes on button press in pushbutton80.
function pushbutton80_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton80 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,5);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',190);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',180);


%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);
%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');
%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f4 = plot(B,A,'LineWidth',2);
xlabel('Number of cycles');
ylabel('Temp out 2');
title('Level Crossing Curve');
saveas(f4,'LCC_Ch4','jpg');

%% --- Executes on button press in pushbutton82.
function pushbutton82_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton82 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,7);

msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',190);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',170);


%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);
%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');
%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);


f6 = plot(B,A,'LineWidth',2);
xlabel('Number of cycles');
ylabel('Temp out 3');
title('Level Crossing Curve');
saveas(f6,'LCC_Ch6','jpg');

%% --- Executes on button press in pushbutton83.
function pushbutton83_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton83 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure
tm = handlees.finaldata(:,1);
sg = handles.finaldata(:,8);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',190);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',190);


%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);
%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');
%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f7 = plot(B,A,'LineWidth',2);
xlabel('Number of cycles');
ylabel('Temp in 4');
title('Level Crossing Curve');
saveas(f7,'LCC_Ch7','jpg');

%% --- Executes on button press in pushbutton84.
function pushbutton84_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton84 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,9);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;

%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',190);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',190);


%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);
%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');
%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f8 = plot(B,A,'LineWidth',2);
xlabel('Number of cycles');
ylabel('Temp out 4');
title('Level Crossing Curve');
saveas(f8,'LCC_Ch8','jpg');

%% --- Executes on button press in pushbutton85.
function pushbutton85_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton85 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%% --- Executes on button press in pushbutton81.
function pushbutton81_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton81 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,6);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;

%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',190);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',190);


%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);
%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');
%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f5 = plot(B,A,'LineWidth',2);
xlabel('Number of cycles');
ylabel('Temp in 3');
title('Level Crossing Curve');
saveas(f5,'LCC_Ch5','jpg');

%% --- Executes on button press in pushbutton86.
function pushbutton86_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton86 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%% --- Executes on button press in pushbutton87.
function pushbutton87_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton87 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t1 = plot(handles.finaldata(:,1),handles.finaldata(:,2));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp in LV1 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t1,'Ch1','jpg')

%% --- Executes on button press in pushbutton88.
function pushbutton88_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton88 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t2 = plot(handles.finaldata(:,1),handles.finaldata(:,3));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp out LV1 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t2,'Ch2','jpg')

%% --- Executes on button press in pushbutton89.
function pushbutton89_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton89 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t3 = plot(handles.finaldata(:,1),handles.finaldata(:,4));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp in LV2 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t3,'Ch3','jpg')


%% --- Executes on button press in pushbutton90.
function pushbutton90_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton90 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t4 = plot(handles.finaldata(:,1),handles.finaldata(:,5));
xlabel('Time [sec]','fontsize',12);
ylabel('Temp out LV2 [°C]','fontsize',12);
title('Time history','fontsize',14);
saveas(t4,'Ch4','jpg')

%% --- Executes on button press in pushbutton91.
function pushbutton91_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton91 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t5 = plot(handles.finaldata(:,1),handles.finaldata(:,6));
xlabel('Time [sec]','fontsize',12);
ylabel('Pressure LV1 [kPa]','fontsize',12);
title('Time history','fontsize',14);
saveas(t5,'Ch5','jpg')

%% --- Executes on button press in pushbutton92.
function pushbutton92_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton92 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t6 = plot(handles.finaldata(:,1),handles.finaldata(:,7));
xlabel('Time [sec]','fontsize',12);
ylabel('Pressure LV2 [kPa]','fontsize',12);
title('Time history','fontsize',14);
saveas(t6,'Ch6','jpg')


%% --- Executes on button press in pushbutton93.
function pushbutton93_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton93 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t7 = plot(handles.finaldata(:,1),handles.finaldata(:,8));
xlabel('Time [sec]','fontsize',12);
ylabel('Flow LV1 [l/min]','fontsize',12);
title('Time history','fontsize',14);
saveas(t7,'Ch7','jpg')

% --- Executes on button press in pushbutton94.
function pushbutton94_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton94 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
t8 = plot(handles.finaldata(:,1),handles.finaldata(:,9));
xlabel('Time [sec]','fontsize',12);
ylabel('Flow LV2 [l/min]','fontsize',12);
title('Time history','fontsize',14);
saveas(t8,'Ch8','jpg')

%% --- Executes on button press in pushbutton95.
function pushbutton95_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton95 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,2);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;

%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',150);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',150);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');
%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

%%
f1 = plot(B,A,'LineWidth',2)
xlabel('Number of cycles');
ylabel('temp in LV1');
title('Level Crossing Curve');
saveas(f1,'LCC_Ch1','jpg')

%% --- Executes on button press in pushbutton96.
function pushbutton96_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton96 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,3);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',170);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',170);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f2 = plot(B,A,'LineWidth',2)
xlabel('Number of cycles');
ylabel('Temp out LV1');
title('Level Crossing Curve');
saveas(f2,'LCC_Ch2','jpg')

%% --- Executes on button press in pushbutton97.
function pushbutton97_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton97 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,4);

msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',170);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',170);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);


f3 = plot(B,A,'LineWidth',2)
xlabel('Number of cycles');
ylabel('Temp in LV2');
title('Level Crossing Curve');
saveas(f3,'LCC_Ch3','jpg')

%% --- Executes on button press in pushbutton98.
function pushbutton98_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton98 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,5);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',150);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',150);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

%%
figure;
f4 = plot(B,A,'LineWidth',2)
xlabel('Number of cycles');
ylabel('Temp out LV2');
title('Level Crossing Curve');
saveas(f4,'LCC_Ch4','jpg')


%% --- Executes on button press in pushbutton99.
function pushbutton99_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton99 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,6);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',150);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',150);


%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');
%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f5 = plot(B,A,'LineWidth',2)
xlabel('Number of cycles');
ylabel('Pressure LV1');
title('Level Crossing Curve');
saveas(f5,'LCC_Ch5','jpg')

%% --- Executes on button press in pushbutton100.
function pushbutton100_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton100 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,7);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',150);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',120);


%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');
%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);


f6 = plot(B,A,'LineWidth',2);
xlabel('Number of cycles');
ylabel('Pressure LV2');
title('Level Crossing Curve');
saveas(f6,'LCC_Ch6','jpg')


%% --- Executes on button press in pushbutton101.
function pushbutton101_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton101 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,8);

msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%%
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',150);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',150);


%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);


for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f7 = plot(B,A,'LineWidth',2)
xlabel('Number of cycles');
ylabel('Flow LV1');
title('Level Crossing Curve');
saveas(f7,'LCC_Ch7','jpg')

%% --- Executes on button press in pushbutton102.
function pushbutton102_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton102 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,9);
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
%
sg = sg';

%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',170);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',170);


%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');
%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%
ss=ss(:,2:3);
ss=sort(ss,2);

%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

%
f8 = plot(B,A,'LineWidth',2);
xlabel('Number of cycles');
ylabel('Flow LV2');
title('Level Crossing Curve');
saveas(f8,'LCC_Ch8','jpg')


%% --- Executes on button press in pushbutton119.
function pushbutton119_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton119 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure;
tm = handles.finaldata(:,1);
sg = handles.finaldata(:,5);
%%
msg = max(sg);
mnsg = min(sg);
pt = msg+20;
vt = mnsg-20;
sg = sg';

%%
[a,pks] = findpeaks(sg,'MinPeakHeight',vt,'MinPeakDistance',240);
[a1,vls] = findpeaks(-sg,'MinPeakHeight',-pt,'MinPeakDistance',235);

%%
id = [pks vls];
sid = sort(id);
tps = sg(sid);

%%
for i=1:length(tps)-1
    MP(i,:)=[tps(i) tps(i+1)];
    i=i+1;
end

%%
mins = min(sg);
maxs = max(sg);
ll = mins:0.01:maxs;
ll1 = ll+0.0001;

%%
for i = 1:length(ll)
        Ind{i} = find(MP(:,1)<ll1(i));
end

%%
for i=1:length(ll)-1
    lcr(i)=sum((MP(Ind{i},2)>=ll(i+1)));
end

%%
lln=sort(ll,'descend');
lln1=lln-0.0001;

%% 
for i = 1:length(ll)
        Ind1{i} = find(MP(:,1)>lln1(i));
end

%%
for i=1:length(ll)-1
    lcr1(i)=sum((MP(Ind1{i},2)<=lln(i+1)));
end

%%
lcr=[lcr 0];
lcr1=[lcr1 0];
upp=[ll;lcr];
dpp=[lln;lcr1];
ud=[upp dpp];
ud(3,:)=sort(ud(1,:),'descend');

%%
s=0;
for i=1:length(ud)
    for j=1:length(upp)
        if ud(3,i)==upp(1,j)
        s=[s upp(2,j)];
        end
        if ud(3,i)==dpp(1,j)
        s=[s dpp(2,j)];
        end
    end
    ss(i,1:length(s))=s;
    s=0;
end

%%
ss=ss(:,2:3);
ss=sort(ss,2);

%%
for i=1:2:length(ud)
    if(i<4)
    ud(4,i)=ss(i,1);
    ud(4,i+1)=ss(i,2);
    else
        ud(4,i)=ss(i,2);
    ud(4,i+1)=ss(i,1);
    end
end

A=ud(3,:);
B=ud(4,:);

f4 = plot(B,A,'LineWidth',2)
xlabel('Number of cycles');
ylabel('Temp out 2');
title('Level Crossing Curve');
saveas(f4,'LCC_Ch4','jpg')
