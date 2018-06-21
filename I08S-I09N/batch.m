% variables
DIR = 'I08S-I09N/';
BDIR = 'C:\Users\ka\Downloads\CTD\I08S-I09N\';
fname = 'i08s-i09n';
years = {'1995', '2007', '2016'};
ll_grid = [-65.9:0.1:19.8];
pr_grid = [0:10:6500];
depth_files = {'I08S-I09N/i08s-i09n_1995.depth', '', ''};
%

tic;
for n = 1:length(years)
    com = ['[s, m] = copyfile(''' DIR 'configuration_' years{n} '.m'', ''configuration.m'');'];
    eval(com);
    if s ~= 1, error(['copyfile ' num2str(n) ':', m]); end
    com = ['D_reported(' num2str(n) ') = reported_data(''' DIR fname '_' years{n} '.list'',''' BDIR fname '_' years{n} '.mat'');'];
    eval(com);
end
com = ['save ''output/reported/' DIR fname '.mat'' D_reported'];
eval(com);
%
for n = 1:length(years)
    com = ['reported_WHPX(D_reported(' num2str(n) '), ''output/reported/work/' fname '_' years{n} ''');' ];
    eval(com);
end
%
for n = 1:length(years)
    com = ['[s, m] = copyfile(''' DIR 'configuration_' years{n} '.m'', ''configuration.m'');'];
    eval(com);
    if s ~= 1, error(['copyfile ' num2str(n) ':', m]); end
    if isempty(depth_files{n})
        com = ['D_pr(' num2str(n) ') = grid_data_pressure(D_reported(' num2str(n) '), ll_grid, pr_grid);'];
    else
        com = ['D_pr(' num2str(n) ') = grid_data_pressure(D_reported(' num2str(n) '), ll_grid, pr_grid, ''' depth_files{n} ''');'];
    end
    eval(com);
end
com = ['save ''output/gridded/' DIR fname '.mat'' D_pr ll_grid pr_grid'];
eval (com);
%
for n = 1:length(years)
    com = ['gridded_xyz(D_pr(' num2str(n) '), ''output/gridded/' DIR fname '_' years{n} '.xyz'', ll_grid, pr_grid);'];
    eval(com);
end
%
com = ['gridded_bin(D_pr, ''output/gridded/' DIR fname '.bin'', ll_grid, pr_grid);'];
eval(com);
%
com = ['gridded_nc(D_pr, ''output/gridded/' DIR fname '.nc'', ll_grid, pr_grid);'];
eval(com);
toc
