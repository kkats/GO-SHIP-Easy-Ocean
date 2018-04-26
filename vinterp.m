function zsmooth = vinterp(p1, z1, p_grid)
%
% vertical smoothing of (p1, z1) onto p_grid
%
ig = find(isfinite(p1) & isfinite(z1));
p = p1(ig);
z = z1(ig);
dp = mode(diff(p));
nfilt = round(80 / dp);
z2 = filtend(z, nfilt);
zsmooth = interp1(p, z2, p_grid, 'linear', NaN); % no extrapolation
end
