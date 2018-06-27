% I09S, 2004, 09AR20041223
soffset_handle = @salt_offset;
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;

function so = salt_offset(k)
%
% Given station number, returns salinity offset
%
if k <= 10
    so = 1.0e-3 * (-0.3); %  P141 (stn 1 to 10)
elseif k <= 16
    so = 1.0e-3 * (-0.2); %  P143 (stn 10 t 16)
end
    so = 1.0e-3 * (-0.5); %  P144 (rest)
end
