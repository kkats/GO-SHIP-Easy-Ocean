function [idx, ll] = sort_stations(longitudes, latitudes)

% Atlantic?
if any(longitudes <= 180.0) && any(longitudes > 180.0)
    west = find(longitudes > 180.0);
    longitudes(west) = longitudes(west) - 360.0;
end

% meridional
if max(latitudes) - min(latitudes) > max(longitudes) - min(longitudes)
    [~, idx] = sort(latitudes);
    ll = latitudes;
% zonal
else
    [~, idx] = sort(longitudes);
    ll = longitudes;
end
end
