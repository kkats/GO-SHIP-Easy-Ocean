function [zinterp, maxpinterp] = hinterp_bylat(z, lon, lat, maxp, pr_grid, lat_grid)
%
% Horizontal interpolation (and vertical if needed) by objective mapping for meridional section
% (station sorted by lat)
%
% IN: z(:,:) measured (& vertically interpolated) at pr_grid(:) & (lat(:), lon(:))
%   : maxpr(:) bottom pressure at latlon(:)
%   : ll_grid(:) is in latitude
%
% OUT: zinterp(:,:) interpolated on pr_grid(:) and ll_grid(:)
%      maxpinterp(:) bottom pressure at latlon(:)
%

% no size check

dx = gsw_distance(lon, lat);
x = [0, cumsum(dx)];

lon_grid = interp1(lat, lon, lat_grid, 'linear');
dx = gsw_distance(lon_grid, lat_grid);
x1 = gsw_distance([lon(1), lon_grid(1)], [lat(1), lat_grid(1)]);
x_grid = [x1, cumsum(dx)];

[zinterp, maxpiterp] = hinterp_objmap(z, x, maxp, pr_grid, x_grid);
end
