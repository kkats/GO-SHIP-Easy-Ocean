function D_reported = reported_data(fname_list, fname_raw, depth_file)
%
% Given edited station list `fname_list` (i.e. unnecessary stations commented out)
% output *clean* reported data structure from `fname_raw` (i.e. output from `read_ctd_nc.m`)
%
% If `fname_list` is `all`, all stations are included. Note this `D_reported`
% cannot be gridded because of possible duplication, branching, etc. of cruise tracks.
%
% Complete 1-to-1 correspondence between stations(:) and pr(:,:), te(:,:), ...
% is necessary, i.e. data for station(i) MUST be in pr(i,:), te(i,:), ...
% and this `i` is the first column of `fname_list`
%
clear configuration MAX_SEPARATION hinterp_handle_vinterp_handle salt_offset;
%%%
%%% User defined functions
%%%
configuration;
%%%

if nargin > 2
    did = fopen(depth_file, 'r'); 
    if (did < 0) error (['cannot open ', depth_file]); end
    d = 1;
    while 1
        tline = fgetl(did);
        if ~ischar(tline), break; end
        [expo, qest] = strtok(tline);
        [stn, rest] = strtok(qest);
        a = sscanf(rest, '%f');
        dtable(d) = struct('expo', expo, ...
                           'station', stn, ...
                           'cast', a(1), ...
                           'depth', a(2));
        d = d + 1;
    end
else
    dtable = [];
end

eval(['load ''' fname_raw ''' stations pr te sa ox']);

% stations to be included
if strcmp(fname_list, 'ALL') || strcmp(fname_list, 'all')
    nstn = length(stations);
    good = [1:nstn];
else
    fid = fopen(fname_list, 'r');
    if fid < 0
        error(['reported_data: cannot find file (', fname_list, ')']);
    end
    good = [];
    while 1
        tline = fgetl(fid);
        if ~ischar(tline)
            break;
        end
        % commented out
        if tline(1) == '%' || tline(1) == '#'
            continue;
        end
        n = textscan(tline, '%d', 1);
        good = [cell2mat(n); good];
    end
    nstn = length(good)
end
fclose(fid);

[lats, lons, deps] = deal(NaN(1,nstn));

for i = 1:nstn
    lats(i) = stations(good(i)).Lat;
    lons(i) = stations(good(i)).Lon;
    deps(i) = stations(good(i)).Depth;
end

[idx, nlons, isAtlanticZonal] = sort_stations(lons, lats);

%%%
%%% unit conversion & sorting
%%%
[m, dummy] = size(pr);
[ctdprs, ctdsal, ctdtem, ctdoxy] = deal(NaN(m, nstn));
[ctdSA, ctdCT] = deal(NaN(m, nstn));
stationlist = cell(nstn,1);
[latlist, lonlist, deplist] = deal(NaN(1, nstn));
for i = 1:nstn
    k = good(idx(i));
    s = stations(k); stationlist{i} = s;
    latlist(i) = lats(idx(i));
    if isAtlanticZonal % special treatment
        lonlist(i) = nlons(idx(i));
    else
        lonlist(i) = lons(idx(i));
    end
    deplist(i) = deps(idx(i));
    ctdprs(:,i) = pr(:,k);
    if ~isempty(strfind(s.CTDtemUnit, 'its-90')) ...
       || ~isempty(strfind(s.CTDtemUnit, 'ITS-90')) ...
       || ~isempty(strfind(s.CTDtemUnit, 'its90')) ...
       || ~isempty(strfind(s.CTDtemUnit, 'ITS90'))
        ctdtem(:,i) = te(:,k);
    else % assume everything else is in IPTS-68
        ctdtem(:,i) = t68tot90(te(:,k));
    end
    if ~isempty(strfind(s.CTDsalUnit, 'PSS-78')) ...
     || ~isempty(strfind(s.CTDsalUnit, 'PSS-68')) ...
     || ~isempty(strfind(s.CTDsalUnit, 'PSS78')) ...
     || ~isempty(strfind(s.CTDsalUnit, 'pss-78'))
        ctdsal(:,i) = sa(:,k) + ones(m,1) * salt_offset(k); % offset is correction, i.e. add (not subtract)
    else
        error('reported_data.m: Unknown salinity unit');
    end
    if ~(isempty(strfind(s.CTDoxyUnit, 'mol/kg')) && isempty(strfind(s.CTDoxyUnit, 'UMOL/KG')))
        ctdoxy(:,i) = ox(:,k);
    elseif ~(isempty(strfind(s.CTDoxyUnit, 'ml/l')) && isempty(strfind(s.CTDoxyUnit, 'ML/L')))
        ctdoxy(:,i) = convertDO(ox(:,k), ctdprs(:,i), ctdtem(:,i), ctdsal(:,i), lonlist(i), latlist(i), 'ML/L');
    elseif ~(isempty(strfind(s.CTDoxyUnit, 'mol/l')) && isempty(strfind(s.CTDoxyUnit, 'UMOL/L')))
        ctdoxy(:,i) = convertDO(ox(:,k), ctdprs(:,i), ctdtem(:,i), ctdsal(:,i), lonlist(i), latlist(i), 'MOL/L');
    elseif ~isempty(s.CTDoxyUnit)
        error('reported_data.m: Unknown oxygen unit');
    end
    %
    % add TEOS-10
    %
    [SA, in_ocean] = gsw_SA_from_SP(ctdsal(:,i), ctdprs(:,i), s.Lon, s.Lat);
    if any(in_ocean < 1)
        error('reported_data.m: gsw_SA_from_SP, in_ocean == 0');
    end
    ctdSA(:,i) = SA;
    CT = gsw_CT_from_t(SA, ctdtem(:,i), ctdprs(:,i)); % T in ITS-90
    ctdCT(:,i) = CT;
end
%%%
%%% Depth correction to pressure
%%%
for i = 1:nstn
    ss = stationlist{i};
    d = (-1) * double(ss.Depth);
    % if depth_file exists, overwrite
    if ~isempty(dtable)
        for j = 1:length(dtable)
            if strcmp(ss.EXPO, dtable(j).expo) && strcmp(ss.Stnnbr, dtable(j).station)...
                                               && ss.Cast == dtable(j).cast
                d = (-1) * dtable(j).depth;
                break;
            end
        end
    end
    % missing data
    % d == -4 was used in I05_2002 (74AB20020301)
    % d == 9 for missing value for some SUM files (i.e. 18DD9403_2)
    % d == -100 was used in AR07W_1999 (18HU99022_1)
    if isnan(d) || d == 999 || d == 0 || d == -4 || d == 9 || d == 100
        ctdgood = find(~isnan(ctdprs(:,i)) & ~isnan(ctdtem(:,i)) & ~isnan(ctdsal(:,i)));
        if isempty(ctdgood) % happens when all CTD data are flagged not-good
            dprime = nan;
        else
            dprime = ctdprs(max(ctdgood), i) + 10.0; 
        end
    else
        dprime = gsw_p_from_z(d, ss.Lat);
    end
    ss.Depth = dprime;
    stationlist{i} = ss;
    deplist(i) = dprime;
end

D_reported = struct('Station', {stationlist}, ...
                    'latlist', latlist, ...
                    'lonlist', lonlist, ...
                    'deplist', deplist, ...
                    'CTDprs', ctdprs, ...
                    'CTDsal', ctdsal, ...
                    'CTDtem', ctdtem, ...
                    'CTDoxy', ctdoxy, ...
                    'CTDCT', ctdCT, ...
                    'CTDSA', ctdSA);
end
