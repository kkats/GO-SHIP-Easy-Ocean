% A05, 1992
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:112]) = 1.0e-3 * (-0.9); % P117/P120 (29HE06_1)
% the offset for P117 is the same as that for P120
