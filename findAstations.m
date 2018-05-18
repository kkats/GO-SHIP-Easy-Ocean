function isInA =findAstations(stations, headerfname)
%
% Find station in WOCE Atlas header file from our stations(:)
%
%
N = length(stations);
isInA = false(N,1);

fid = fopen(headerfname, 'r');
% skip header
fgetl(fid);
fgetl(fid);
fgetl(fid);
fgetl(fid);
n = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break
    end
    a = textscan(tline, '%s %f %f %f %f');
    n = n + 1;
    l0 = a{4}; if l0 < 0, l0 = l0 + 360; end
    astations(n) = struct('stnnum', a{1}, ...
                         'lat', a{3}, ...
                         'lon', l0);
end
for i = 1:length(astations)
    a = astations(i);
    for j = 1:N
        % stations number (and cast match)
        c = stations(j);
        if strncmp(c.Stnnbr, a.stnnum, 3) == true
% no timestamp available in Atlas data
%{
            % check others
            if abs(c.Lat - a.lat) > 0.1 || abs(c.Lon - a.lon) > 0.1 ...
                || abs(c.Time - a.time) > 0.25
                fprintf(2, 'Warning: ATLAS  %3s-%d %12.4f%12.4f %20s\n', ...
                     a.stnnum, a.cast, a.lat, a.lon, datestr(a.time));
                fprintf(2, 'Warning: CCHDO  %3s-%d %12.4f%12.4f %20s\n', ...
                     c.Stnnbr, c.Cast, c.Lat, c.Lon, datestr(c.Time));
            end
%}
            isInA(j) = true;
            break;
        end % if strncmp
    end % for j = 
end % for i = 
end %function