% I06S, 2008
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:109]) = 1.0e-3 * 0.7; %  P149 (I06S, 33RR20080204)
