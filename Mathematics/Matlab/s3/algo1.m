function algo1(fx, fy)
% fx : fonction fx(t) decrivant les points x dependants de t
% fy : fonction fy(t) decrivant les points y dependants de t
n = 1;
for t = 0:0.001:1,
x(n) = fx(t);
y(n) = fy(t);
n = n + 1;
end
plot(x, y,'.')