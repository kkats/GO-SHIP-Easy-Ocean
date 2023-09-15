% P09, 2022
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:93]) = 1.0e-3 * (-0.1); % P165 (49UP20220727, personal communication but to be documented soon).
