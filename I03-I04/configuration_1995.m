% I03-I04, 1995
soffset_handle = @salt_offset;
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

function so = salt_offset(k)
%
% Given station number, returns salinity offset
%
so = 1.0e-3 * 0.6; %  P126 (316N145_8, 316N145_9)
end
