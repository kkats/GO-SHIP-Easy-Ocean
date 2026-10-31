% I10, 1995
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

% salt_offset([1:61]) = 1.0e-3 * 0.6; % P126, 316N145_13  %% revised in 2026 update
salt_offset([1:61]) = 1.0e-3 * (-0.3); % P126 , 316N145_13
