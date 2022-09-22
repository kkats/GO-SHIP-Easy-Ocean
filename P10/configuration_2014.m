% P10, 2014
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:111]) = 1.0e-3 * 0.4; % P156 (49UP20140609)
