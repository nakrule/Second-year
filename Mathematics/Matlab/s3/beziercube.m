function [PX, PY] = Bezier(PX1, PY1)
% cubique de Bezier
t = linspace(0,1,1000);
PX = (1 - t).^3*PX1(1) + 3*t.*(1 - t).^2*PX1(2) + 3*t.^2.*(1 - t)*PX1(3) + t.^3*PX1(4);
PY = (1 - t).^3*PY1(1) + 3*t.*(1 - t).^2*PY1(2) + 3*t.^2.*(1 - t)*PY1(3) + t.^3*PY1(4);