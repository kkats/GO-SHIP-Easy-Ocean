% P09, 2010
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:124]) = 1.0e-3 * 0.0; % P152 (49RY20100706)
