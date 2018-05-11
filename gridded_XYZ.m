function gridded_XYZ(gd, fname, ll_grid, pr_grid)
%
% Output reported_data (`gd`) to GMT readable xyz file `fname`
%
fid = fopen(fname, 'w');
if fid < 0
    error(['gridded_XYZ.m: cannot open ' fname]);
end

fprintf(fid, '# Lat/Lon   CTDPRS  CTDTMP     CTDSAL     CTDOXY      CTDCT      CTDSA\n');
fprintf(fid, '# DEG       DBAR    IPTS-68    PSS-78     UMOL/KG     ITS-90     G/KG\n');
for n = 1:length(ll_grid)
    % number of good data
    ig = find(isfinite(gd.CTDtem(:,n)) ...
            | isfinite(gd.CTDsal(:,n)) | isfinite(gd.CTDoxy(:,n)) ...
            | isfinite(gd.CTDCT(:,n)) | isfinite(gd.CTDSA(:,n)));
    m = max(ig);
    if m <= 1
        continue;
    end
    for i = 1:length(pr_grid)
        prs = pr_grid(i); tem = gd.CTDtem(i,n); sal = gd.CTDsal(i,n);
        oxy = gd.CTDoxy(i,n); CT = gd.CTDCT(i,n); SA = gd.CTDSA(i,n);
        fprintf(fid, '%.4f', ll_grid(n));
        print_num(fid, '%10.1f', '%10d', prs);
        print_num(fid, '%11.4f', '%11d', tem);
        print_num(fid, '%11.4f', '%11d', sal);
        print_num(fid, '%11.4f', '%11d', oxy);
        print_num(fid, '%12.4f', '%12d', CT);
        print_num(fid, '%12.4f', '%12d', SA);
        fprintf(fid, '\n');
    end
end % for n = 1:
fclose(fid);
end
function print_num(fi, goodform, badform, x)
%
% print according to format
%
if isfinite(x)
    fprintf(fi, goodform, x);
else
    fprintf(fi, badform, -999);
end
end
