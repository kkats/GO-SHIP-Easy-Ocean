% I05, 2002
soffset_handle = @salt_offset;
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;

function so = salt_offset(k)
%
% Given station number, returns salinity offset
%
so = 1.0e-3 * (-0.3); % P140 (74AB20020301)
end
