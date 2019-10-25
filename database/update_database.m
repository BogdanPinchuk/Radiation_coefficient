script
% Обновление базы данных

clear all; clc

% Металы
metal = what('metal');
% Неметалы
nemetal = what('nemetal');

% Путь к папкам с базамы данных
put_metal = metal.path;
put_nemetal = nemetal.path;

% Выделение основных данных
metal = metal.mat;
metal(:,2) = metal(:,1);
nemetal = nemetal.mat;
nemetal(:,2) = nemetal(:,1);

for i = 1:size(metal,1)
    metal{i,2} = [put_metal '\' char(metal(i,1))];
    zagr = load(metal{i,2});
    zagr = struct2cell(zagr);
    zagr = zagr{1,1};
    metal{i,1} = zagr.name;
    clear zagr i;
end

for i = 1:size(nemetal,1)
    nemetal{i,2} = [put_nemetal '\' char(nemetal(i,1))];
    zagr = load(nemetal{i,2});
    zagr = struct2cell(zagr);
    zagr = zagr{1,1};
    nemetal{i,1} = zagr.name;
    clear zagr i;
end

% Сортировка
metal = sortrows(metal,1);
nemetal = sortrows(nemetal,1);

% Сохранение списка баз данных
save metal metal
save nemetal nemetal

clear
