% A25, 1997
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

% 74DI230_1
salt_offset([1:44]) = 1.0e-3 * 1.4; % P128 (cruise report P.70, Table 7.4, Fig.7.4)
salt_offset([45:60]) = 1.0e-3 * 0.3; % P130
salt_offset([61:73]) = 1.0e-3 * 0.1; % P131
salt_offset([74:133]) = 1.0e-3 * (-0.4); % P132
