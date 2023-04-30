function [Kred,NS,recOrd] = get_reduced_order_K(Kopt,P,CLPERF)
% Select/preprocess optimum synthesized controller
% based on MUSYNPERF.
% recOrd: recommended reduced order when the mu peak tol is
% in a small tolerance to the optimal controller CLPERF value.
% DONE: recompute mu-synthesis margins
%

% default
algorithm = 'balance';
error = 'add';

NS = order(Kopt);
% NS = 20;
StateOrders = 1:NS;
% get all reduced order controllers
Kred = reduce(Kopt,StateOrders,'algorithm',algorithm,...
    'error',error,'display','on');

% tol = min(0.05,(1-CLPERF)/CLPERF-(1e-2));  % *100%
tol = (1-CLPERF)/CLPERF-(1e-2);
for recOrd=1:NS
    Klow = Kred(:,:,recOrd);
    bnd = musynperf(lft(P,Klow));
    if bnd.UpperBound < (1+tol)*CLPERF
        K = Klow;
        break
    end
end

% recompute mu-synthesis margins
upBnd = zeros(1,NS);
for j=1:NS
    Klow = Kred(:,:,j);
    P0low = lft(P,Klow);
    bnd = musynperf(P0low);
    upBnd(j) = bnd.UpperBound;
end

figure,
plot(StateOrders,upBnd,'b-o',...
    StateOrders,CLPERF*ones(1,NS),'r',...
    StateOrders,(1+tol)*CLPERF*ones(1,NS),'--k');
grid;
xlabel('Reduced controller order');
ylabel('Peak \mu upper bound')
xlim([1,NS]);
legend('K_{red} CLPERF','K_{opt} CLPERF',...
    ['\mu peak tolerance =',num2str(tol*100),'%'])
end