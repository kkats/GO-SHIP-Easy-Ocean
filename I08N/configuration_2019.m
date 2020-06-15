% I08N, 2019
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:69]) = 1.0e-3 * (-0.5); % P162 (49NZ20191205)
