function station_list(s, isInJOA, isInP, isInAtlas, filename)
%
% print out stations(:) data defined in read_ctd_nc.m
%
%
%
if nargin > 4
    fid = fopen(filename, 'w');
else
    fid = 1  % matlab stdout (https://www.mathworks.com/matlabcentral/fileexchange/4871-printf--stdout--stderr)
end
fprintf(fid, '#   flag      latitude     longitude date       time      depth    expo     stn_num  cast\n');
for i = 1:length(s)
    flag = [];
    if isInJOA(i),   flag = ['J', flag]; end
    if isInP(i),     flag = ['P', flag]; end
    if isInAtlas(i), flag = ['A', flag]; end
    woce_date = datestr(s(i).Time, 'mm/dd/yyyy');
    woce_time = datestr(s(i).Time, 'HH:MM');
    fprintf(fid, '%3d%5s %12.3f %12.3f   %10s %5s     %4d %12s    %3s %3d\n', ...
                  i, flag, s(i).Lat, s(i).Lon, woce_date, woce_time, s(i).Depth, ...
                  s(i).EXPO, s(i).Stnnbr, s(i).Cast);
end
if nargin > 4
    fclose(fid);
end
end
