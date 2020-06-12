% variables
PREFIX='/local/Shared/';
MDIR = [PREFIX 'CTD/MATLAB/'];
DIR = 'A13/';
fname = 'a13';
years = {'1983', '2010'};
ll_grid = [-69.4:0.1:4.9];
pr_grid = [0:10:6500];
depth_files = {'', ''};

tic;

% MATLAB intermediate files
for n = 1:length(years)
    mfile = [MDIR fname '_' years{n} '.mat'];
    if ~exist(mfile)
        if n == 1
            com1 = ['read_ctd_ajax(''' PREFIX 'CTD/A13/1983/ajax_316n19831007_ctd.txt'', ''316N19831007'', ''A13/out1'');'];
            com2 = ['read_ctd_ajax(''' PREFIX 'CTD/A13/1983/ajax_316n19840111_ctd.txt'', ''316N19840111'', ''A13/out2'');'];
            addpath 'A13/';
            eval(com1);
            eval(com2);
            load 'A13/out1.mat'
            stations1 = stations; pr1 = pr; te1 = te; sa1 = sa; ox1 = ox;
            load 'A13/out2.mat'
            stations2 = stations; pr2 = pr; te2 = te; sa2 = sa; ox2 = ox;
            [i1, j1] = size(pr1);
            [i2, j2] = size(pr2);
            [pr, te, sa, ox] = deal(NaN(max(i1,i2), j1+j2));
            stations = [stations1, stations2];
            pr(1:i1,1:j1) = pr1; te(1:i1,1:j1) = te1; sa(1:i1,1:j1) = sa1; ox(1:i1,1:j1) = ox1;
            pr(1:i2,j1+1:j1+j2) = pr2; te(1:i2,j1+1:j1+j2) = te2; sa(1:i2,j1+1:j1+j2) = sa2; ox(1:i2,j1+1:j1+j2) = ox2;
            eval(['save  ''' mfile ''' stations pr te sa ox']);
            rmpath 'A13/';
        else
            com = ['read_ctd_exchange(''' PREFIX 'CTD/' DIR years{n} '/'', ''' mfile ''');'];
            eval(com);
        end
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
