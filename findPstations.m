function isInP = findPstations(stations, D_ctd_s)
%
% Find stations in Purkey's output `D_ctd_s = D_ctd(n)` from our stations(:)
%
% 1. Take one station from P output.
% 2. Find all stations within 0.1 deg difference in lat/lon.
% 3. Find the closest station from (2).
% 4. Check if time matches between the two.
%
N = length(stations);
isInP = false(1,N);
not_found = [];
not_match = [];

n = 0;
for i = 1:length(D_ctd_s.lat)
    lat = D_ctd_s.lat(i);
    lon = D_ctd_s.lon(i);
    ig = []; % is good
    for j = 1:N
        % any stations within 0.1 deree Lat/Lon
        if abs(stations(j).Lat - lat) < 0.1 && abs(stations(j).Lon - lon) < 0.1
            ig = [j; ig];
        end
    end
    % if more than 1 candidate, then find closest by distance
    if length(ig) > 1
        dx = NaN(size(ig));
        for k = 1:length(ig)
            dx(k) = gsw_distance([stations(ig(k)).Lon, lon], [stations(ig(k)).Lat, lat]);
        end
        [dummy, idx] = sort(dx);
        ig1 = ig(idx(1));
    elseif length(ig) == 1
        ig1 = ig;
    else
        % No CCHDO statations near P station
        not_found = [i; not_found];
        continue;
    end
    % double check
    % compare time
    timediff = D_ctd_s.dyr(i) - m2decyear(stations(ig1).Time);
    if abs(timediff) > 1
        % closest station found but time does not match
        not_match = [i; not_match];
        continue;
    end
    % found!
    isInP(ig1) = true;
end

% show diagnostics
fprintf(2, 'Warning: %d P stations had no CCHDO stations near by\n', length(not_found));
for k = 1:length(not_found)
    i = not_found(k);
    fprintf(2, 'Warning: not found(%2d) %3d %12.4f%12.4f %16.8f\n', ...
            i, D_ctd_s.stn(i), D_ctd_s.lat(i), D_ctd_s.lon(i), D_ctd_s.dyr(i));
end
fprintf(2, 'Warning: %d station pairs did not match\n', length(not_match));
for k = 1:length(not_match)
    i = not_match(k);
    fprintf(2, 'Warning: not match(%2d) %3d %12.4f%12.4f %16.8f\n', ...
            i, D_ctd_s.stn(i), D_ctd_s.lat(i), D_ctd_s.lon(i), D_ctd_s.dyr(i));
end
end
%
% utility function
%
function dt = m2decyear(mt)
%
% Convert matlab year to decimal yea
%
ymdhms = datevec(mt);
year = ymdhms(1);
% decyear(1992,1,1,0,0) == 1992, i.e., origin at 1Jan 00:00
decyear = mt - datenum(year, 1, 1, 0, 0, 0);
nday = datenum(year+1, 1, 1, 0, 0, 0) - datenum(year, 1, 1, 0, 0, 0); % leap year considered
dt = year + decyear / nday;
end
