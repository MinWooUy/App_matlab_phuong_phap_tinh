clear; clc;
% A = [1.02 -0.05 -0.1; -0.11 1.03 -0.05; -0.11 -0.12 1.04];
% b = [0.795; 0.849; 1.398];

A = [-8 1 1; 1 -5 1; 1 1 -4];
b = [1; 16; 7];
Ab = [A b]; disp(Ab);

% Lặp Jacobi: A.X = b --> X = C.X + G
% x1 = -0.02x1 + 0.05x2 + 0.1x3 + 0.795
% x2 = 0.11x1 - 0.03x2 + 0.05x3 + 0.849
% x3 = 0.11x1 - 0.12x2 - 0.04x3 + 1.398

% Loại 2:
% -8x1 + x2 + x3 = 1 
% -> -8x1 - x1 + x2 + x3 = 1 - x1 
% -> -9x1 = (-x1 - x2 - x3 + 1) 
% --> x1 = (-x1 - x2 - x3 + 1)/(-9)
%
% x1 - 5x2 + x3 = 16 --> x2 = (-x1 - x2 - x3 + 16)/(-6)
% x1 + x2 + -4x3 = 7 --> x3 = (-x1 - x2 - x3 + 7)/(-5)

[m, n] = size(A);
X = ones(m,1);
C = zeros(m);
G = zeros(m,1);

for k = 1:m
    divNum = A(k,k) - 1;
    G(k) = b(k)/divNum;
    for l = 1:m
        if l == k
            C(k,l) = -1/divNum;
        else
            C(k,l) = -A(k,l)/divNum; 
        end
    end
end

disp(A);
disp([C G]);
xPrev = G; disp(xPrev);

% Điều kiện hội tụ quá trình lặp: max(Chuẩn của C) < 1
cNorm = zeros(m,1);
for k = 1:n
    for l = 1:m
        cNorm(k) = cNorm(k) + abs(C(k,l));
    end
end

disp(cNorm);

if max(cNorm) < 1
    disp("Có thể thực hiện phương pháp lặp Jacobi");
end

errC = max(cNorm)/(1-max(cNorm));
n = 0;
while n < 1000
    n = n + 1;
    X = C*xPrev + G;
    if abs(X - xPrev) < 1e-5
        break;
    end
    xPrev = X;
end

disp(X);
