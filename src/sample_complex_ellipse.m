function p = sample_complex_ellipse(C,R)
% C = x+jy, complex number denoting the center of the ellipse
% R = [R1,R2], range between [-R1

while true
    x = 2*(rand(1)-0.5);
    y = 2*(rand(1)-0.5);
    if x*x+y*y <= 1
        p = (C+x*R(1)+1j*y*R(2));
        % p = [C(1)+x*R(1),C(2)+y*R(2)];
        break
    end
%     if abs(x*x+y*y-1) <= 1e-2
%         p = r*(x+1j*y);
%         break
%     end
end