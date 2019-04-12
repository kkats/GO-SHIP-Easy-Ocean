% P16, 2015
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

salt_offset([1:92]) = 1.0e-3 * 0.4; % P156 (320620140320)
salt_offset([93:204]) = 1.0e-3 * 0.0; % not found (33RO20150410)
salt_offset([205:306]) = 1.0e-3 * (-0.7); % P157 (33RO20150525, station 113-196) 
salt_offset([307:319]) = 1.0e-3 * 0.1; % P155 (33RO20150525, station 197-207)
