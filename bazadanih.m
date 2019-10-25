function varargout = bazadanih(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bazadanih_OpeningFcn, ...
                   'gui_OutputFcn',  @bazadanih_OutputFcn, ...
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


function bazadanih_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);


function varargout = bazadanih_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function figure1_CreateFcn(hObject, eventdata, handles)


function popupmenu1_Callback(hObject, eventdata, handles)

% ���� � ������ ��� ������
put_mater = handles.put_mater;

% ��������� ����������� ����
switch get(gcbo, 'Value')
    case 1
        % �������� ������ ������� ������
        material = load([put_mater '\metal.mat']);
    otherwise
        % �������� ������ ������� ������
        material = load([put_mater '\nemetal.mat']);
end;
% �������� ������ ������� ������
material = struct2cell(material);
material = material{1,1};

% ��������� �������� ���������� ������ Listbox
set(handles.listbox1, 'String', material(:,1));
set(handles.listbox1, 'Value', 1);

% ������� ���� � ������ � 1 ���������
put_data = material{1, 2};

% �������� ������ 1 ��������� (���������� ���������)
material = load(put_data);
material = struct2cell(material);
material = material{1,1};

% ��������� ����������� �������
% ����. ���������
if get(handles.popupmenu2, 'Value') == 2
    material.coef_izluch = material.coef_izluch .* 100.0;
    razm_coef_iz = '%';
else
    razm_coef_iz = ' ';
end

% �����������
switch get(handles.popupmenu3, 'Value')
    case 2
        material.temperatura = temperature(material.temperatura, ...
            material.temp_razm, 'C');
        material.temp_razm = 'C';
    case 3
        material.temperatura = temperature(material.temperatura, ...
            material.temp_razm, 'K');
        material.temp_razm = 'K';
    case 4
        material.temperatura = temperature(material.temperatura, ...
            material.temp_razm, 'F');
        material.temp_razm = 'F';
    case 5
        material.temperatura = temperature(material.temperatura, ...
            material.temp_razm, 'R');
        material.temp_razm = 'R';
    otherwise
end;

% ���������� �������
graf_koef(material.temperatura, material.coef_izluch,...
    material.temp_razm, razm_coef_iz);


function popupmenu1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% ��������� ���������� ��������
set(gcbo, 'String', char('������', '��������'));


function listbox1_Callback(hObject, eventdata, handles)

% ���������� �������� - ����� ������
% ��������� �������� listbox
num_mater = get(gcbo, 'Value');

% ���� � ������ ��� ������
put_mater = handles.put_mater;

% �������� ������ ������� ������
switch get(handles.popupmenu1, 'Value') % ��������� �������� popupmenu
    case 1
        % �������� ������ ������� ������
        material = load([put_mater '\metal.mat']);
    otherwise
        % �������� ������ ������� ������
        material = load([put_mater '\nemetal.mat']);
end;
material = struct2cell(material);
material = material{1,1};

% ������� ���� � ������ � n ���������
put_data = material{num_mater, 2};

% �������� ������ 1 ��������� (���������� ���������)
material = load(put_data);
material = struct2cell(material);
material = material{1,1};

% ��������� ����������� �������
% ����. ���������
if get(handles.popupmenu2, 'Value') == 2
    material.coef_izluch = material.coef_izluch .* 100.0;
    razm_coef_iz = '%';
else
    razm_coef_iz = ' ';
end;

% �����������
switch get(handles.popupmenu3, 'Value')
    case 2
        material.temperatura = temperature(material.temperatura, ...
            material.temp_razm, 'C');
        material.temp_razm = 'C';
    case 3
        material.temperatura = temperature(material.temperatura, ...
            material.temp_razm, 'K');
        material.temp_razm = 'K';
    case 4
        material.temperatura = temperature(material.temperatura, ...
            material.temp_razm, 'F');
        material.temp_razm = 'F';
    case 5
        material.temperatura = temperature(material.temperatura, ...
            material.temp_razm, 'R');
        material.temp_razm = 'R';
    otherwise
end;

% ���������� �������
graf_koef(material.temperatura, material.coef_izluch,...
    material.temp_razm, razm_coef_iz)


function listbox1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% �������� ��� ������
% ���������
material = what('database');

% ���� � ������ ��� ������
put_mater = material(end).path;
handles.put_mater = put_mater;
guidata(gcbo, handles);
clear material;

% �������� ������ ������� ������
material = load([put_mater '\metal.mat']);
material = struct2cell(material);
material = material{1,1};

% ��������� �������� ���������� ������ Listbox
set(gcbo, 'String', material(:,1));

% ��������� ���������� ���������
set(gcbo, 'Value', 5);


function axes1_CreateFcn(hObject, eventdata, handles)

% �������� ��� ������
% ���������
material = what('database');

% ���� � ������ ��� ������
put_mater = material(end).path;
handles.put_mater = put_mater;
guidata(gcbo, handles);
clear material;

% �������� ������ ������� ������
material = load([put_mater '\metal.mat']);
material = struct2cell(material);
material = material{1,1};

% ������� ���� � ������ � 5 ���������
put_data = material{5, 2};

% �������� ������ 5 ��������� (���������� ���������)
material = load(put_data);
material = struct2cell(material);
material = material{1,1};

% ����������� ��� ���. ���������
razm_coef_iz = ' ';

% ���������� �������
graf_koef(material.temperatura, material.coef_izluch,...
    material.temp_razm, razm_coef_iz)


function popupmenu2_Callback(hObject, eventdata, handles)

% ��������� ������ ����������� ����. ���������
% ���������� �������� - ����� ������
% ��������� �������� listbox
num_mater = get(handles.listbox1, 'Value');

% ���� � ������ ��� ������
put_mater = handles.put_mater;

% ��������� �������� popupmenu
switch get(handles.popupmenu1, 'Value')
    case 1
        % �������� ������ ������� ������
        material = load([put_mater '\metal.mat']);
    otherwise
        % �������� ������ ������� ������
        material = load([put_mater '\nemetal.mat']);
end;

% �������� ������ ������� ������
material = struct2cell(material);
material = material{1,1};

% ������� ���� � ������ � n ���������
put_data = material{num_mater, 2};

% �������� ������ 1 ��������� (���������� ���������)
material = load(put_data);
material = struct2cell(material);
material = material{1,1};

% ��������� ����������� �������
% ����. ���������
if get(gcbo, 'Value') == 2
    material.coef_izluch = material.coef_izluch .* 100.0;
    razm_coef_iz = '%';
else
    razm_coef_iz = ' ';
end;

% �����������
switch get(handles.popupmenu3, 'Value')
    case 2
        material.temperatura = temperature(material.temperatura, ...
            material.temp_razm, 'C');
        material.temp_razm = 'C';
    case 3
        material.temperatura = temperature(material.temperatura, ...
            material.temp_razm, 'K');
        material.temp_razm = 'K';
    case 4
        material.temperatura = temperature(material.temperatura, ...
            material.temp_razm, 'F');
        material.temp_razm = 'F';
    case 5
        material.temperatura = temperature(material.temperatura, ...
            material.temp_razm, 'R');
        material.temp_razm = 'R';
    otherwise
end;

% ���������� �������
graf_koef(material.temperatura, material.coef_izluch,...
    material.temp_razm, razm_coef_iz)


function popupmenu2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% ��������� ���������� ��������
set(gcbo, 'String', char('(0; 1)', ' %'));


function popupmenu3_Callback(hObject, eventdata, handles)

% ��������� ������ ����������� ����. ���������
% ���������� �������� - ����� ������
% ��������� �������� listbox
num_mater = get(handles.listbox1, 'Value');

% ���� � ������ ��� ������
put_mater = handles.put_mater;

% ��������� �������� popupmenu
switch get(handles.popupmenu1, 'Value')
    case 1
        % �������� ������ ������� ������
        material = load([put_mater '\metal.mat']);
    otherwise
        % �������� ������ ������� ������
        material = load([put_mater '\nemetal.mat']);
end;

% �������� ������ ������� ������
material = struct2cell(material);
material = material{1,1};

% ������� ���� � ������ � n ���������
put_data = material{num_mater, 2};

% �������� ������ 1 ��������� (���������� ���������)
material = load(put_data);
material = struct2cell(material);
material = material{1,1};

% ��������� ����������� �������
% ����. ���������
if get(handles.popupmenu2, 'Value') == 2
    material.coef_izluch = material.coef_izluch .* 100.0;
    razm_coef_iz = '%';
else
    razm_coef_iz = ' ';
end;

% �����������
switch get(gcbo, 'Value')
    case 2
        material.temperatura = temperature(material.temperatura, ...
            material.temp_razm, 'C');
        material.temp_razm = 'C';
    case 3
        material.temperatura = temperature(material.temperatura, ...
            material.temp_razm, 'K');
        material.temp_razm = 'K';
    case 4
        material.temperatura = temperature(material.temperatura, ...
            material.temp_razm, 'F');
        material.temp_razm = 'F';
    case 5
        material.temperatura = temperature(material.temperatura, ...
            material.temp_razm, 'R');
        material.temp_razm = 'R';
    otherwise
end;

% ���������� �������
graf_koef(material.temperatura, material.coef_izluch,...
    material.temp_razm, razm_coef_iz)


function popupmenu3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% ��������� ���������� ��������
set(gcbo, 'String', char(' original', ' �', ' K', ' F', ' R'));


% �������������� ������� ���������

function graf_koef(x, y, razm_x, razm_y)
% ���������� ������� ����. ���������

% ������� ������
% ���� ��� ������ � �����������
if isempty(x) == 1
    x = 0.0;
end;

% ���� ��� ������ � ������������ ���������
if isempty(y) == 1
    y= 0.0;
end;

% ���� 1 ����. ��������� � ��������� ����������
if size(x,2) > size(y,2)
    y = ones(1, size(x,2)) .* y;
end;

% ������
if (size(x,2) ~= size(y,2)) || (size(y,2) == 1)
    plot(x,y, 'LineWidth',2, 'Marker','x', 'MarkerSize',10);
else
    plot(x,y, 'LineWidth',2);
end;

grid;
title('����������� ��������� ��������� \epsilon (T)',...
    'FontName','Times New Roman');
xlabel(['�����������' ' [ ' razm_x ' ]'], 'FontName','Times New Roman');

% ��������� �������� ����
if double(razm_y) == 37     % ����������� � %
    ylabel('����������� ���������, %', 'FontName','Times New Roman');
else
    ylabel('����������� ���������', 'FontName','Times New Roman');
end;

graf_axes = get(gca, 'ylim');
% ��������� ��� X
if graf_axes(1) < 0.0
    graf_axes = [0.0 graf_axes(2)];
    set(gca, 'ylim', graf_axes);
end;

if max(y(:)) > 1.0
    if graf_axes(2) > 100.0
        graf_axes = [graf_axes(1) 100.0];
        set(gca, 'ylim', graf_axes);
    end;
else
    if graf_axes(2) > 1.0
        graf_axes = [graf_axes(1) 1.0];
        set(gca, 'ylim', graf_axes);
    end;
end;

% ��������� ��� Y
if size(x,2) > 1
    set(gca, 'xlim', [min(x) max(x)]);
end;

function [out_args] = temperature(varargin)
% ������� ��������������� �����������
% �������:
% �C [Celsius] - �������
% K [Kelvin] - ��������
% F [Fahrenheit] - ����������
% R [Rankine] - �������
% in_args - ���������� �������� � ��������
% unit1 - ����������� � ������� ��������� �������� in_args
% unit2 - ����������� � ������� ����� ��������������
% out_args - ��������������� �������� � ��������

if nargin ~= 3
    % �������� ���������� ������� ������
    error('�������� ���������� ������� ������.');
else
    in_args = varargin{1};
    unit1 = varargin{2};
    unit2 = varargin{3};
    
    if isnumeric(in_args) && ischar(unit1) && ischar(unit2)
        % �������� ���� ������� ������
        
        if prod(double(unit1) == 67) ||...      % 'C'
                prod(double(unit1) == 75) ||... % 'K'
                prod(double(unit1) == 70) ||... % 'F'
                prod(double(unit1) == 82)       % 'R'
            % �������� ����������� unit1 
            
            if prod(double(unit2) == 67) ||...      % 'C'
                    prod(double(unit2) == 75) ||... % 'K'
                    prod(double(unit2) == 70) ||... % 'F'
                    prod(double(unit2) == 82)       % 'R'
                % �������� ����������� unit2
                
                % ������ �����������
                switch diff([double(unit1) double(unit2)])
                    case 8      % 'C' -> 'K'
                        out_args = in_args + 273.15;
                    case -8     % 'K' -> 'C'
                        out_args = in_args - 273.15;
                    case 3      % 'C' -> 'F'
                        out_args = in_args .* (9/5) + 32;
                    case -3     % 'F' -> 'C'
                        out_args = (in_args - 32) .* (5/9);
                    case 15     % 'C' -> 'R'
                        out_args = in_args .* (4/5);
                    case -15    % 'R' -> 'C'
                        out_args = in_args .* (5/4);
                    case 5      % 'F' -> 'K'
                        out_args = (in_args - 32) .* (5/9) + 273.15;
                    case -5     % 'K' -> 'F'
                        out_args = (in_args + 273.15) .* (9/5) + 32;
                    case 7      % 'K' -> 'R'
                        out_args = (in_args - 273.15) .* (4/5);
                    case -7     % 'R' -> 'K'
                        out_args = in_args .* (5/4) + 273.15;
                    case 12     % 'F' -> 'R'
                        out_args = (in_args - 32) .* (4/9);
                    case -12    % 'R' -> 'F'
                        out_args = in_args .* (9/4) + 32;
                    otherwise
                        out_args = in_args;
                end;
            else
                error('��������� "��������" �����������.');
            end;
        else
            error('��������� "�������" �����������.');
        end;
    else
        error('��������� ��� ������� ������.');
    end;
end;
