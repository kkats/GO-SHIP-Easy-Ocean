% I08S-I09N, 1995
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylat;
MAX_SEPARATION = 2.0;

%
% Given station number, returns salinity offset
%
salt_offset([1:146]) = 1.0e-3 * 1.4; %  P128 (I08S, 316N145_5)
salt_offset([147:276]) = 1.0e-3 * 0.6; %  P126 (I09N, 316N145_6)
