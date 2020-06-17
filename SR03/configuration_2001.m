% SR03 2001
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:7])   = 1.0e-3 * 0.3;     % P133 (09AR20011029)
salt_offset([8])     = 1.0e-3 * (-0.4);  % P137
salt_offset([9:12])  = 1.0e-3 * 0.0;     % unknown
salt_offset([13:28]) = 1.0e-3 * (-0.4);  % P137
salt_offset([29])    = 1.0e-3 * 0.3;     % P133
salt_offset([30:32]) = 1.0e-3 * 0.0;     % unknown
salt_offset([33:36]) = 1.0e-3 * (-0.3);  % P140
salt_offset([37:39]) = 1.0e-3 * 0.3;     % P133
salt_offset([40:82]) = 1.0e-3 * (-0.3);  % P140
salt_offset([83:108]) = 1.0e-3 * 0.3;    % P133
salt_offset([109:112]) = 1.0e-3 * (-0.3);% P140
salt_offset([113:118]) = 1.0e-3 * 0.3;   % P133
salt_offset([119:121]) = 1.0e-3 * (-0.3);% P140
salt_offset([122:128]) = 1.0e-3 * 0.3;   % P133
