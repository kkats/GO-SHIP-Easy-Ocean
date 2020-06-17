% S04I, 1994
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:107]) = 1.0e-3 * 0.7; % P123 (09AR9404_1)
salt_offset([108:215]) = 1.0e-3 * 0.2; % P125 (320696_3)
