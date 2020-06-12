% A12, 1996
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:131]) = 1.0e-3 * 0.8; % P127 (06AQANTXIII_4)
