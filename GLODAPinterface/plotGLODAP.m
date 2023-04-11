% Extract GLODAP data for cfc12 from 2012 visit to S04I
D = fromGLODAP('../S04I/s04i_1994.list', 'cfc11');

% plot by longitude
hinterp_handle = @hinterp_bylon;
lx = D.lonlist;
% GLODAPv2 uses -180 < lon < 180, EasyOcean uses 0 < lon < 360
lx(find(lx < 0)) = lx(find(lx < 0)) + 360; D.lonlist = lx;
pr_grid = [0:10:6500];
ll_grid = [20.0:0.1:162.3];

% Go through D for the range of CT and "data"
CT = D.CT;
data = D.data;
CT1 = CT(:); [sCT, lCT] = bounds(CT1(find(~isnan(CT1))));
data1 = data(:); [sdata, ldata] = bounds(data1(find(~isnan(data1))));
rangeCT = lCT - sCT;
rangedata = ldata - sdata;

% lat/lon from EasyOcean (i.e. from CTD files) are sometimes different from
% lat/lon from GLODAPv2 such that a slight difference in lat/lon in EasyOcean
% is truncated in GLODAPv2 causing apparent duplicate stations.
dup = find(abs(lx(2:end) - lx(1:end-1)) < 0.001);
% remove the first ones
warning(['remove ' num2str(length(dup)) ' data from duplicate station']);
D.latlist(dup) = [];
D.lonlist(dup) = [];
D.deplist(dup) = [];
D.pressure(:,dup) = [];
D.data(:,dup) = [];
lx(dup) = [];

nstn = length(D.deplist);
zv = NaN(length(pr_grid), nstn);
ctv = NaN(length(pr_grid), nstn);
%
% vertical interpolation by RR68
%
%{
for i = 1:nstn
    zv(:,i) = vinterp_rr68(D.pressure(:,i), D.data(:,i), pr_grid);
end
%}
%
% vertical interpolation by MRST-PCHIP (Barker & McDougall, 2020)
%
for i = 1:nstn
    y = D.data(:,i);
    x = D.pressure(:,i);
    z = D.CT(:,i);
    ig = find(~isnan(x) & ~isnan(y) & ~isnan(z));
    x = x(ig); y = y(ig); z = z(ig);
    [x, ix] = sort(x);
    if length(x) > 3 % needs at least 4 data
        [zv(:,i), ctv(:,i)] = gsw_tracer_CT_interp(y(ix), z(ix), x, pr_grid, rangeCT / rangedata);
    else % falls back to RR68
        zv(:,i) = vinterp_rr68(x, y(ix), pr_grid);
        ctv(:,i) = vinterp_rr68(x, z(ix), pr_grid);
    end
end
% horizontal interpolate chunk by chunk
% -- do not interpolate if more than MAX_SEPARATION deg apart
%
MAX_SEPARATION = 2.0;
chunk = {};
len = 0;
idxhere = [1];
for i = 2:length(lx)
    if abs(lx(i) - lx(i-1))  < MAX_SEPARATION;
        idxhere = [idxhere, i];
        continue;
    end
    len = len + 1;
    chunk(1, len) = {idxhere};
    idxhere = [i];
end
chunk(1, len+1) = {idxhere};

zhv = NaN(length(pr_grid), length(ll_grid));
cthv = NaN(length(pr_grid), length(ll_grid));
addpath '../';
for i = 1:length(chunk)
    idxhere = chunk{i};
    lxhere = lx(idxhere);
    ig = find(min(lxhere) < ll_grid & ll_grid < max(lxhere));
    if length(idxhere) < 2 || isempty(ig)
        continue;
    end
    zhv(:,ig) = hinterp_handle(zv(:,idxhere), D.lonlist(idxhere), D.latlist(idxhere), ...
                               D.deplist(idxhere), pr_grid, ll_grid(ig));
    cthv(:,ig) = hinterp_handle(ctv(:,idxhere), D.lonlist(idxhere), D.latlist(idxhere), ...
                               D.deplist(idxhere), pr_grid, ll_grid(ig));
end
rmpath '../';

figure(1);
contourf(ll_grid, pr_grid, zhv); title('Data'); axis ij; colorbar
grid on;
figure(2);
contourf(ll_grid, pr_grid, cthv); title('CT'); axis ij; colorbar
