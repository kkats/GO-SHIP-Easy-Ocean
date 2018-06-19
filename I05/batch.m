[s, m] = copyfile('I05/configuration_1987.m', 'configuration.m');
if s ~= 1, error(['copyfile 1', m]); end
D_reported(1) = reported_data('I05/i05_1987.list', 'C:\Users\ka\Downloads\CTD\I05\i05_1987.mat');
[s, m] = copyfile('I05/configuration_2002.m', 'configuration.m');
if s ~= 1, error(['copyfile 2', m]); end
D_reported(2) = reported_data('I05/i05_2002.list', 'C:\Users\ka\Downloads\CTD\I05\i05_2002.mat');
[s, m] = copyfile('I05/configuration_2009.m', 'configuration.m');
if s ~= 1, error(['copyfile 3', m]); end
D_reported(3) = reported_data('I05/i05_2009.list', 'C:\Users\ka\Downloads\CTD\I05\i05_2009.mat');
save 'o/reported/I05/i05.mat' D_reported
%
reported_WHPX(D_reported(1), 'o/reported/work/i05_1987');
reported_WHPX(D_reported(2), 'o/reported/work/i05_2002');
reported_WHPX(D_reported(3), 'o/reported/work/i05_2009');
%
ll_grid = [30.3:0.1:115.4];
pr_grid = [0:10:6500];
%
[s, m] = copyfile('I05/configuration_1987.m', 'configuration.m');
if s ~= 1, error(['copyfile 4', m]); end
D_pr(1) = grid_data_pressure(D_reported(1), ll_grid, pr_grid);
[s, m] = copyfile('I05/configuration_2002.m', 'configuration.m');
if s ~= 1, error(['copyfile 5', m]); end
D_pr(2) = grid_data_pressure(D_reported(2), ll_grid, pr_grid, 'I05/i05_2002.depth');
[s, m] = copyfile('I05/configuration_2009.m', 'configuration.m');
if s ~= 1, error(['copyfile 6', m]); end
D_pr(3) = grid_data_pressure(D_reported(3), ll_grid, pr_grid, 'I05/i05_2009.depth');
save 'o/gridded/I05/i05.mat' D_pr ll_grid pr_grid;
gridded_xyz(D_pr(1), 'o/gridded/I05/i05_1992.xyz', ll_grid, pr_grid);
gridded_xyz(D_pr(2), 'o/gridded/I05/i05_2002.xyz', ll_grid, pr_grid);
gridded_xyz(D_pr(3), 'o/gridded/I05/i05_2009.xyz', ll_grid, pr_grid);
%
gridded_bin(D_pr, 'o/gridded/I05/i05.bin', ll_grid, pr_grid);
%
gridded_nc(D_pr, 'o/gridded/I05/i05.nc', ll_grid, pr_grid);
