function ro = coef_otraz(n, a)
% ������� �������� ������������ ��������� ���������
% ro - ���������� ��������� ���������
% n - ���������� �����������
% a - ���������� ���������� ������

ro = ((n - 1) .^ 2 + a .^ 2) ./ ((n + 1) .^ 2 + a .^ 2);

end

