% I09S, 2004, 09AR20041223
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

salt_offset([1:10]) = 1.0e-3 * (-0.3); %  P141 (stn 1 to 10)
salt_offset([11:16]) = 1.0e-3 * (-0.2); %  P143 (stn 10 to 16)
salt_offset([17:115]) = 1.0e-3 * (-0.5); %  P144 (rest)
