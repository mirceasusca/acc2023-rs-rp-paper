function J = JACOBIAN_FUNCTOR(F,dimF,x,dimX,h)

% % Jacobian functor
% J = @(x,h,F)(F(repmat(x,size(x'))+diag(h))-F(repmat(x,size(x'))))./h';
% % Your function
% f = @(x)[x(1)^2 + x(2)^2; x(1)^3.*x(2)^3];
% % Point at which to estimate it
% x = [1;1];
% % Step to take on each dimension (has to be small enough for precision)
% h = 1e-5*ones(size(x));
% % Compute the jacobian
% J(x,h,f)

% Jacobian functor
x = x';
Xp_delta = repmat(x,size(x'))+diag(h);
X = repmat(x,size(x'));

J = zeros(dimF,dimX);
for k=1:dimF
    J(k,:) = (F(Xp_delta(:,k))-F(X(:,k)))./h';
end
% 
% Jh = @(x,h,F)[(F()-F())./h'];
% 
% % Compute the jacobian
% J = Jh(x',h,F)

end