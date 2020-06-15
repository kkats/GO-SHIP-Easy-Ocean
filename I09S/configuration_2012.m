% I09S, 2012
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:95]) = 1.0e-3 * 0.4; %  P153, 09AR20120105
