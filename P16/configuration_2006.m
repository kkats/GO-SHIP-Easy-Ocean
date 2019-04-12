% P16, 2006
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

salt_offset([1:115]) = 1.0e-3 * (-0.5); % P144 (33RR200501)
salt_offset([116:199]) = 1.0e-3 * (-1.0); % P145 (325020060213)
