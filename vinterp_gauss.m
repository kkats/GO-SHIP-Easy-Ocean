function zsmooth = vinterp_gauss(p1, z1, p_grid)
%
% vertical smoothing of (p1, z1) onto p_grid with Gaussian window
%
zsmooth = NaN(length(p_grid),1);

% grid interval
dp = mode(diff(p1));

% window
half_width = 11; % dbar
sigma = half_width; % for the moment...
nhalf = ceil(half_width / dp);
nwin = 2 * nhalf + 1;

% extend to above-surface and below-bottom
[minp, minn] = min(p1);
[maxp, maxn] = max(p1);
pex = [minp + dp * [-half_width:-1]'; p1([minn:maxn]); maxp + dp * [1:half_width]'];
zex = [z1(minn) * ones(half_width,1); z1([minn:maxn]); z1(maxn) * ones(half_width,1)];

% fill NaNs in pex
ig = find(~isnan(pex));
ib = find(isnan(pex));
if (length(ig) < 5) % no output if less than 5 valid data
    return
end
pex(ib) = interp1(ig, pex(ig), ib, 'linear');

% data in matrix z, window in matrix w
ig = find(minp <= p_grid & p_grid <= maxp); % no extrapolation
z = NaN(length(ig), nwin);
w = zeros(length(ig), nwin);
for i = 1:length(ig)
    p = p_grid(ig(i));
    ih = find(p - half_width <= pex & pex <= p + half_width);
    if length(ih) > nwin
        error('vinterp_gauss: too many data in one bin');
    end
    dx = pex(ih) - p;
    w(i,[1:length(ih)]) = exp(-(dx / half_width).^2);
    z(i,[1:length(ih)]) = zex(ih);
end
% Avoid NaN's as they will contaminate the grid value
ib = find(isnan(z));
z(ib) = 0;
w(ib) = 0;
weight = sum(w, 2);

% apply
zsmooth(ig) = diag(z * w') ./ weight;
end % function
