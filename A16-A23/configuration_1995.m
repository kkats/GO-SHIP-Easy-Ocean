% A10-A23, 1995
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

salt_offset([1:128]) = 1.0e-3 * 0.0; % unknown (74JC10_1)
salt_offset([129:268]) = 1.0e-3 * 0.3; % P133 (74JCDI233_1)
