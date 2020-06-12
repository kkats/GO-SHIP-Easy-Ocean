% A16-A23, 1988
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:272]) = 1.0e-3 * 1.7; % P108 (32OC202_1, 32OC202_2, 318MHYDROS4, 318MSAVE5)
