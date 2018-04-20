function print_stations(s, filename)
%
% print out stations(:) data defined in read_ctd_nc.m
%
%
if nargin > 1
    fid = fopen(filename, 'w');
else
    fid = 1  % matlab stdout (https://www.mathworks.com/matlabcentral/fileexchange/4871-printf--stdout--stderr)
end
for i = 1:length(s)
    woce_date = datestr(s(i).Time, 'mm/dd/yyyy');
    woce_time = datestr(s(i).Time, 'HH:MM');
    fprintf(fid, '%4d %12.3f %12.3f   %10s %5s     %4d %12s    %3s %3d\n', ...
                  i, s(i).Lat, s(i).Lon, woce_date, woce_time, s(i).Depth, ...
                  s(i).EXPO, s(i).Stnnbr, s(i).Cast);
end
if nargin > 1
    fclose(fid);
end
end
