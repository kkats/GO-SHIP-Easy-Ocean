% I05, 2000
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:142]) = 1.0e-3 * 0.0; % unknown (possibly P133/138 but not certain) (09FA20000926)
