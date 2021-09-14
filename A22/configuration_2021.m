% A22, 2021
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:90]) = 1.0e-3 * (-0.5); % P164 (325020210420)
