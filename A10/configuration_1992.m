% A10, 1992
soffset_handle = @salt_offset;
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;

function so = salt_offset(k)
%
% Given station number, returns salinity offset
%
so = 1.0e-3 * (-0.9); % P120 (06MT22_5)
end
