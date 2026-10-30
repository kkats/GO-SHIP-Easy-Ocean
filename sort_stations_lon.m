function [idx, ll, bool] = sort_stations_lon(longitudes, latitudes)
%
% ll = lon/lat (NOT SORTED: use ll(idx) for sorted lon/lat).
% bool = true for Atlantic zonal section
%
%
nlon = longitudes;
bool = false;
% If in Atlantic, use negative longitudes for the Western Hemisphere
if any(longitudes <= 40.0) && any(longitudes > 280.0)
    west = find(longitudes > 180.0);
    nlon(west) = longitudes(west) - 360.0;
    bool = true;
end

% ALWAYS zonal
[dummy, idx] = sort(nlon);
ll = nlon;
end
