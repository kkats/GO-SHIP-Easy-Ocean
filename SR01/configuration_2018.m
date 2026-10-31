% SR01 2018
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

% salt_offset([1:71]) = 1.0e-3 * 0.0; % P160 (74JC20181103)  %% revised in 2026 update
salt_offset([1:71]) = 1.0e-3 * 0.7; % P160 (74JC20181103)
