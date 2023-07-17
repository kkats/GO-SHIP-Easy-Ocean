% A25, 2006
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

% 06MM20060523
salt_offset([1:120]) = 1.0e-3 * (-1.5); % P146 (cruise report P.14)
