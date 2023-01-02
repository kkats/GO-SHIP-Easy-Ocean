function [zinterp, maxpinterp] = hinterp_objmap(z, x, maxp, pr_grid, x_grid)
%
% Horizontal interpolation (no vertical interpolation) by objective mapping
%
% IN: z(:,:) measured (& vertically interpolated) at pr_grid(:) & x(:)
%   : maxpr(:) bottom pressure at x(:)
%
% OUT: zinterp(:,:) interpolated on pr_grid(:) and x_grid(:)
%      maxpinterp(:) bottom pressure at latlon(:)
%
%  Roemmich D., Optimal Estimation Of Hydrographic Station Data and Derived Fields,
%  Journal of Physical Oceanography, 13, 1544-1549, Aug 1983.
%

% constants
efold1 = 40; % large e-folding scale
efold2 = 2; % small e-folding scale
evar1 = 0.1;
evar2 = 0.3; % 0.02 in Roemmich (1983)

% horizontal interpolation at constant pressure
zinterp = NaN(length(pr_grid), length(x_grid));

% station by station
for i = 1:(length(x)-1)
    % grids between i and (i+1)
    if i >= length(x) - 1
        ih = find(x(i) <= x_grid);
    else
        ih = find(x(i) <= x_grid & x_grid < x(i+1));
    end
    if isempty(ih)
        continue;
    end
    x_h = interp1([x(i), x(i+1)], [i, i+1], x_grid(ih)); % x_h now measured in station distance unit

    % six stations on both sides are included
    istart = max([1, (i-6)]);
    iend = min([i+7, length(x)]);
    irange = [istart:iend];
    xg = irange; % x is measured in station distance unit
    for j = 1:length(pr_grid)
        zg = z(j,irange);
        x1 = xg(:); z1 = zg(:); % column vector
        if all(isnan(z1))
            continue; % no extrapolation
        end
        ig = find(~isnan(z1));
        x1 = x1(ig); z1 = z1(ig);
        n = length(ig);
        xn = x1 * ones(1,n) - ones(n,1) * x1';
        % large scale
        gaus1 = exp(-xn.^2 / efold1^2);
        acov1 = gaus1 + diag(ones(n,1)) * evar1;
        mred = sum(acov1 \ z1) / sum(acov1 \ ones(n,1)); % spatial mean with red spectra (Bretherton et al., 1976)
        z1 = z1 - mred;
        w1 = acov1 \ z1;
        zlarge = gaus1 * w1;
        % small scale
        gaus2 = exp(-abs(xn) / efold2); % use exponential (Roemmich, 1983)
        acov2 = gaus2 + diag(ones(n,1)) * evar2;
        w2 = acov2 \ (z1 - zlarge);
        % gridding
        xh = ones(length(x_h),1) * x1' - x_h' * ones(1,n);
        zinterp(j,ih) = ones(size(ih')) * mred + exp(-xh.^2 / efold1^2) * w1 + exp(-abs(xh) / efold2) * w2;
    end 
end

% bottom depth
maxpinterp = interp1(x, maxp, x_grid, 'linear');

% mask all (spurious) data below bottom
for i = 1:length(x_grid)
    zinterp(find(pr_grid > maxpinterp(i)), i) = NaN;
end
end
