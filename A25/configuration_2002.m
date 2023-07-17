% A25, 2002
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

% 35TH20020610
salt_offset([1:104]) = 1.0e-3 * 0.4; % P139 (cruise report P.18)
