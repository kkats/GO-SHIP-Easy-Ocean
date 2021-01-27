% AR07W, 2011b
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset(1:116) = 1.0e-3 * 0.3; % average of P149 & P152 (06MT20110624)
