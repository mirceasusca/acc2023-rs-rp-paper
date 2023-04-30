function [WSd,WRd,WTd] = get_discrete_weighting_functions(WS,WR,WT,T,metG)

WSd = c2d(WS,T,metG);
WRd = c2d(WR,T,metG);
WTd = c2d(WT,T,metG);

end