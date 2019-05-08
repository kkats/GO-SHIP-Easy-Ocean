%
% Eq.(9) from
%
% Culberson, C. H. (1991). "Dissolved Oxygen". WHPO Publication 91-1
% https://geo.h2o.ucsd.edu/documentation/manuals/pdf/91_1/culber2.pdf
%
% "...If the seawater temperature at the time of pickling it not known, the density
%  of seawater in equation (9) should be calculated at the potential temperature
%  of the water sample." (Section 3.3)
%
function [umolkg, umolL] = convertDO(mll, pre, tem, sal, lon, lat)
    [SA, in_ocean] = gsw_SA_from_SP(sal, pre, lon, lat);
    if any(in_ocean == 0)
        error('convertDO: in_ocean');
    end
    CT = gsw_CT_from_t(SA, t68tot90(tem), pre);
    dens = (1000 + gsw_sigma0(SA, CT)) / 1000;
    %
    umolL  = 44.660 .* mll;
    umolkg = 44.660 .* mll ./ dens;
end
