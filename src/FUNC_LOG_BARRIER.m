function y = FUNC_LOG_BARRIER(FUN_HANDLE,CONSTR_HANDLE,x)

Fx = FUN_HANDLE(x);
Cx = CONSTR_HANDLE(x);
y = Fx - log(1-Cx);
if ~isreal(y)
    y = inf;
end

end