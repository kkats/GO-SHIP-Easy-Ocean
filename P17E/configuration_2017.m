% P17E, 2017
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

% salt_offset([1:24]) = 1.0e-3 * (-0.3); % P159 (Mirai,P17E. "49NZ20170208_do.pdf")  %% revised in 2026 update
salt_offset([1:24]) = 1.0e-3 * 0.3; % P159 (Mirai,P17E. "49NZ20170208_do.pdf")
