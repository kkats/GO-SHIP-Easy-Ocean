% SR03 2008
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

salt_offset([1:8])   = 1.0e-3 * (-0.6);  % P147 (09AR20080322)
salt_offset([9:10])  = 1.0e-3 * 0.0;     % P148
salt_offset([11:73]) = 1.0e-3 * (-0.6);  % P147
