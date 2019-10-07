% P14, 2007
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

salt_offset([1:273]) = 1.0e-3 * 0.0; % P148, 49NZ20071008/49NZ20071122
salt_offset([274:346]) = 1.0e-3 * 0.4; % P154, 49NZ20121128
