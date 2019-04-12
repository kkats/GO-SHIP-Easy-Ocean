% SR03 1994a
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

salt_offset([1:85]) = 1.0e-3 * 0.7; % P123 (09AR9404_1)
salt_offset([86:107]) = 1.0e-3 * 0.4; % P121 (09AR9404_1)
