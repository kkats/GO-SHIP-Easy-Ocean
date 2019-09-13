% P02, 1993
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

salt_offset([1:62]) = 1.0e-3 * 0.7; % P123 (492SSY9310_1)
salt_offset([63:92,95,98,100,103,106,109,111,116,119,121:124,127:144]) = 1.0e-3 * 0.0; % unknown (49K6KY9401_1)
salt_offset([93,94,96,97,99,101,102,104,105,107,108,110,112:115,117,118,120,125,126]) = 1.0e3 * 0.4; % P121 (49EWBO9401_1)
salt_offset([145:176]) = 1.0e-3 * 0.0; % unknown (492SSY9411_1)
