% AR07W, 2013b
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset(1:152) = 1.0e-3 * 0.25; % Average of P153 & P155 (06M220130509)
