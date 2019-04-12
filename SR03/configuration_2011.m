% SR03 2011
vinterp_handle = @vinterp;
hinterp_handle = @hinterp;
MAX_SEPARATION = 2.0;

salt_offset([1:9])   = 1.0e-3 * (-0.4);  % P151 (09AR20110104)
salt_offset([10])    = 1.0e-3 * 0.0;     % P152
salt_offset([11:12]) = 1.0e-3 * (-0.4);  % P151
salt_offset([13:21]) = 1.0e-3 * 0.0;     % P152
salt_offset([22:25]) = 1.0e-3 * 0.7;     % P150
salt_offset([26:27]) = 1.0e-3 * 0.0;     % P152
salt_offset([28:40]) = 1.0e-3 * 0.7;     % P150
salt_offset([41:47]) = 1.0e-3 * (-0.4);  % P151
salt_offset([48:50]) = 1.0e-3 * 0.7;     % P150
salt_offset([51:52]) = 1.0e-3 * (-0.4);  % P151
salt_offset([53])    = 1.0e-3 * 0.7;     % P149
salt_offset([54])    = 1.0e-3 * (-0.4);  % P151
salt_offset([55:61]) = 1.0e-3 * 0.7;     % P149
salt_offset([62:68]) = 1.0e-3 * 0.7;     % P150
salt_offset([69:83]) = 1.0e-3 * (-0.4);  % P151
salt_offset([84:86]) = 1.0e-3 * 0.7;     % P150
salt_offset([87:99]) = 1.0e-3 * 0.7;     % P149
salt_offset([100:102]) = 1.0e-3 * 0.7;   % P150
salt_offset([103:108]) = 1.0e-3 * (-0.4);% P151
salt_offset([109:115]) = 1.0e-3 * 0.7;   % P149
salt_offset([116:140]) = 1.0e-3 * 0.0;   % P152
salt_offset([141])     = 1.0e-3 * 0.7;   % P149
salt_offset([142])     = 1.0e-3 * (-0.4);% P151
salt_offset([143])     = 1.0e-3 * 0.0;   % P152
salt_offset([144])     = 1.0e-3 * (-0.4);% P151
salt_offset([145])     = 1.0e-3 * 0.0;   % P152
salt_offset([146:149]) = 1.0e-3 * (-0.4);% P151
