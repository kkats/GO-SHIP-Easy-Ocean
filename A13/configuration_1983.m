% A13, 1983
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

% 316N19831007/316N19840111
salt_offset([1:59]) = 1.0e-3 * 0.0; % P90 (offset not determined)
salt_offset([60:116]) = 1.0e-3 * (-0.2); % P92
salt_offset([61:137]) = 1.0e-3 * 0.0; % P90 (offset not teremined)
