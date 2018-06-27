% A10-A23, 2003
soffset_handle = @salt_offset;
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;

function so = salt_offset(k)
%
% Given station number, returns salinity offset
%
so = 1.0e-3 * (-0.2); % P143 (33RR200306_01, 33RR200206_02)
end
