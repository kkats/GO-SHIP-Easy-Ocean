function isInJOA = findJOAstations(stations, csvJOAfname)
%
% Find stations in JOA's CSV output from our stations(:)
%
% 1. Take one bottle from JOA's CSV.
% 2. Find all stations within 0.1 deg difference in lat/lon.
% 3. Find the closest station from (2).
% 4. Check if (station_number, cast, time) match between the two.
%
N = length(stations);
isInJOA = false(N,1);
not_found = [];
not_match = [];

% read CSV -- Matlab's csvread() does not work with unexplainable errors
fid = fopen(csvJOAfname, 'r');
if fid < 0
    error(['findJOAstations.m : cannot open ' csvJOAfname]);
end
fgetl(fid); % skip header

n = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break
    end
    a = textscan(tline, '%s', 8, 'Delimiter', ',');
    b = a{1};
    n = n + 1;
    if mod(n, 100) == 0, fprintf(2, 'Bottle %d...\n', n); end
    lon0 = str2num(b{6}); if lon0 < 0, lon0 = lon0 + 360.0; end;
    % JOA data
    joa(n) = struct('stnnum', b{3}, ...
                    'cast',   str2num(b{4}), ...
                    'lat',    str2num(b{5}), ...
                    'lon',    lon0, ...
                    'date',   b{7}, ...
                    'depth',  str2num(b{8}), ...
                    'pair',   -999);

    % examine if this is included in our stations(:)
    ig = []; 
    for i = 1:N
        % any stations within 0.1 deree Lat/Lon
        if abs(stations(i).Lat - joa(n).lat) < 0.1 && abs(stations(i).Lon - joa(n).lon) < 0.1
            ig = [i; ig];
        end
    end
    % if more than 1 candidate, then find closest by distance
    if length(ig) > 1
        dx = NaN(size(ig));
        for k = 1:length(ig)
           dx(k) = gsw_distance([stations(ig(k)).Lon, joa(n).lon], [stations(ig(k)).Lat, joa(n).lat]);
        end
        [dummy, idx] = sort(dx);
        ig1 = ig(idx(1));
    elseif length(ig) == 1
        ig1 = ig;
    else
        % No CCHDO statations near JOA station
        not_found = [joa(n); not_found];
        continue;
    end
    % double check
    % compare (1) first 3 characters of stnnum
    %         (2) cast number
    %         (3) JOA time (bottle time) is always the same or at most a day
    %             after the CCHDO time (CTD BO (sometimes BE) time)
    s0 = stations(ig1).Stnnbr;
    timediff = datenum(joa(n).date) - stations(ig1).Time;
    if strncmp(joa(n).stnnum, s0, 3) ~= true ...
       || joa(n).cast ~= stations(ig1).Cast ...
       || timediff < -1 || timediff > 1
        % closest station found but fails comparison (1)(2)(3)
        joa(n).pair = ig1;
        not_match = [joa(n); not_match];
        continue;
    end
    % found!
    isInJOA(ig1) = true;
end
fclose(fid);

% show diagnostics
fprintf(2, 'Found %d CCHDO stations out of %d JOA bottles.\n', ...
                    length(find(isInJOA)), n);
not_found_station = bottle2station(not_found);
fprintf(2, 'Warning: %d JOA stations had no CCHDO stations near by\n', length(not_found_station));
for i = 1:length(not_found_station)
    n1 = not_found_station(i);
    fprintf(2, 'Warning: not found(%2d) %3s-%d %12.4f%12.4f %10s d=%4d\n', ...
            i, n1.stnnum, n1.cast, n1.lat, n1.lon, n1.date, n1.depth);
end
not_match_station = bottle2station(not_match);
fprintf(2, 'Warning: %d station pairs did not match\n', length(not_match_station));
for i = 1:length(not_match_station)
    n2 = not_match_station(i);
    n3 = stations(n2.pair);
    fprintf(2, 'Warning: %d JOA   %3s-%d %12.4f%12.4f %10s d=%4d\n', ...
            i, n2.stnnum, n2.cast, n2.lat, n2.lon, n2.date, n2.depth);
    fprintf(2, 'Warning: %d CCHDO %3s-%d %12.4f%12.4f %10s d=%4d\n', ...
            i, n3.Stnnbr, n3.Cast, n3.Lat, n3.Lon, datestr(n3.Time, 29), n3.Depth);
end
end
%
% utility function
%
function stns = bottle2station(bots)
%
% Use station-cast pair as key to convert bottle -> station
%
if isempty(bots)
    stns = [];
else
    j = 1;
    done(j) = struct('station', bots(1).stnnum, ...
                     'cast', bots(1).cast, ...
                    'self', bots(1));
    for i = 2:length(bots)
        if strncmp(bots(i).stnnum, done(j).station, 5) ~= true || bots(i).cast ~= done(j).cast
            j = j + 1;
            done(j) = struct('station', bots(i).stnnum, ...
                             'cast', bots(i).cast, ...
                             'self', bots(i));
        end
    end
    for i = 1:j
        stns(i) = done(i).self;
    end
end % if isempty(..
end
