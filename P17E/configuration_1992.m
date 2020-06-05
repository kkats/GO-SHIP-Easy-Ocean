% P17E, 1992
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:106]) = 1.0e-3 * (-0.9); % P120 (KNORR, P16/P17E. "p17edo.pdf")
