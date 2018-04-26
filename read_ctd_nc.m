function read_ctd_nc(directory, outputfname)
%
% Input: Directory where NetCDF CTD files have been unzipped
%        and outputfilename (optional)
%
% Note: Use only flag == 2 (can be modified though)
%
% Modified from version "Sarah G. Purkey, Modified Jan, 2018"
% original comments
% ~~~
% function loads netcdf files from CCHDO (https://cchdo.ucsd.edu/) 
% loads sal, temp, pr and ox ctd data and keeps data with "good" (2) woce
% flag
% ~~~
%
%
if nargin < 1
    error('Usage: read_ctd_nc(directory_of_unzipped_CTD [, output_filename])');
end
if nargin < 2
    outputfname = 'unnamed';
end
files = dir([directory filesep '*.nc']);

% initialisation
N = length(files);
[pr, te, sa, ox, pr_flg, te_flg, sa_flg, ox_flg] = deal([]);
stations(1:N) = struct('EXPO',       '', ...
                       'Stnnbr',     '', ...
                       'Cast',        0, ...
                       'Lat',       0.0, ...
                       'Lon',       0.0, ...
                       'Time',        0, ...
                       'Depth',       0, ...
                       'CTDtemUnit', '', ...
                       'CTDsalUnit', '', ...
                       'CTDoxyUnit', '');

for i = 1:length(files)
    filename = [directory filesep files(i).name]

    %check name structure;
    if i == 1 
        try temperature = ncread(filename,'temperature');
            temp_method = 1;
        catch
            temperature = ncread(filename,'CTDTMP');
            temp_method = 2;
        end
    end

    % read contents
    woce_date = ncread(filename, 'woce_date');
    woce_time = ncread(filename, 'woce_time');
    station = ncread(filename, 'station');
    cast = ncread(filename, 'cast');
    latitude = ncread(filename, 'latitude');
    longitude = ncread(filename, 'longitude');
    expocode_1 = ncreadatt(filename, '/', 'EXPOCODE');
    depth = ncreadatt(filename, '/', 'BOTTOM_DEPTH_METERS');

    salinity = ncread(filename, 'salinity');
    salinity_QC = ncread(filename, 'salinity_QC');
    salinity_units = ncreadatt(filename, 'salinity', 'units');

    if temp_method == 1
        temperature = ncread(filename, 'temperature');
        temperature_QC = ncread(filename, 'temperature_QC');
        temp_units = ncreadatt(filename, 'temperature', 'units');
    elseif temp_method == 2
        temperature = ncread(filename, 'CTDTMP');
        temperature_QC = ncread(filename, 'CTDTMP_QC');
        temp_units = ncreadatt(filename, 'CTDTMP', 'units');
    end

    try oxygen = ncread(filename, 'oxygen');
        oxygen_QC = ncread(filename, 'oxygen_QC');
        oxy_units = ncreadatt(filename, 'oxygen', 'units');
    catch
        oxygen = NaN(size(temperature));
        oxygen_QC = NaN(size(temperature));
        oxy_units = '';
    end

    pressure = ncread(filename,'pressure');
    pressure_QC = ncread(filename,'pressure_QC');

    % store
    [m, n] = size(temperature);
    if n ~= 1, error('read_ctd_nc.m: unexpected temperature size'), end
    pr(1:m,i) = pressure;
    te(1:m,i) = temperature;
    sa(1:m,i) = salinity;
    ox(1:m,i) = oxygen;
    pr_flg(1:m,i) = pressure_QC;
    te_flg(1:m,i) = temperature_QC;
    sa_flg(1:m,i) = salinity_QC;
    ox_flg(1:m,i) = oxygen_QC;

    stations(i).EXPO   = expocode_1;
    stations(i).Stnnbr = remove_trailing_white(station);
    stations(i).Cast   = str2num(cast);
    stations(i).Lat    = latitude;
    % longitude in [0, 360];
    if longitude < 0
        stations(i).Lon    = longitude + 360;
    else
        stations(i).Lon    = longitude;
    end
    stations(i).Time   = convert_woce_time(woce_date, woce_time);
    stations(i).Depth  = depth;
    stations(i).CTDtemUnit = temp_units;
    stations(i).CTDsalUnit = salinity_units;
    stations(i).CTDoxyUnit = oxy_units;
end

% missing data
pr(pr < -100) = NaN;
te(te < -100) = NaN;
sa(sa < -100) = NaN;
ox(ox < -100) = NaN;

% QC flag
% retain only flag==2
pr(pr_flg ~= 2) = NaN;
te(te_flg ~= 2) = NaN;
sa(sa_flg ~= 2) = NaN;
ox(ox_flg ~= 2) = NaN;

% finally save .mat files
eval(['save ''' outputfname '''.mat stations pr te sa ox']);
end % function read_ctd_nc
%
% utility funtion
%
function clean = remove_trailing_white(ss)
%
% the station name is followed by unprintable char?
%
c = [];
for i = 1:length(ss)
    s = ss(i);
    if ('0' <= s && s <= '9') || ('a' <= s && s <= 'z') || ('A' <= s && s <= 'Z')
        c = [s c];
    end
end
clean = reverse(c);
end
