% A01, 1994
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

salt_offset([1:3,8:14,16,18:57,59,61,62]) = 1.0e-3 * 0.7; % P123 (18HU94008_1)
salt_offset([63:120]) = 1.0e-3 * 0.6; % P124 (06MT30_3)
salt_offset([4:7,15,17,58,60]) = 1.0e-3 * 0.0; % unknown (06AZ144)
