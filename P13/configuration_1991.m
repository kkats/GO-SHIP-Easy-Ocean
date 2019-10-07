% P13, 1991
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

salt_offset([1:72]) = 1.0e-3 * 1.95; % P112 or P114, 49HH915_1/2
salt_offset([73:94]) = 1.0e-3 * 2.0; % P114, 49HH932_1
