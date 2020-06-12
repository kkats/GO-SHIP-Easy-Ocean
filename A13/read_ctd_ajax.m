function read_ctd_ajax(filename, expo, outputfname)
%
% Input: AJAX input file, EXPO,  and outputfilename (optional)
%
% Note: Use only flag == 2 (can be modified though)
%
%
if nargin < 2
    error('Usage: read_ctd_ajax(AJAX_CTD_file [, output_filename])');
end
if nargin < 3
    outputfname = 'unnamed';
end

[fid, msg] = fopen(filename, 'r');
if fid < 0
    error(['read_ctd_ajax.m:', msg]);
end

% initialise
N = 200; % possible max stations
% Manual P.5 "All salinity values were calculated from the algorithms for the
% Practical Salinity Scale, 1978 and are listed to three decimal places.
%
stations(1:N) = struct('EXPO',       expo, ...
                       'Stnnbr',     '', ...
                       'Cast',        0, ...
                       'Lat',       0.0, ...
                       'Lon',       0.0, ...
                       'Time',        0, ...
                       'Depth',       0, ...
                       'CTDtemUnit', 'IPTS68', ...
                       'CTDsalUnit', 'PSS-78', ...
                       'CTDoxyUnit', '');
[pr, te, sa] = deal(NaN(7500,N));
[p, t, s, q] = deal(NaN(7500,1));
mmax = 0;
m = 0;
i = 1;
iseof = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        iseof = 1;
        fclose(fid);
    else
        ww = split(tline); % use strtok()
    end
    if iseof == 1 || strcmp(ww{1}, 'LAT')
        if m > 0 % end of data
            if m ~= n + 1
                error('read_ctd_ajax(): inconsistent NOBS');
            end
            fprintf(2, '%s\n', stn);
            stations(i).Stnnbr = stn;
            stations(i).Cast   = cst;
            stations(i).Lat    = lat;
            if lon < 0
                stations(i).Lon = lon + 360;
            else
                stations(i).Lon = lon;
            end
            stations(i).Time = mtime;
            stations(i).Depth = maxp + 10;
            if m - 1 > mmax
                mmax = m - 1;
            end
            t(find(q == 00 | q == 01)) = NaN;
            s(find(q == 00 | q == 10)) = NaN;
            pr(1:(m-1),i) = p(1:(m-1));
            te(1:(m-1),i) = t(1:(m-1));
            sa(1:(m-1),i) = s(1:(m-1));
            [p, t, s, q] = deal(NaN(7500,1));
            i = i + 1;
            if i > N
                error('read_ctd_ajax(): N exceeded');
            end
            if iseof == 1
                break;
            end
        end
        m = 1;
        lat = str2num(ww{2});
        lon = str2num(ww{4});
        n = str2num(ww{6});
    elseif strcmp(ww{1}, 'YMD')
        year = str2num(ww{2});
        month = str2num(ww{3});
        day = str2num(ww{4});
        hhmm = str2num(ww{6});
        mm = mod(hhmm, 100);
        hh = (hhmm - mm) / 100;
        mtime = datenum(year, month, day, hh, mm, 0);
    elseif strcmp(ww{1}, 'STATION')
        stn = ww{2};
        cst = str2num(ww{4});
    elseif strcmp(ww{1}, 'INSTRUMENT')
        maxp = str2num(ww{6});
    elseif strcmp(ww{1}, 'CRUISE') || strcmp(ww{1}, 'CTDPRS') || strcmp(ww{1}, 'DBAR')
        % NOP
    else % data
        a = sscanf(tline, '%f %f %f %d');
        p(m) = a(1);
        t(m) = a(2);
        s(m) = a(3);
        q(m) = a(4);
        m = m + 1;
    end  % if
end % while
stations(i:end) = [];
pr(:,i:end) = [];
te(:,i:end) = [];
sa(:,i:end) = [];
pr(mmax+1:end,:) = [];
te(mmax+1:end,:) = [];
sa(mmax+1:end,:) = [];
% sort in time
for i = 1:length(stations)
    timeseries(i) = stations(i).Time;
end
[dummy, idx] = sort(timeseries, 'ascend');
stations = stations(idx);
pr = pr(:,idx);
te = te(:,idx);
sa = sa(:,idx);
ox = NaN(size(sa));
% finally save .mat files
if length(outputfname) > 4 && strcmp(outputfname(end-3:end), '.mat')
    outputfname = outputfname(1:end-4);
end
eval(['save ''' outputfname '.mat'' stations pr te sa ox']);
end
function outp = split(inp)
    outp = cell(1);
    m = 1;
    str = inp;
    while ~isempty(str)
        [tok, str] = strtok(str, ' ');
        outp{m} = tok;
        m = m + 1;
    end
end % function
