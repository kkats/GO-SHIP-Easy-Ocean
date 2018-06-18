function gridded_NC(gds, fname, ll_grid, pr_grid)
%
% Output reported_data (`gds`) to GrADS readable binary
%
%
ni = length(ll_grid);
nj = length(pr_grid);
nk = length(gds);

% variables
nccreate(fname, 'temperature', ...
                'Dimensions', {'Time', nk, 'st_ocean', nj, 'xt_ocean' ni}, ...
                'Datatype', 'single');
nccreate(fname, 'salinity', ...
                'Dimensions', {'Time', nk, 'st_ocean', nj, 'xt_ocean' ni}, ...
                'Datatype', 'single');
nccreate(fname, 'dissolved_oxygen', ...
                'Dimensions', {'Time', nk, 'st_ocean', nj, 'xt_ocean' ni}, ...
                'Datatype', 'single');
nccreate(fname, 'Conservative_Temperature', ...
                'Dimensions', {'Time', nk, 'st_ocean', nj, 'xt_ocean' ni}, ...
                'Datatype', 'single');
nccreate(fname, 'Absolute_Salinity', ...
                'Dimensions', {'Time', nk, 'st_ocean', nj, 'xt_ocean' ni}, ...
                'Datatype', 'single');
% coordinates -- time not defined
nccreate(fname, 'pressure', ...
                'Dimensions', {'st_ocean', nj}, ...
                'Datatype', 'single');
nccreate(fname, 'lonlat', ...
                'Dimensions', {'xt_ocean', ni}, ...
                'Datatype', 'single');
%
ncwrite(fname, 'pressure', pr_grid);
ncwrite(fname, 'lonlat', ll_grid);
buf = NaN(nk,nj,ni);
for k = 1:nk
    buf(k,:,:) = shiftdim(gds(k).CTDtem, -1);
end
ncwrite(fname, 'temperature', buf);
buf = NaN(nk,nj,ni);
for k = 1:nk
    buf(k,:,:) = shiftdim(gds(k).CTDsal, -1);
end
ncwrite(fname, 'salinity', buf);
buf = NaN(nk,nj,ni);
for k = 1:nk
    buf(k,:,:) = shiftdim(gds(k).CTDoxy, -1);
end
ncwrite(fname, 'dissolved_oxygen', buf);
buf = NaN(nk,nj,ni);
for k = 1:nk
    buf(k,:,:) = shiftdim(gds(k).CTDCT, -1);
end
ncwrite(fname, 'Conservative_Temperature', buf);
buf = NaN(nk,nj,ni);
for k = 1:nk
    buf(k,:,:) = shiftdim(gds(k).CTDSA, -1);
end
ncwrite(fname, 'Absolute_Salinity', buf);
% attributes
ncwriteatt(fname, '/', 'creation_time', datestr(now));
ncwriteatt(fname, 'pressure', 'long_name', 'Depth measured in pressure');
ncwriteatt(fname, 'pressure', 'missing_value', '-999');
ncwriteatt(fname, 'pressure', 'units', 'decibar');
ncwriteatt(fname, 'lonlat', 'long_name', 'Horizontal coordinate in Longitude or Latitude');
ncwriteatt(fname, 'lonlat', 'missing_value', '-999');
ncwriteatt(fname, 'lonlat', 'units', 'degrees');
ncwriteatt(fname, 'temperature', 'long_name', 'Temperature in IPTS-68');
ncwriteatt(fname, 'temperature', 'missing_value', '-999');
ncwriteatt(fname, 'temperature', 'units', 'deg C');
ncwriteatt(fname, 'salinity', 'long_name', 'Salinity in PSS-78');
ncwriteatt(fname, 'salinity', 'missing_value', '-999');
ncwriteatt(fname, 'salinity', 'units', 'PSU');
ncwriteatt(fname, 'dissolved_oxygen', 'long_name', 'Dissolved oxygen-78');
ncwriteatt(fname, 'dissolved_oxygen', 'missing_value', '-999');
ncwriteatt(fname, 'dissolved_oxygen', 'units', 'umol/kg');
ncwriteatt(fname, 'Conservative_Temperature', 'long_name', 'Conservative Temperature in TEOS-10');
ncwriteatt(fname, 'Conservative_Temperature', 'missing_value', '-999');
ncwriteatt(fname, 'Conservative_Temperature', 'units', 'deg C');
ncwriteatt(fname, 'Absolute_Salinity', 'long_name', 'Absolute Salinity in TEOS-10');
ncwriteatt(fname, 'Absolute_Salinity', 'missing_value', '-999');
ncwriteatt(fname, 'Absolute_Salinity', 'units', 'g/kg');
end
