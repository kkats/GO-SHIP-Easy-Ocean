% I06S, 1996
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:98]) = 1.0e-3 * 0.0; %  unknown (I06S, 35MF103_1)
