% P14, 2023
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:82]) = 1.0e-3 * (-0.5); % P166, 49NZ20231006
