% A05, 2004
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:6]) = 1.0e-3 * (-0.2); % P143 (90CT40_1) stations 1-7
salt_offset([7:124]) = 1.0e-3 * (-0.5); % P144 (90CT40_1) stations 8-
