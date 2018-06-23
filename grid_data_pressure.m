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

[~, ll] = sort_stations(lons, lats);

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

% Interpolate chunk by chunk -- do not interpolate if more than 1 deg apart
chunk = {};
ichunk = {};
len = 0;
llhere = [ll(1)];
idxhere = [1];
for i = 2:length(ll)
    if abs(ll(i) - ll(i-1))  < 1.0;
        llhere = [llhere, ll(i)];
        idxhere = [idxhere, i];
        continue;
    end
    len = len + 1;
    chunk(1, len) = {llhere};
    ichunk(1, len) = {idxhere};
    llhere = [ll(i)];
    idxhere = [i];
end
chunk(1,len+1) = {llhere};
ichunk(1, len+1) = {idxhere};

[ctdtem_hv, ctdsal_hv, ctdoxy_hv] = deal(NaN(length(pr_grid), length(ll_grid)));
[ctdCT_hv, ctdSA_hv] = deal(NaN(length(pr_grid), length(ll_grid)));
for i = 1:length(chunk)
    llhere = chunk{i};
    idxhere = ichunk{i};
    ig = find(min(llhere) < ll_grid & ll_grid < max(llhere));
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

D_pressure = struct('Station', {stations}, ...
                    'CTDtem', ctdtem_hv, ...
                    'CTDsal', ctdsal_hv, ...
                    'CTDoxy', ctdoxy_hv, ...
                    'CTDCT', ctdCT_hv, ...
                    'CTDSA', ctdSA_hv);
end
