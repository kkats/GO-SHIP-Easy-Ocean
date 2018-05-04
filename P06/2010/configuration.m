% P06, 2010
soffset_handle = @salt_offset;
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;

function so = salt_offset(k)
%
% Given station number, returns salinity offset
%
so = 0.7 * 1.0e-3; % P149/P150  what about P151 (station xxx-250)
end
