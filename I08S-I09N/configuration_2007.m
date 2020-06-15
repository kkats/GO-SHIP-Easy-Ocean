% I08S-I09N, 2007
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:198]) = 1.0e-3 * (-0.6); % P147 (I08S & I09N) 
