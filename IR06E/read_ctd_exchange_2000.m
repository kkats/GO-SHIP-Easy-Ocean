function read_ctd_exchange(directory, outputfname)
%
% Input: Directory where WOCE EXCHANGE format CTD files have been unzipped
%        and outputfilename (optional)
%
% Note: Use only flag == 2 (can be modified though)
%
%
if nargin < 1
    error('Usage: read_ctd_exchange(directory_of_unzipped_CTD [, output_filename])');
end
if nargin < 2
    outputfname = 'unnamed';
end
files = dir([directory filesep '*.csv']);

if isempty(files)
    error(['read_ctd_exchange: not found ''' directory '''']);
end

% initialisation
N = length(files);
[pr, te, sa, ox, pr_flg, te_flg, sa_flg, ox_flg] = deal(NaN(7500,N));
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

mmax = 1;
for i = 1:N
    filename = [directory filesep files(i).name]

    [fid, msg] = fopen(filename, 'r');
    if fid < 0
        error(['read_ctd_exchange.m:', msg]);
    end

    % Whatever before 'DBAR,' is header
    header = {};
    while 1
        tline = fgetl(fid);
        if ~ischar(tline)
            fclose(fid);
            error('read_ctd_exchange.m: premature header termination');
        end
        % 06MT030_2 uses "DBARS" instead of "DBAR"
        if length(tline) > 5 && (strcmp(tline(1:5), 'DBAR,') || strcmp(tline(1:6), 'DBARS,'))
            break;
        end
        header = {header{1:end}, tline};
    end
    % check first unit
    % get rid of extra spaces
    m = 1;
    for n = 1:length(tline)
        if ~isspace(tline(n))
            uline(m) = tline(n);
            m = m + 1;
        end
    end
    % strtok skips consecutive separator, i.e. [a,b] = strtok(',,ABC',','); gives a='ABC'
    [punit, r1] = strtok(uline, ',');
    [tunit, r2] = strtok(r1, ',');
    [sunit, r3] = strtok(r2, ',');
    ounit = strtok(r3, ',');

    expo = itemEq(header, 'EXPOCODE');
    station = itemEq(header, 'STNNBR');
    cast = str2num(itemEq(header, 'CASTNO'));
    lat = str2num(itemEq(header, 'LATITUDE'));
    lon = str2num(itemEq(header, 'LONGITUDE'));
    woce_date = str2num(itemEq(header, 'DATE'));
    woce_time = str2num(itemEq(header, 'TIME'));
    time = convert_woce_time(woce_date, woce_time);
    % depth sometime missing
    if isempty(itemEq(header, 'DEPTH'))
        dep = NaN;
    else
        dep = str2num(itemEq(header, 'DEPTH'));
    end

    % read body assuming leftmost 8 columns are
    % PRS, PRS_FLAG, TMP, TMP_FLAG, SAL, SAL_FLAG, OXY, OXY_FLAG
    % if not, CTDtemUnit/CTDsalUnit/CTDoxyUnit might show something.
    [p, pf, t, tf, s, sf, o, of] = deal(NaN(7500,1));
    m = 0;
    while 1
        tline = fgetl(fid);
        if ~ischar(tline) || (length(tline) >= 8 && strcmp(tline(1:8), 'END_DATA'))
            fclose(fid);
            break;
        end
        a = sscanf(tline, '%f,%d,%f,%d,%f,%d,%f,%d');
        m = m + 1;
        p(m) = a(1);
        pf(m) = a(2);
        t(m)= a(3);
        tf(m) = a(4);
        s(m) = a(5);
        sf(m) = a(6);
        if length(a) > 7
            o(m) = a(7);
            of(m) = a(8);
        else
            o(m) = nan;
            of(m) = nan;
        end
        clear a;
    end
    if m > mmax
        mmax = m;
        if mmax > 7500
            error('read_ctd_exchange.m: 7500 reached');
        end
    end
    pr(:,i) = p;
    te(:,i) = t;
    sa(:,i) = s;
    ox(:,i) = o;
    pr_flg(:,i) = pf;
    te_flg(:,i) = tf;
    sa_flg(:,i) = sf;
    ox_flg(:,i) = of;

    stations(i).EXPO   = expo;
    stations(i).Stnnbr = station;
    stations(i).Cast   = cast;
    stations(i).Lat    = lat;
    % longitude in [0, 360];
    if lon < 0
        stations(i).Lon    = lon + 360;
    else
        stations(i).Lon    = lon;
    end
    stations(i).Time   = time;
    stations(i).Depth  = dep;
    stations(i).CTDtemUnit = tunit;
    stations(i).CTDsalUnit = sunit;
    stations(i).CTDoxyUnit = ounit;
end

pr(mmax+1:end,:) = [];
te(mmax+1:end,:) = [];
sa(mmax+1:end,:) = [];
ox(mmax+1:end,:) = [];
pr_flg(mmax+1:end,:) = [];
te_flg(mmax+1:end,:) = [];
sa_flg(mmax+1:end,:) = [];
ox_flg(mmax+1:end,:) = [];

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

% sort in time
for i = 1:length(stations)
    timeseries(i) = stations(i).Time;
end
[dummy, idx] = sort(timeseries, 'ascend');
stations = stations(idx);
pr = pr(:,idx);
te = te(:,idx);
sa = sa(:,idx);
ox = ox(:,idx);

% bad oxygen for station 9 and 10
ox(:,9:10) = NaN;

% finally save .mat files
if length(outputfname) > 4 && strcmp(outputfname(end-3:end), '.mat')
    outputfname = outputfname(1:end-4);
end
eval(['save ''' outputfname '.mat'' stations pr te sa ox']);
%}
end % function read_ctd_nc
%
% utility funtion
%
function out = itemEq(header, label)
    out = '';
    len = length(label);
    for n = 1:length(header)
        line = header{n};
        [lhs, rhs] = strtok(line, '=');
        m = 1;
        if length(lhs) >= len && strcmp(lhs(1:len), label)
            while m <= length(rhs)
                if ~(rhs(m) == ' '  || rhs(m) == '=')
                    break;
                end
                m = m + 1;
            end
            out = rhs(m:end);
            break;
        end
    end
end
