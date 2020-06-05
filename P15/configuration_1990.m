% P15, 1990
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:109]) = 1.0e-3 * 1.9; % P112, 3175CG90_1/3175CG90_2
salt_offset([110:283]) = 1.0e-3 * 0.4; % P121, 18DD9403_1/18DD9403_2
salt_offset([284:462]) = 1.0e-3 * 2.0; % P114, 31DSCG96_1/31DECG96_2
