% Lab 1
% Samuel Riedo
% 7 October 2016

%% Section 3.1

xaxis=[-4 -3 -2 -1 0 1 2 3 4 5 6];
yaxis=[0 0 0 0 4 3 2 1 0 0 0];

plot(xaxis, yaxis), grid on
hold on;                                    % Without hold on, stem graph erase plot graph
stem(xaxis, yaxis), grid on

legend('plot','stem')                       % Graph comments
title(legend,'Exercice 3.1')
xlabel('x[ln]') 
ylabel('n') 

%% Section 3.2

t = (-1:10e-5:1);                           % -1 < t < 1 with 10us incr
f = 2;
y = 2*pi*f*t;
plot(t, (sin(2*pi*f*t)) + ((1/3)*sin(2*pi*3*f*t)) + ((1/5)*sin(2*pi*5*f*t)) + ((1/7)*sin(2*pi*7*f*t))), grid on
hold on;
plot(t, cos(y) + cos(3*y)/9 + cos(5*y)/25 + cos(7*y)/49), grid on

legend('x1','x2')                           % Graph comments
title(legend,'Exercice 3.2')
xlabel('Voltage') 
ylabel('Time') 

%% Section 3.3

% Part 1

t = (0:5e-6:0.005);                         % 0 < t < 5 with 5us incr
y = 2*pi*440*t;
x1 = 0.6*cos(y)+0.3*cos(2*y + 1);
x2 = 0.1*cos(2*pi*25000*t);

x = (1+x1).*x2;
plot (t, x), grid on
legend('x')                                 % Graph comments
title(legend,'Exercice 3.3 Part 1')
xlabel('Time') 
ylabel('Voltage') 

% part 2

subplot(2, 1, 1); plot (t, x1), hold on, plot (t, x2)
legend('x1', 'x2')                          % Graph comments
title(legend,'Exercice 3.3 Part 2')
xlabel('Time') 
ylabel('Voltage')

subplot(2, 1, 2); plot (t, x)
legend('x')                                 % Graph comments
title(legend,'Exercice 3.3 Part 2')
xlabel('Time') 
ylabel('Voltage')
 

% 3.4

% Part 1
t = (-1:10e-6:1);                           % -1 < t < 1 with 10us incr
plot(t, InverseFourier(250)), grid on

% Part 2
t = (0:5e-6:5);                             % 0 < t < 5 with 5us incr
y = 2*pi*440*t;
sound(0.6*cos(y)+0.3*cos(2*y + 1), 200000)  % 200000 because 1/5e-6 in t

% Part 3
t = (0:5e-6:5);                             % 0 < t < 5 with 5us incr
z = [t(1: round((1/5)*length(t))) ones(1,round((4/5)*length(t)))];
k = 0.6*cos(y)+0.3*cos(2*y + 1);

sound(0.6*cos(y)+0.3*cos(2*y + 1).*z, 200000)

subplot(2, 1, 1); plot (t, k)
legend('Son sans attaque')                  % Graph comments
title(legend,'Attaque du son')
xlabel('Time') 
ylabel('Voltage')

subplot(2, 1, 2); plot (t, k.*z)
legend('Son avec attauque')                 % Graph comments
title(legend,'Attaque du son')
xlabel('Time') 
ylabel('Voltage')