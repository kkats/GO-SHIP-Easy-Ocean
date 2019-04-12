% SR03 1994b
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

salt_offset([1:79]) = 1.0e-3 * 0.7; % P123 (09AR9407_1)
salt_offset([80:102]) = 1.0e-3 * 0.4; % P121 (09AR9404_1)
