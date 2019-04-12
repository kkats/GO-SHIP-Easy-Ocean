% A10-A23, 2013
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

salt_offset([1:145]) = 1.0e-3 * 0.1; % P155 (33RO20130803)
salt_offset([146:258]) = 1.0e-3 * 0.6; % P154 (33RO20131223)
