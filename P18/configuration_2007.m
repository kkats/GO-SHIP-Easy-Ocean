% P18, 2007
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:179]) = 1.0e-3 * (-0.6); % P147 (33RO20071215/33RO20080121)
