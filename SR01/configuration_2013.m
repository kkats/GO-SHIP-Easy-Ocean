% SR01 2013
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:111]) = 1.0e-3 * 0.0; % unknown (74JC20130319)
