% I09S, 1995
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

salt_offset([1:146]) = 1.0e-3 * 1.4; %  P128 (I09S, 316N145_5)
salt_offset([147:253]) = 1.0e-3 * 0.0; %  unknown (I09S, 09AR9404_1)
