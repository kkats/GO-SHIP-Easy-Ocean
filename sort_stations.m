function [idx, ll, bool] = sort_stations(longitudes, latitudes)
%
% ll = lon/late (NOT SORTED: use ll(idx) for sorted lon/lat).
% bool = true for Atlantic zonal section
%
%

nlon = longitudes;
bool = false;
% If in Atlantic, use negative longitudes for the Western Hemisphere
if any(longitudes <= 180.0) && any(longitudes > 180.0)
    west = find(longitudes > 180.0);
    nlon(west) = longitudes(west) - 360.0;
    bool = true;
end

% meridional
if max(latitudes) - min(latitudes) > max(nlon) - min(nlon)
    [~, idx] = sort(latitudes);
    ll = latitudes;
    bool = false;
% zonal
else
    [~, idx] = sort(nlon);
    ll = nlon;
end
end
