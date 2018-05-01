function D_reported = reported_data(fname_list, fname_raw)
%
% Given edited station list `fname_list` (i.e. unnecessary stations commented out)
% output *clean* reported data structure from `fname_raw` (i.e. output from `read_ctd_nc.m`)
%
%
% Complete 1-to-1 correspondence between stations(:) and pr(:,:), te(:,:), ...
% is necessary, i.e. data for station(i) MUST be in pr(i,:), te(i,:), ...
% and this `i` is the first column of `fname_list`
%

%%%
%%% Use defined functions
%%%
configuration;
%%%
%%%
%%%

eval(['load ''' fname_raw ''' stations pr te sa ox']);

fid = fopen(fname_list, 'r');

% stations to be included
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
[lats, lons] = deal(NaN(nstn,1));

for i = 1:nstn
    lats(i) = stations(good(i)).Lat;
    lons(i) = stations(good(i)).Lon;
end

% meridional section. sort by latitude
if max(lats) - min(lats) > max(lons) - min(lons)
    [dummy, idx] = sort(lats);
% zonal section. sort by longitude
else
    [dummy, idx] = sort(lons);
end

%%%
%%% unit conversion & sorting
%%%
[m, dummy] = size(pr);
[ctdprs, ctdsal, ctdtem, ctdoxy] = deal(NaN(m, nstn));
[ctdSA, ctdCT] = deal(NaN(m, nstn));
stationlist = cell(nstn,1);
for i = 1:nstn
    k = good(idx(i));
    s = stations(k); stationlist{i} = s;
    ctdprs(:,i) = pr(:,k);
    if strncmp(s.CTDtemUnit, 'its-90', 6) || strncmp(s.CTDtemUnit, 'ITS-90', 6) ...
       || strncmp(s.CTDtemUnit, 'its90', 5) || strncmp(s.CTDtemUnit, 'ITS90', 5)
        ctdtem(:,i) = t90tot68(te(:,k));
    else % assume everything else is in IPTS-68
        ctdtem(:,i) = tem(:,k);
    end
    if strncmp(s.CTDsalUnit, 'PSS-78', 6) || strncmp(s.CTDsalUnit, 'pss-78', 6)
        ctdsal(:,i) = sa(:,k) - ones(m,1) * soffset_handle(k);
    else
        error('reported_data.m: Unknown salinity unit');
    end
    if strncmp(s.CTDoxyUnit, 'umol/kg', 7)
        ctdoxy(:,i) = ox(:,k);
    else % any cruise in ml/L?
        error('reported_data.m: Unknown oxgen unit');
    end
    %
    % add TEOS-10
    %
    [SA, in_ocean] = gsw_SA_from_SP(ctdsal(:,i), ctdprs(:,i), s.Lon, s.Lat);
    if any(in_ocean < 1)
        error('reported_data.m: gsw_SA_from_SP, in_ocean == 0');
    end
    ctdSA(:,i) = SA;
    CT = gsw_CT_from_t(SA, t68tot90(ctdtem(:,i)), ctdprs(:,i));
    ctdCT(:,i) = CT;
end
D_reported = struct('Station', {stationlist}, ...
                    'CTDprs', ctdprs, ...
                    'CTDsal', ctdsal, ...
                    'CTDtem', ctdtem, ...
                    'CTDoxy', ctdoxy, ...
                    'CTDCT', ctdCT, ...
                    'CTDSA', ctdSA);
end
