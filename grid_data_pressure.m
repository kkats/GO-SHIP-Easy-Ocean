function D_pressure = grid_data_pressure(D_reported, ll_grid, pr_grid)
%
% Horizontal & vertical interpolation of `reported_data` D_reported.
% lat/lon grid `ll_grid` and pressure_grid `pr_grid` are optional
%

%%%
%%% User defined interpolation functions in configuration.m
%%%
configuration;
%%%
    
% lat/lon and depth
stations = D_reported.Station;
nstn = length(stations);
[lats, lons, deps, tims] = deal(NaN(1, nstn));
for i = 1:nstn
    lats(i) = stations{i}.Lat;
    lons(i) = stations{i}.Lon;
    deps(i) = stations{i}.Depth;
    tims(i) = stations{i}.Time;
end

[idx, ll] = sort_stations(lons, lats);
ls = ll(idx); % sort

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

% Interpolate chunk by chunk -- do not interpolate if more than MAX_SEPARATION deg apart
% (defined in configuration)
chunk = {};
ichunk = {};
len = 0;
lshere = [ls(1)];
idxhere = [1];
for i = 2:length(ls)
    if abs(ls(i) - ls(i-1))  < MAX_SEPARATION;
        lshere = [lshere, ls(i)];
        idxhere = [idxhere, i];
        continue;
    end
    len = len + 1;
    chunk(1, len) = {lshere};
    ichunk(1, len) = {idxhere};
    lshere = [ls(i)];
    idxhere = [i];
end
chunk(1,len+1) = {lshere};
ichunk(1, len+1) = {idxhere};

[ctdtem_hv, ctdsal_hv, ctdoxy_hv] = deal(NaN(length(pr_grid), length(ll_grid)));
[ctdCT_hv, ctdSA_hv] = deal(NaN(length(pr_grid), length(ll_grid)));
for i = 1:length(chunk)
    lshere = chunk{i};
    idxhere = ichunk{i};
    ig = find(min(lshere) < ll_grid & ll_grid < max(lshere));
    if length(idxhere) < 2
        continue;
    end
    ctdtem_hv(:,ig) = hinterp_handle(ctdtem_v(:,idxhere), ll(idxhere), deps(idxhere), ...
                                                                    pr_grid, ll_grid(ig));
    ctdsal_hv(:,ig) = hinterp_handle(ctdsal_v(:,idxhere), ll(idxhere), deps(idxhere), ...
                                                                    pr_grid, ll_grid(ig));
    ctdoxy_hv(:,ig) = hinterp_handle(ctdoxy_v(:,idxhere), ll(idxhere), deps(idxhere), ...
                                                                    pr_grid, ll_grid(ig));
    ctdCT_hv(:,ig) = hinterp_handle(ctdCT_v(:,idxhere), ll(idxhere), deps(idxhere), ...
                                                                    pr_grid, ll_grid(ig));
    ctdSA_hv(:,ig) = hinterp_handle(ctdSA_v(:,idxhere), ll(idxhere), deps(idxhere), ...
                                                                    pr_grid, ll_grid(ig));
end

% Use nearest time to the grid point
ntime = interp1(ll, tims(idx), ll_grid, 'nearest');

D_pressure = struct('Station', {stations}, ...
                    'NTime', ntime, ...
                    'CTDtem', ctdtem_hv, ...
                    'CTDsal', ctdsal_hv, ...
                    'CTDoxy', ctdoxy_hv, ...
                    'CTDCT', ctdCT_hv, ...
                    'CTDSA', ctdSA_hv);
end
