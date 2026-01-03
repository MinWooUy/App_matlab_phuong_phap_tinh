clear; clc;
A = [3 -0.1 -0.2; 0.1 7 -0.3; 0.3 -0.2 10];
b = [7.85; -19.3; 71.4];

[m, n] = size(A);
err = 10e-5;

X = zeros(m,1);
n = 0; maxIn = 1000;
while n < maxIn
    n = n + 1;
    xPrev = X;
    for k = 1:m
        sum_val = 0;
        for l = 1:m
            if l ~= k
                sum_val = sum_val + A(k,l)*xPrev(l,1);
            end
        end
        X(k,1) = (b(k,1) - sum_val)/A(k,k);
    end

    if max(abs(X - xPrev)) < err
        disp(X); return;
    end
end