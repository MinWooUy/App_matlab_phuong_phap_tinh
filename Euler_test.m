clear; clc;

a = 0;
b = 0.5;
N = 5;
fx = @(x, y)y - x;
h = (b-a)/N;
y0 = 1;
x0 = a;

y1 = y0 + h*fx(x0, y0);
%disp(y1);

m = length(a:h:b);
y = 0;
for k = 1:m-1
    y = y0 + h*fx(x0, y0);
    y0 = y;x0 = x0 + h;
    fprintf("k = %.2f - y = %.4f\n", k, y);
end