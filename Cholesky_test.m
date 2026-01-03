clear; clc;
% A = [4.9 1.0 0.1 1.1; 1.0 6.4 1.2 0.2; 0.1 1.2 3.6 1.1; 1.1 0.2 1.1 6.4];
% b = [5.0; 2.2; 3.7; 2.2];

A = [7.7 1.2 1.1 2.1; 1.2 8.7 1.3 1.1; 1.1 1.3 8.3 1.0; 2.1 1.1 1.0 4.9];
b = [9.8; 2.3; 2.1; 7.0];
% Điều kiện thực hiện: Ma trận đối xứng & xác định dương

% -------- Cơ sở lý thuyết ---------
% Bước 1: Tách A = L.L'. A(4x4):

% L(1,1)^2          L(2,1)L(1,1)                    L(1,1)L(3,1)                                L(1,1)L(4,1)
% L(2,1)L(1,1)      L(2,2)^2 + L(2,1)^2             L(2,1)L(3,1) + L(2,2)L(3,2)                 L(2,1)L(4,1) + L(2,2)L(4,2)
% L(3,1)L(1,1)      L(3,1)L(2,1) + L(3,2)L(2,2)     L(3,1)^2 + L(3,2)^2 + L(3,3)^2              L(3,1)L(4,1) + L(3,2)L(4,2) + L(3,3)L(4,3)
% L(4,1)L(1,1)      L(4,1)L(2,1) + L(4,2)L(2,2)     L(4,1)L(3,1) + L(4,2)L(3,2) + L(4,3)L(3,3)  L(4,1)^2 + L(4,2)^2 + L(4,3)^2 + L(4,4)^2

disp(A);
% 1.1: Tách thành ma trận L
L = zeros(size(A));
L(1,1) = abs(sqrt(A(1,1)));
L(2,1) = A(2,1)/L(1,1);
L(3,1) = A(3,1)/L(1,1);
L(4,1) = A(4,1)/L(1,1);

L(2,2) = abs(sqrt(A(2,2) - L(2,1)^2));
L(3,2) = (A(3,2) - L(3,1)*L(2,1))/L(2,2);
L(4,2) = (A(4,2) - L(4,1)*L(2,1))/L(2,2);

L(3,3) = abs(sqrt(A(3,3) - L(3,1)^2 - L(3,2)^2));
L(4,3) = (A(4,3) - L(4,1)*L(3,1) - L(4,2)*L(3,2))/L(3,3);

L(4,4) = abs(sqrt(A(4,4) - L(4,1)^2 - L(4,2)^2 - L(4,3)^2));
disp(L);

L_cv = L';
disp(L_cv);

% Bước 2: A.X = B -> L.L'.X = B -> L.Y = B. Tìm Y
Y = zeros(size(b));
Y(1) = b(1)/L(1,1);
Y(2) = (b(2) - Y(1)*L(2,1))/L(2,2);
Y(3) = (b(3) - Y(1)*L(3,1) - Y(2)*L(3,2))/L(3,3);
Y(4) = (b(4) - Y(1)*L(4,1) - Y(2)*L(4,2) - Y(3)*L(4,3))/(L(4,4));
disp(Y);

% Bước 3: L'.X = Y. Tìm X
X = zeros(size(b));
X(4) = Y(4)/L_cv(4,4);
X(3) = (Y(3) - L_cv(3,4)*X(4))/L_cv(3,3);
X(2) = (Y(2) - L_cv(2,3)*X(3) - L_cv(2,4)*X(4))/L_cv(2,2);
X(1) = (Y(1) - L_cv(1,2)*X(2) - L_cv(1,3)*X(3) - L_cv(1,4)*X(4))/L_cv(1,1);
disp(X);

% --- KIỂM TRA LẠI KẾT QUẢ ---
disp('--- Kiểm tra ---');

% Cách 1: So sánh với hàm có sẵn của Matlab (A \ b)
X_matlab = A \ b;
disp('Nghiệm chuẩn của Matlab:');
disp(X_matlab);

disp('Nghiệm tính thủ công:');
disp(X);

% Cách 2: Tính sai số (A*X - b). Nếu gần bằng 0 là đúng.
error = norm(A*X - b);
disp('Sai số:');
disp(error);

if error < 1e-10
    disp('KẾT QUẢ ĐÚNG');
else
    disp('KẾT QUẢ SAI');
end

%% Build Code 
clear; clc;
A = [7.7 1.2 1.1 2.1; 1.2 8.7 1.3 1.1; 1.1 1.3 8.3 1.0; 2.1 1.1 1.0 4.9];
b = [9.8; 2.3; 2.1; 7.0];

[m, n] = size(A);

% Khởi tạo
L = zeros(size(A));
Y = zeros(size(b));
X = zeros(size(b));

% Bước 1: Phân tách A = L.L'
for k = 1:m % Cột
    for l = k:m % hàng
        sum_val = 0;
        
        if k > 1
            sum_val = sum(L(l, 1:k-1).*L(k, 1:k-1));
        end
        
        if k == l
            val = A(k,k) - sum_val;
            if val < 0
                error("Ma trận không xác định dương!");
            end
            L(k,k) = sqrt(val);
        else
            L(l,k) = (A(l,k) - sum_val)./L(k,k);
        end
        
    end 
end

disp(L);
L_cv = L';
disp(L_cv);

% Bước 2: L.Y = b --> Tìm Y
for k = 1:m
    if k == 1
        sum_val = 0;
    else 
        sum_val = sum(Y(1:k-1)'.*L(k, 1:k-1));
    end
    Y(k) = (b(k) - sum_val)./L(k,k);
end

disp(Y);

% Bước 3: L'. X = Y --> Tìm X
for k = m:-1:1
    if k == m
        sum_val = 0;
    else
        sum_val = sum(L_cv(k, k+1:m).*X(k+1:m)');
    end
    X(k) = (Y(k) - sum_val)/L_cv(k,k);
end
disp(X);

% --- KIỂM TRA LẠI KẾT QUẢ ---
disp('--- Kiểm tra ---');

% Cách 1: So sánh với hàm có sẵn của Matlab (A \ b)
X_matlab = A \ b;
disp('Nghiệm chuẩn của Matlab:');
disp(X_matlab);

disp('Nghiệm tính thủ công:');
disp(X);

% Cách 2: Tính sai số (A*X - b). Nếu gần bằng 0 là đúng.
error = norm(A*X - b);
disp('Sai số:');
disp(error);

if error < 1e-10
    disp('KẾT QUẢ ĐÚNG');
else
    disp('KẾT QUẢ SAI');
end