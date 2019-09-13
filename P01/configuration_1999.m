% P01, 1999
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

salt_offset([1:78]) = 1.0e-3 * 0.3; % P133 (49KA199905_1), P133/P134 (18DD199905_1)
salt_offset([79:126]) = 1.0e-3 * 0.2; % P135 (49NZ199905_1/49NZ199908_1/49NZ199909_2/49KA199905_1)
