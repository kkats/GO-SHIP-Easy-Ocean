% A01, 1995
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

salt_offset([1:42,44:48,50,52,56,59,61,63,65,67]) = 1.0e-3 * 0.0; % unknown (06AZ152)
salt_offset([43,49,51,53:55,57,58,60,62,64,66,68:119]) = 1.0e-3 * 0.6; % P126 (18HU95011_1)
