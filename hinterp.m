function [zinterp, maxpinterp] = hinterp(z, lon, lat, maxp, pr_grid, ll_grid)
%
% Horizontal interpolation
% IN: z(:,:) measured (& vertically interpolated) at z(:) and latlon(:)
%   : maxpr(:) bottom pressure at latlon(:)
%
% OUT: zinterp(:,:) interpolated on pr_grid(:) and ll_grid(:)
%      maxpinterp(:) bottom pressure at latlon(:)
%
[idx, l] = sort_stations(lon, lat);
latlon = l(idx);
% horizontal interpolation at constant pressure
zinterp = NaN(length(pr_grid), length(ll_grid));
for j = 1:length(pr_grid)
    ig = find(isfinite(z(j,:)));
    if isempty(ig)
        continue;
    end
    if length(ig) > 2
        zinterp(j,:) = interp1(latlon(ig), z(j,ig), ll_grid, 'pchip');
    elseif length(ig) > 1
        zinterp(j,:) = interp1(latlon(ig), z(j,ig), ll_grid, 'linear');
    end
    % remove 'edge effects'
    zinterp(j,find(ll_grid < min(latlon(ig)))) = NaN;
    zinterp(j,find(ll_grid > max(latlon(ig)))) = NaN;
end

% bottom depth
maxpinterp = interp1(latlon, maxp, ll_grid, 'linear');

% mask all (spurious) data below bottom
for i = 1:length(ll_grid)
    zinterp(find(pr_grid > maxpinterp(i)), i) = NaN;
end
end
