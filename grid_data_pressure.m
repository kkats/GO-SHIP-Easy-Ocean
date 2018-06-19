function D_pressure = grid_data_pressure(D_reported, ll_grid, pr_grid, depth_file)
%
% Horizontal & vertical interpolation of `reported_data` D_reported.
% lat/lon grid `ll_grid` and pressure_grid `pr_grid` are optional
%

%%%
%%% User defined interpolation functions in configuration.m
%%%
configuration;
%%%

if nargin > 3
    dtable = load(depth_file);
else
    dtable = NaN;
end
    
% lat/lon and depth
stations = D_reported.Station;
nstn = length(stations);
[lats, lons, deps] = deal(NaN(1, nstn));
for i = 1:nstn
    lats(i) = stations{i}.Lat;
    lons(i) = stations{i}.Lon;
    d = NaN;
    % depth missing in the CTD files and depth_file exists
    if length(dtable) ~= 1 || ~isnan(dtable)
        for j = 1:size(dtable, 1)
            if strcmp(stations{i}.Stnnbr, num2str(dtable(j,1))) && stations{i}.Cast == dtable(j,2)
                d = (-1) * dtable(j,3);
                break;
            end
        end
    end
    if isnan(d) || d == 999 % missing data
        good = find(~isnan(D_reported.CTDprs(:,i)) ...
                  & ~isnan(D_reported.CTDtem(:,i)) ...
                  & ~isnan(D_reported.CTDsal(:,i)));
        % assume deepest data 10 m above the botttom
        d = -(D_reported.CTDprs(max(good), i) + 10.0);
    end
    deps(i) = gsw_p_from_z(d, lats(i)); % depth in pressure, not in meters
end

% meridional section
if max(lats) - min(lats) > max(lons) - min(lons)
    ll = lats;
% zonal section
else
    ll = lons;
end

ctdprs = D_reported.CTDprs;
ctdtem = D_reported.CTDtem;
ctdsal = D_reported.CTDsal;
ctdoxy = D_reported.CTDoxy;
ctdCT = D_reported.CTDCT;
ctdSA = D_reported.CTDSA;

% vertical interpolation
[ctdtem_v, ctdsal_v, ctdoxy_v] = deal(NaN(length(pr_grid), nstn));
[ctdCT_v, ctdSA_v] = deal(NaN(length(pr_grid), nstn));
for i = 1:nstn
    ctdtem_v(:,i) = vinterp_handle(ctdprs(:,i), ctdtem(:,i), pr_grid);
    ctdsal_v(:,i) = vinterp_handle(ctdprs(:,i), ctdsal(:,i), pr_grid);
    ctdoxy_v(:,i) = vinterp_handle(ctdprs(:,i), ctdoxy(:,i), pr_grid);
    ctdCT_v(:,i) = vinterp_handle(ctdprs(:,i), ctdCT(:,i), pr_grid);
    ctdSA_v(:,i) = vinterp_handle(ctdprs(:,i), ctdSA(:,i), pr_grid);
end

% horizontal interpolation
[ctdtem_hv, ctdsal_hv, ctdoxy_hv] = deal(NaN(length(pr_grid), length(ll_grid)));
[ctdCT_hv, ctdSA_hv] = deal(NaN(length(pr_grid), length(ll_grid)));
ctdtem_hv = hinterp_handle(ctdtem_v, ll, deps, pr_grid, ll_grid);
ctdsal_hv = hinterp_handle(ctdsal_v, ll, deps, pr_grid, ll_grid);
ctdoxy_hv = hinterp_handle(ctdoxy_v, ll, deps, pr_grid, ll_grid);
ctdCT_hv = hinterp_handle(ctdCT_v, ll, deps, pr_grid, ll_grid);
ctdSA_hv = hinterp_handle(ctdSA_v, ll, deps, pr_grid, ll_grid);

D_pressure = struct('Station', {stations}, ...
                    'CTDtem', ctdtem_hv, ...
                    'CTDsal', ctdsal_hv, ...
                    'CTDoxy', ctdoxy_hv, ...
                    'CTDCT', ctdCT_hv, ...
                    'CTDSA', ctdSA_hv);
end
