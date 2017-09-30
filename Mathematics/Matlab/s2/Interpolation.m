%% Interpoler la fonction sin(x) sur [0, 2Pi] avec un polynome de degr? 8 utilisant
% des points ?quidistants.

x = linspace(0, 2*pi, 10);                              % 10 points
y = sin(x);                                             % fonction
a = polyfit(x, y, 8)                                    % 8 = degr?, fais les coefficiants

xx = linspace(0, 2*pi, 1000);                           % 1000 points
yy = polyval(a, xx);                                    % valeurs du polynome a ses 1000 points
plot(x, y, 'x', xx, yy, 'red', xx, sin(xx), 'blue')

%% Utiliser un polynome de degr? 4 sur [1, 9] pour interpoler f(x)=e^(x/2)
% Refaire la m?me chose avec un spline

x = linspace(1, 9, 5); % 5 = degr? 4 + 1
y = exp(x/2); 
a = polyfit(x, y, 4); % 4 = degr?

xx = linspace(1, 9, 1000); 
yy = polyval(a, xx);

yys = spline(x,y,xx);

plot(x, y, 'x', xx, yy, 'red', xx, yys, 'blue', xx, exp(xx/2), 'yellow')

%% Interpoler lin?airement par morceau f(x) = 1/(1+25x^2) en utilisant 10 point equidistant entre -1 et 1.

x = linspace(-1, 1, 10);                                % 10 points
y = 1./(1+25*x.^2);                                     % fonction
a = polyfit(x, y, 9);                                   % 8 = degre

xx = linspace(-1, 1, 1000);                             % 1000 points
yy = 1./(1+25*xx.^2);                                   % valeurs du polyn?me ? ses 1000 points
plot(x, y, 'red', xx, yy, 'blue')

%% Utiliser spline pour dessiner un interpolant spline de la fonction e^(2x) * cos(ln(x))
% pour x dans [1, 7]. Trouver un nombre minimal de points pour avoir un bon
% ajustement.

x = linspace(1, 7, 15); 
y = exp(2*x).*cos(log(x));

xx = linspace(1, 7, 100);
yy = exp(2*xx).*cos(log(xx));

yys = spline(x, y, xx);

plot(x, y, 'x', xx, yy, 'blue')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Exercise 6
% Tom & Ben two siblings born the 27 oct '13
% cmd 'datenum' could be useful
%    DATE    Tom  Ben
% 27/10/2013 2.55 2.04 [kg]
% 19/11/2013 3.29 2.58
% 03/12/2013 3.97 2.84
% 20/12/2013 4.93 3.83
% 09/01/2014 5.81 4.62
% 23/01/2014 6.58 5.44
% 05/03/2014 7.54 6.18
% (a) Interpol using poly deg <= 6 and estimate weight 06/04/14
% (b) Again using interpol lin. by part
% (c) Again using interpol spline
% (d) Is the result plausible ?
% (e) Ideally, what should we do to estimate the weight in the future ?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d1 = datenum('27/10/2013', 'dd/mm/yyyy');
d2 = datenum('19/11/2013', 'dd/mm/yyyy');
d3 = datenum('03/12/2013', 'dd/mm/yyyy');
d4 = datenum('20/12/2013', 'dd/mm/yyyy');
d5 = datenum('09/01/2014', 'dd/mm/yyyy');
d6 = datenum('23/01/2014', 'dd/mm/yyyy');
d7 = datenum('05/03/2014', 'dd/mm/yyyy');
df = datenum('06/04/2014', 'dd/mm/yyyy')
dates = [d1, d2, d3, d4, d5, d6, d7];
Tom = [2.55, 3.29, 3.97, 4.93, 5.81, 6.58, 7.54];
Ben = [2.04, 2.58, 2.84, 3.83, 4.62, 5.44, 6.18];
% a) interpol polynomiale deg 6
xx = linspace(d1, d7, 1000);
pT = polyfit(dates, Tom, 6); % deg = nb pts - 1
pB = polyfit(dates, Ben, 6); % deg = nb pts - 1
p1 = polyval(pT, df)
p2 = polyval(pB, df)
% b) lin by part, and extrapolate to defined date
plot(dates, Tom, 'o-', dates, Ben, 'r*-');
datetick('x', 'dd.mm.yyyy', 'keepticks');
grid, legend('Tom', 'Ben');
pT1 = interp1(dates, Tom, df, 'linear', 'extrap')
pB1 = interp1(dates, Ben, df, 'linear', 'extrap')
% c) spline to extrapolate to defined date
sT = spline(dates, Tom, df)
sB = spline(dates, Ben, df)

%%
% Interpoler en un point 5
% Interolation sin(x) sur [0,2Pi] degr? <= 8
x = linspace(0, 2*pi, 9);
y = sin(x);
a = polyfit(x, y, 8);
%xx = linspace(0, 2*pi, 1000); 
yy = polyval(a, 5) 
plot(x, y, 'o', 5, yy, 'r*', 5, sin(5), 'g*')


%% 2.a

x = linspace(0, 6, 3);                              % 10 points
y = [1.225, 0.905, 0.652]';                                             % fonction

v = vander(x)\y
















