% A10-A23, 2003
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:275]) = 1.0e-3 * (-0.2); % P143 (33RR200306_01, 33RR200206_02, 33RO200501)
