function [out_args] = temperature(varargin)
% 273.15 = temperature(0, 'C', 'K')
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
                        out_args = (in_args +  459.67) .* (5/9);
                    case -5     % 'K' -> 'F'
                        out_args = in_args .* (9/5) - 459.67;
                    case 7      % 'K' -> 'R'
                        out_args = (in_args - 273.15) .* (4/5);
                    case -7     % 'R' -> 'K'
                        out_args = in_args .* (5/4) + 273.15;
                    case 12     % 'F' -> 'R'
                        out_args = (in_args - 32) .* (4/9);
                    case -12    % 'R' -> 'F'
                        out_args = in_args .* (9/4) + 32;
                    otherwise
                        % �������������� �� ���������� ������������
                        warning('"�������" � "��������" ����������� ���������.');
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

end
