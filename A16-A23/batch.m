% variables
DIR = 'A16-A23/';
BDIR = 'C:\Users\ka\Downloads\CTD\A16-A23\';
fname = 'a16-a23';
years = {'1988', '1993', '1995', '2003', '2011', '2013'}';
ll_grid = [-72.5:0.1:63.4];
pr_grid = [0:10:6500];
depth_files = {'', '', '', '', '', ''};
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
