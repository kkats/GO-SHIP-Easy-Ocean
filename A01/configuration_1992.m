% A01, 1992
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

salt_offset([1:54]) = 1.0e-3 * 0.0; % P117 (18HU92014_1)
salt_offset([55:111]) = 1.0e-3 * 0.0; % P119 (06AZ129_1)
