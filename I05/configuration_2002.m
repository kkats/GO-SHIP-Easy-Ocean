% I05, 2002
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:146]) = 1.0e-3 * (-0.3); % P140 (74AB20020301)
