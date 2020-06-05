% P15, 2009
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:128]) = 1.0e-3 * 0.35; % P148/P150, 09SS20090203
salt_offset([129:267]) = 1.0e-3 * 0.0; % P152, 320620110219
