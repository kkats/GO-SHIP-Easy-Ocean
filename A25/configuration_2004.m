% A25, 2004
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

% 35TH20040604
salt_offset([1:119]) = 1.0e-3 * 0.4; % P139 (cruise report P.22)
