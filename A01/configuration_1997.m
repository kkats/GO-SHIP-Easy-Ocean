% A01, 1997
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:130]) = 1.0e-3 * 0.4; % P129 (18HU97009_1)
salt_offset([131:165]) = 1.0e-3 * 0.4; % P129 (06MT39_5)
