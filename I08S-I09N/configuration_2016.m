% I08S-I09N, 2016
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:200]) = 1.0e-3 * (-0.2); % P158 (I08S & I09N)
