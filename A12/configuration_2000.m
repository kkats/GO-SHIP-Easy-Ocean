% A12, 2000
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:68]) = 1.0e-3 * 0.0; % unknown (06AQs00012_3)
