function station_check(fname)
%
% Given edited station list `fname` (i.e. unnecessary stations commented out)
% diagnose the stations
%
%

fid = fopen(fname, 'r');
% stations to be included
good = [];
n = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    % commented out
    if tline(1) == '%' || tline(1) == '#'
        continue;
    end
    words = textscan(tline, '%s', 4);
    m = sscanf(words{1}{1}, '%d');
    % assume no flag
    lat = sscanf(words{1}{2}, '%f');
    lon = sscanf(words{1}{3}, '%f');
    if isempty(lat)
    % we have flag
        lat = sscanf(words{1}{3}, '%f');
        lon = sscanf(words{1}{4}, '%f');
    end
    n = n + 1;
    lats(n) = lat;
    lons(n) = lon;
    label(n) = m;
end

% meridional section. sort by lat
if max(lats) - min(lats) > max(lons) - min(lons)
    [dummy, idx] = sort(lats);
% zonal section. sort by lon
else
    [dummy, idx] = sort(lons);
end
%
% station distance
%
cum = 0;
for i = 2:n
    j0 = idx(i);
    j1 = idx(i-1);
    dx = gsw_distance([lons(j0), lons(j1)], [lats(j0), lats(j1)]) / 1852;
    cum = cum + dx;
    %fprintf(2, '%3d -- %3d  %8.2f nm %8.2f nm\n', label(i-1), label(i), dx, cum);
    fprintf(2, '%3d -- %3d  %8.2f nm\n', label(j1), label(j0), dx);
end

plot(lons, lats, 'o', 'Color', 'b');
%plot(lons, lats, 'x', 'Color', 'r');
