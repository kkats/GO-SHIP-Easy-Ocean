% A25, 2010
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

% 35TH20100608
% salt_offset([1:110]) = 1.0e-3 * 0.7; % P150 (cruise report P.25)  %% revised in 2026 update
salt_offset([1:110]) = 1.0e-3 * 0.6; % P150 (cruise report P.25)
