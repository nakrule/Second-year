function [m,m_e] = fl(base,n,M1,M2)%,

for counter=1:2.^n
    b=(base-1);
    x(counter)=b +((counter-1)/2.^(n));
end
m=x;
k = 0;
for c1=M1:M2
    k = k + 1;
    for c2=1:2.^n
       b=(base-1);
       x1(k,c2)=(b +((c2-1)/2.^n))*(base.^c1);
    end
end;
m_e=x1;