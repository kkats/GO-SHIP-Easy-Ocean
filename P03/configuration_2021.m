% P03W, 2021
vinterp_handle = @vinterp_gauss;
hinterp_handle = @hinterp_bylon;
MAX_SEPARATION = 2.0;

salt_offset([1:89]) = 1.0e-3 * (-0.5); % P164 (49UP20210719, 49UP20210719_P03W_C_S1-S2_ctd02_salinity.docx, under "Bottle Salinity")
