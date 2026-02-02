clear; clc;
dataX = [1 2 3 4 7];
dataY = [17 17.5 76 210.5 1970];
x = 5;

valNoiSuy = 0;
for l = 1:length(dataX)
    temp = 1;
    for k = 1:length(dataX)
        if k ~= l
            temp = temp*(x - dataX(1,k))/(dataX(1,l) - dataX(1,k));
        end
    end
    valNoiSuy = valNoiSuy + dataY(1,l)*temp;
end

disp(valNoiSuy);