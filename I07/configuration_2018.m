% I07, 2018
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

salt_offset([1:124]) = 1.0e-3 * 0.0; % P160 (44RO20180423)
salt_offset([125:203]) = 1.0e-3 * (-0.5); % P162 (49NZ20191229)
