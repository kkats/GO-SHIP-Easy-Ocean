% I06S, 1993
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:131]) = 1.0e-3 * 0.4; %  P121 (I06S, 35MFCIVA_1)
