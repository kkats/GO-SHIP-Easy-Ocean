% A16-A23, 1988
soffset_handle = @salt_offset;
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

function so = salt_offset(k)
%
% Given station number, returns salinity offset
%
so = 1.0e-3 * 1.7; % P108 (32OC202_1, 32OC202_2, 318MHYDROS4, 318MSAVE5)
end
