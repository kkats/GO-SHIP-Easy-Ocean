function read_NetCDF_OVIDE(ncfile, expocode, outputfname)
%
% Input: Read NetCDF file from OVIDE 2006 (06MM20061001) and 2010 (35TH20100610)
%
%
%
if nargin < 1
    error('Usage: read_NetCDF_OVIDE(netCDF [, output_filename])');
end
if nargin < 2
    outputfname = 'unnamed';
end

bdate = ncread(ncfile, 'STATION_DATE_BEGIN'); % use BEGIN date
snum = ncread(ncfile, 'STATION_NUMBER');
latlist = ncread(ncfile, 'LATITUDE');
lonlist = ncread(ncfile, 'LONGITUDE');
deplist = ncread(ncfile, 'BOTTOM_DEPTH');
pres = ncread(ncfile, 'PRES');
temp = ncread(ncfile, 'TEMP');
salt = ncread(ncfile, 'PSAL');
doxy = ncread(ncfile, 'OXYK');


% initialisation
N = length(latlist);
[pr, te, sa, ox, pr_flg, te_flg, sa_flg, ox_flg] = deal(NaN(7500,N));
stations(1:N) = struct('EXPO',       '', ...
                       'Stnnbr',     '', ...
                       'Cast',        0, ...
                       'Lat',       0.0, ...
                       'Lon',       0.0, ...
                       'Time',        0, ...
                       'Depth',       0, ...
                       'CTDtemUnit', 'ITS-90', ...   % as prescribed in https://cchdo.ucsd.edu/data/14141/ovide_CTDO2_file_description.pdf
                       'CTDsalUnit', 'PSS-78', ...   % ditto
                       'CTDoxyUnit', 'UMOL/KG');     % ditto

mmax = 1;
for i = 1:N
    stations(i).EXPO   = expocode;
    stations(i).Stnnbr = sprintf('%d', snum(i));
    stations(i).Cast   = 1; % not specified
    stations(i).Lat    = latlist(i);
    % longitude in [0, 360];
    if lonlist(i) < 0
        stations(i).Lon    = lonlist(i) + 360;
    else
        stations(i).Lon    = lonlist(i);
    end
    stations(i).Time   = datenum(bdate(:,i)', 'yyyymmddHHMMSS');
    stations(i).Depth  = deplist(i);
end

% sort in time
for i = 1:length(stations)
    timeseries(i) = stations(i).Time;
end
[dummy, idx] = sort(timeseries, 'ascend');
stations = stations(idx);
pr = pres(:,idx);
te = temp(:,idx);
sa = salt(:,idx);
ox = doxy(:,idx);

% finally save .mat files
if length(outputfname) > 4 && strcmp(outputfname(end-3:end), '.mat')
    outputfname = outputfname(1:end-4);
end
eval(['save ''' outputfname '.mat'' stations pr te sa ox']);
end % function
