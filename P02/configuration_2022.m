% P02, 2022
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:241]) = 1.0e-3 * (-0.1); % P165 (33RR20020430, 33RR20020613, manual section 6.1)
