clear; clc;
% A = [10+30,-10,-30;-10,10+15+5,-5;-30,-5,5+30+30];
% b = [10; 0; 0];
A = [-8 1 1; 1 -5 1; 1 1 -4];
b = [1; 16; 7];

% ------------- Cơ sở lý thuyết -------------
Ab = [A, b]; % Ghép hai ma trận
%% Bước 1: Quá trình thuận
% 1.1: Chuẩn hóa hàng 1 ma trận
Ab(1,:) = Ab(1,:) ./ Ab(1,1);
% 1.2: Khử x1 ở hàng 2 & 3
Ab(2,:) = Ab(2,:) - Ab(2,1)*Ab(1,:);
Ab(3,:) = Ab(3,:) - Ab(3,1)*Ab(1,:);
% 1.3: Chuẩn hóa hàng 2 ma trận
Ab(2,:) = Ab(2,:) ./ Ab(2,2);
% 1.4: Khử x2 ở hàng 3
Ab(3,:) = Ab(3,:) - Ab(3,2)*Ab(2,:);
% 1.5: Chuẩn hóa hàng 3 ma trận
Ab(3,:) = Ab(3,:) ./ Ab(3,3);

%% Bước 2: Quá trình nghịch
% 2.1: Tìm x3
X(3,1) = Ab(3,4) ./ Ab(3,3);
% 2.2: Tìm x2
X(2,1) = (Ab(2,4) - Ab(2,3) * X(3,1)) ./ Ab(2,2);
% 2.3: Tìm x1
X(1,1) = (Ab(1,4) - Ab(1,3) * X(3,1) - Ab(1,2) * X(2,1)) ./ Ab(1,1);

disp('Giải hệ phương trình:');
disp(X);

clear; clc;
% A = [10+30,-10,-30;-10,10+15+5,-5;-30,-5,5+30+30];
% b = [10; 0; 0];
A = [-8 1 1; 1 -5 1; 1 1 -4];
b = [1; 16; 7];
Ab = [A, b];
% ------------- Build Hàm -------------
%% Quá trình thuận
[m, n] = size(Ab);
for k = 1:m
    Ab(k, :) = Ab(k,:) ./ Ab(k,k);
    for l = (k+1):m
        Ab(l,:) = Ab(l,:) - Ab(l,k).*Ab(k,:);
    end
end

disp(Ab);

%% Quá trình nghịch
X = size(m, 1);
X(m,1) = Ab(m,n)/Ab(m,m);
for k = (m-1):-1:1
    X(k) = (Ab(k, n) - Ab(k,k+1:m)*X(k+1:m)) / Ab(k,k);
end
disp(X);