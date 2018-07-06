% P16, 2006
soffset_handle = @salt_offset;
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

function so = salt_offset(k)
%
% Given station number, returns salinity offset
%
if k <= 84
    so = 1.0e-3 * (-1.0); % P145 (325020060213)
else
    so = 1.0e-3 * (-0.5); % P144 (33RR200501)
end
end
