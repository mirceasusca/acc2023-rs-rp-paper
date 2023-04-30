function plot_T_Q_functional(S,StabBin,Tv,Qv,onlyFeasible)
% - deduc clustere pe culori (cateva categorii, 0-20 db, 20-40 etc
% - arat comportamentele un bucla inchisa pentru acele categorii

figure(101)
h = gca;

if onlyFeasible
%     I = StabBin(:) == false;
%     Svector = S(:);
%     Sunstable_vec = Svector(I);
    % % NormTerm = min(Sunstable_vec);
    Saux = abs(S);
    % min_unstable_thr = min(Sunstable_vec);
    % max_unstable_thr = max(Sunstable_vec);
    Saux(StabBin == false) = NaN;
    % Saux(StabBin == 1) = Saux(StabBin == 1)/min_unstable_thr;

    contourf(Tv,Qv,db(Saux))

%     S = abs(S);
%     contourf(Tv,Qv,db(S))
    
    colorbar
    xlabel('Sampling rate T [s]')
    ylabel('Quantization rate Q')
    set(h,'xscale','log')
    set(h,'yscale','log')
    % set(h,'zscale','log')
    % set(h,'ColorScale','log')
    hold on
else
    % contourf(Tv,Qv,db(Saux))
    contourf(Tv,Qv,db(S))
%     surf(Tv,Qv,db(S))
    colorbar
    xlabel('Sampling rate T [s]')
    ylabel('Quantization rate Q')
    set(h,'xscale','log')
    set(h,'yscale','log')
%     set(h,'zscale','log')
%     set(h,'ColorScale','log')
    hold on
end

end
