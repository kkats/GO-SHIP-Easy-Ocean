% SR01 2015b
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:14]) = 1.0e-3 * 0.4; % P156 (74JC20151217)
salt_offset([15:31]) = 1.0e-3 * (-0.2); % P158
