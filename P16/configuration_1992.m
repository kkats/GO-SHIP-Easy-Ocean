% P16, 1992
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

salt_offset([1:64]) = 1.0e-3 * 1.9; % P110 (31DSCGC91_2)
salt_offset([65:161]) = 1.0e-3 * 1.7; % P108 (31WTTUNES_2, station 180-220)
salt_offset([162:267]) = 1.0e-3 * 2.0; % P114 (31WTTUNES_3)
salt_offset([268:395]) = 1.0e-3 * (-0.9); % P120 (316N138_9)
