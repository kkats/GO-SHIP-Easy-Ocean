function D_pressure = grid_data_pressure(D_reported, pr_grid, ll_grid)
%
% Horizontal & vertical interpolation of `reported_data` D_reported.
% lat/lon grid `ll_grid` and pressure_grid `pr_grid` are optional
%

%%%
%%% User defined interpolation functions
%%%
configuration;
%%%

% lat/lon and depth
stations = D_reported.Station;
nstn = length(stations);
[lats, lons, deps] = deal(NaN(nstn, 1));
for i = 1:nstn
    lats(i) = stations{i}.Lat;
    lons(i) = stations{i}.Lon;
    d = (-1) * double(stations{i}.Depth);
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

% vertical interpolation
[ctdtem_v, ctdsal_v, ctdoxy_v] = deal(NaN(length(pr_grid), nstn));
for i = 1:nstn
    ctdtem_v(:,i) = vinterp_handle(ctdprs(:,i), ctdtem(:,i), pr_grid);
    ctdsal_v(:,i) = vinterp_handle(ctdprs(:,i), ctdsal(:,i), pr_grid);
    ctdoxy_v(:,i) = vinterp_handle(ctdprs(:,i), ctdoxy(:,i), pr_grid);
end

% horizontal interpolation
[ctdtem_hv, ctdsal_hv, ctdoxy_hv] = deal(NaN(length(pr_grid), length(ll_grid)));
ctdtem_hv = hinterp_handle(pr_grid, ctdtem_v, ll, deps, pr_grid, ll_grid);
ctdsal_hv = hinterp_handle(pr_grid, ctdsal_v, ll, deps, pr_grid, ll_grid);
ctdoxy_hv = hinterp_handle(pr_grid, ctdoxy_v, ll, deps, pr_grid, ll_grid);

D_pressure = struct('Station', {stations}, ...
                    'CTDtem', ctdtem_hv, ...
                    'CTDsal', ctdsal_hv, ...
                    'CTDoxy', ctdoxy_hv);
end
