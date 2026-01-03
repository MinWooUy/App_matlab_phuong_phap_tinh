clear; clc;
X = [58 58.34 58.68 59.02 59.36 59.7];
Y = [4303.52 4363.11 4425.17 4486.69 4548.69 4611.16];

% Bước 1: Xây dựng bảng sai phân
temp = zeros(length(Y) - 1,1);
dTable = zeros(length(Y));
Y = Y';
% fprintf("%.2f\n", dataY');
 
% Sai phân bậc 1
for k = 1:(length(Y)-1)
    temp(k,1) = Y(k+1,1) - Y(k,1);
    dTable(k,1) = temp(k,1);
end
% fprintf("%.2f\n",divideTable(:,1));

% Sai phân bậc 2
for k = 1:(length(Y)-2)
    temp(k,1) = dTable(k+1,1) - dTable(k,1);
    dTable(k,2) = temp(k,1);
end

disp(dTable(:,1:2));

% Build hàm dựng bảng sai phân hữu hạn
clear; clc;
dataX = [58 58.34 58.68 59.02 59.36 59.7];
dataY = [4303.52 4363.11 4425.17 4486.69 4548.69 4611.16];

[output,m] = divideTable(dataY);disp(m);

for k = 1:length(dataY)
    for l = 1:length(dataY)
        fprintf("%.2f\t\t", output(k,l));
        if(l == length(dataY))
            fprintf("\n");
        end
    end
end

y = NoiSuyNewton(dataX, output, m, 58.17);
fprintf("Kết quả nội suy tại điểm " + num2str(58.17) + " là: %.2f\n", y);

function [output, m] = divideTable(dataY)
    l = 2; n = length(dataY);
    output = zeros(n);
    dataY = dataY';
    output(:,1) = dataY;
    while l < (n+1)
        for k = 1:(n-l+1)
            output(k,l) = output(k+1,l-1) - output(k,l-1);
        end
        l = l + 1;
    end
     m = l - 1;
end

% Build hàm newton tiến/lùi
function y = NoiSuyNewton(dataX, output, m, x)
    h = dataX(2) - dataX(1);

    mid = (dataX(end) + dataX(1))/2;
    sum_val = 0;

    if x < mid % Trường hợp 1: Newton Tiến
        t = (x - dataX(1))/h;
        for k = 2:(m-1)
            temp = 1;
            for l = 1:k
                temp = temp*(t - (l-1));
                temp = temp/l;% Tính giai thừa
            end
            sum_val = sum_val + temp*output(1,k + 1);
        end
        y = output(1,1) + t*output(1,2) + sum_val;
    else % Trường hợp 2: Newton lùi
        t = (x - dataX(end))/h;
        for k = 2:(m-1)
            temp = 1;
            for l = 1:k
                temp = temp*(t + (l-1));
                temp = temp/l;
            end
            idx = m - k;
            sum_val = sum_val + temp*output(idx,k + 1);
        end
        y = output(m,1) + t*output(m-1,2) + sum_val;
    end
end