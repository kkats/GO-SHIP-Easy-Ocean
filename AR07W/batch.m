% variables
PREFIX='/local/Shared/';
MDIR = [PREFIX 'CTD/MATLAB/'];
DIR = 'AR07W/';
fname = 'ar07w';
years = {'1990', '1992', '1993', '1994', '1995', '1996', '1997', '1998', ...
         '2011b', '2012', '2013a', '2013b', '2015'};
% The following data are NOT calibrated and not included by default. See README.md
%         '1999', '2001', '2002a', '2002b', '2003', '2004', ...
%         '2005', '2006', '2007', '2008', '2009', '2010', '2011a'
ll_grid = [54.9:0.1:60.6];
pr_grid = [0:10:6500];
depth_files = {'', '', '', '', '', '', '', '', '', '', '', '', '', '', ...
         '', '', '', '', '', '', '', '', '', '', '', ''};


tic;

% MATLAB intermediate files
for n = 1:length(years)
    mfile = [MDIR fname '_' years{n} '.mat'];
    if ~exist(mfile)
        if n == 10 || n == 15
            % 'borrow' AR07W/read_ctd_exchange_2000()
            com = ['addpath AR07E; read_ctd_exchange_2000(''' PREFIX 'CTD/' DIR years{n} '/'', ''' mfile '''); rmpath AR07E'];
        else
            com = ['read_ctd_exchange(''' PREFIX 'CTD/' DIR years{n} '/'', ''' mfile ''');'];
        end
        eval(com);
    end
end

% output directories
outdir = [PREFIX 'output/reported/' DIR];
if ~exist(outdir)
    if system(['mkdir ' outdir]);
        error('mkdir failed');
    end
end
outdir = [PREFIX 'output/gridded/' DIR];
if ~exist(outdir)
    if system(['mkdir ' outdir]);
        error('mkdir failed');
    end
end

% reported - MAT
for n = 1:length(years)
    com = ['[s, m] = copyfile(''' DIR 'configuration_' years{n} '.m'', ''configuration.m'');'];
    eval(com);
    if s ~= 1, error(['copyfile ' num2str(n) ':', m]); end
    if isempty(depth_files{n})
        com = ['D_reported(' num2str(n) ') = reported_data(''' DIR fname '_' years{n} '.list'',''' MDIR fname '_' years{n} '.mat'');'];
    else
        com = ['D_reported(' num2str(n) ') = reported_data(''' DIR fname '_' years{n} '.list'',''' MDIR fname '_' years{n} '.mat'', ''' depth_files{n} ''');'];
    end
    eval(com);
end
com = ['save ''' PREFIX 'output/reported/' DIR fname '.mat'' D_reported'];
eval(com);

% reported - WOCE exchange
for n = 1:length(years)
    com = ['reported_WHPX(D_reported(' num2str(n) '), ''' PREFIX 'output/reported/work/' fname '_' years{n} ''');' ];
    eval(com);
end

% gridded - MAT
for n = 1:length(years)
    disp(['gridded - MAT, ', years{n}]);
    com = ['[s, m] = copyfile(''' DIR 'configuration_' years{n} '.m'', ''configuration.m'');'];
    eval(com);
    if s ~= 1, error(['copyfile ' num2str(n) ':', m]); end
    com = ['D_pr(' num2str(n) ') = grid_data_pressure(D_reported(' num2str(n) '), ll_grid, pr_grid);'];
    eval(com);
end
com = ['save ''' PREFIX 'output/gridded/' DIR fname '.mat'' D_pr ll_grid pr_grid'];
eval (com);

% gridded - ASCII
for n = 1:length(years)
    disp(['gridded - ASCII, ', years{n}]);
    com = ['gridded_xyz(D_pr(' num2str(n) '), ''' PREFIX 'output/gridded/' DIR fname '_' years{n} '.xyz'', ll_grid, pr_grid);'];
    eval(com);
end

% gridded - binary
disp(['gridded - binary']);
com = ['gridded_bin(D_pr, ''' PREFIX 'output/gridded/' DIR fname '.bin'', ll_grid, pr_grid);'];
eval(com);

% NetCDF
%com = ['gridded_nc(D_pr, ''../output/gridded/' DIR fname '.nc'', ll_grid, pr_grid);'];
%eval(com);

toc
