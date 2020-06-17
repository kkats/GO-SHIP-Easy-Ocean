% SR01 2011
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:30]) = 1.0e-3 * 0.0; % unknown (74JC20111127)
