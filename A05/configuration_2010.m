% A03, 2010
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

%salt_offset([1:135]) = 1.0e-3 * (-0.4); % P151 (74DI20100106) %% updated in 2026
salt_offset([1:135]) = 1.0e-3 * (-0.5); % P151 (74DI20100106)
