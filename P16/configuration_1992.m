% P16, 1992
soffset_handle = @salt_offset;
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

function so = salt_offset(k)
%
% Given station number, returns salinity offset
%
if k <= 128
    so = 1.0e-3 * (-0.9); % P120 (316N138_9)
elseif k <= 234
    so = 1.0e-3 * 2.0; % P114 (31WTTUNES_3)
elseif k <= 298
    so = 1.0e-3 * 1.9; % P110 (31DSCGC91_2)
else
    so = 1.0e-3 * 1.7; % P108 (31WTTUNES_2, station 180-220)
end
end
