% I08S-I09N, 2024
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:189]) = 1.0e-3 * (-0.1); % P167 (325020240221i, 325020250321)
