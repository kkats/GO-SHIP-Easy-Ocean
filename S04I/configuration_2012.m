% S04I, 2012
soffset_handle = @salt_offset;
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

function so = salt_offset(k)
%
% Given station number, returns salinity offset
%
so = 1.0e-3 * 0.6; % P154 (49NZ20121129/49NZ20130106)
end
