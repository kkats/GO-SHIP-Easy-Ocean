% A01, 1996
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

salt_offset([1:45]) = 1.0e-3 * 0.6; % P124 (18HU96006_1)
salt_offset([46:100]) = 1.0e-3 * 0.0; %  unknown (06AZ161_2)
