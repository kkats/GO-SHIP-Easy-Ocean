% SR03 2008
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

% salt_offset([1:8])   = 1.0e-3 * (-0.6);  % P147 (09AR20080322)  %% revised in 2026 update
salt_offset([1:8]) = 1.0e-3 * (-0.9); % P147 (09AR20080322)
% salt_offset([9:10])  = 1.0e-3 * 0.0;     % P148 % revised in 2026 update
salt_offset([9:10]) = 1.0e-3 * (-0.3); % P148 
% salt_offset([11:73]) = 1.0e-3 * (-0.6);  % P147 % revised in 2026 update
salt_offset([11:73]) = 1.0e-3 * (-0.9); % P147 
