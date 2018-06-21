% I09S, 1995
soffset_handle = @salt_offset;
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;

function so = salt_offset(k)
%
% Given station number, returns salinity offset
%
if k <= 146
    so = 1.0e-3 * 1.4; %  P128 (I09S, 316N145_5)
else
    so = 1.0e-3 * 0.0; %  unknown (I09S, 09AR9404_1)
end
end
