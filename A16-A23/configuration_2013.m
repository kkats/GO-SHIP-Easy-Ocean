% A10-A23, 2013
soffset_handle = @salt_offset;
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

function so = salt_offset(k)
%
% Given station number, returns salinity offset
%
if k <= 145
    so = 1.0e-3 * 0.1; % P155 (33RO20130803)
else
    so = 1.0e-3 * 0.6; % P154 (33RO20131223)
end
end
