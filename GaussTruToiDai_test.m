clear; clc;
A = [0 2 3; 4 6 7; 2 -3 5];
b = [8; -3; 5];

Ab = [A b]; [m, n] = size(Ab);
% Cơ sở lý thuyết: Thay trụ tối đại
col = 1; 
temp = zeros(1, n);
if Ab(col,col) == 0
    maxNum = abs(Ab(col, col));
    maxRow = col;
    for k = col+1:m
        if abs(Ab(k, col)) > maxNum
            maxNum = abs(Ab(k, col));
            maxRow = k;
        end
    end
    % disp(maxNum);
    % disp(maxRow);
    
    temp = Ab(col, :);
    Ab(col,:) = Ab(maxRow,:);
    Ab(maxRow, :) = temp;
    disp(Ab);
end

clear; clc;
%% Quá trình thuận
A = [0 2 3; 4 6 7; 2 -3 5];
b = [8; -3; 5];
Ab = [A b];
[m, n] = size(Ab);
for k = 1:m
    maxNum = abs(Ab(k, k));
    maxRow = k;
    for p = k+1:m
        if abs(Ab(p, k)) > maxNum
            maxNum = abs(Ab(p, k));
            maxRow = p;
        end
    end

    if maxRow ~= k
        Temp = Ab(k, :);
        Ab(k,:) = Ab(maxRow,:);
        Ab(maxRow, :) = Temp;
        disp(Ab);
    end
        
    Ab(k, :) = Ab(k,:) ./ Ab(k,k);
    for l = (k+1):m
        Ab(l,:) = Ab(l,:) - Ab(l,k).*Ab(k,:);
    end
    disp(Ab);
end

disp(Ab);

%% Quá trình nghịch
X = size(m, 1);
X(m,1) = Ab(m,n)/Ab(m,m);
for k = (m-1):-1:1
    X(k) = (Ab(k, n) - Ab(k,k+1:m)*X(k+1:m)) / Ab(k,k);
end
disp(X);