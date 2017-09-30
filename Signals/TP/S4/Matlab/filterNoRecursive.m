function out = filterNoRecursive(in, b)
% Create a Fourier signal with n sinus

    y = zeros(size(in));                % y[size] = in[size]
    
    y(1) = b(1) * in(1);
    y(2) = b(1) * in(2) + b(2) * in(1);
    
    for n = 3:1:length(in)
        y(n) = b(1) * in(n) + b(2) * in(n-1) + b(3) * in(n-2);
    end

    out = y;
end