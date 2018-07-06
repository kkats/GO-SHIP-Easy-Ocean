% S04I, 1994
soffset_handle = @salt_offset;
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

function so = salt_offset(k)
%
% Given station number, returns salinity offset
%
if k<= 107
    so = 1.0e-3 * 0.7; % P123 (09AR9404_1)
else
    so = 1.0e-3 * 0.2; % P125 (320696_3)
end
end
