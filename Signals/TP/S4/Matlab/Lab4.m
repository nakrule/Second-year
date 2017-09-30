% Lab4
% Samuel Riedo
% 20 January 2016

%% Non-recursive Filter

b = [0.375 0.25 0.375];
fe=500e3;
t = (0:1/fe:2.5);
x = chirp(t,0,2.5,250e3);

y = filterNoRecursive(x, b);

plot(t, x), grid on
hold on;                                    % Without hold on, stem graph erase plot graph
plot(t, y), grid on

% Diagramme de Bode
figure('name', 'Non recursive filter');
H_no_rec = tf(b, [0 0 1], 1/fe);
bode(H_no_rec);
grid on

%% Recursive Filter
a = [1 -0.7787 0.2809];
b = [0.1255 0.2511 0.1255];
fe=500e3;
t = (0:1/fe:2.5);
x = chirp(t,0,2.5,250e3);
y = filterRecursive(x, a, b);

plot(t, x), grid on
hold on;                                    % Without hold on, stem graph erase plot graph
plot(t, y), grid on

% Diagramme de Bode
figure('name', 'Non recursive filter');
H_no_rec = tf(b, a, 1/fe);
bode(H_no_rec);
grid on
