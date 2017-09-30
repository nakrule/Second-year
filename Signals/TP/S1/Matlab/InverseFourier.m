function out = InverseFourier(n)
% Create a Fourier signal with n sinus
t = (-1:1e-5:1);                            % -1 < t < 1 with 10us incr
x = 2*pi*2*t;
y = sin(x);

    for i = 1:2:(n-1)
        y = y+(1/(i +2)) * sin(x * (i +2));
    end
    out = y;
end

