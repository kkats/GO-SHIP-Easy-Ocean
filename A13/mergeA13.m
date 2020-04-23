load 'A13/out1.mat'
stations1 = stations;
pr1 = pr; te1 = te; sa1 = sa; ox1 = ox;
load 'A13/out2.mat'
stations2 = stations;
pr2 = pr; te2 = te; sa2 = sa; ox2 = ox;
[i1, j1] = size(pr1);
[i2, j2] = size(pr2);
[pr, te, sa, ox] = deal(NaN(max(i1,i2), j1+j2));
stations = [stations1, stations2];
pr(1:i1,1:j1) = pr1; te(1:i1,1:j1) = te1; sa(1:i1,1:j1) = sa1; ox(1:i1,1:j1) = ox1;
pr(1:i2,j1+1:j1+j2) = pr2; te(1:i2,j1+1:j1+j2) = te2; sa(1:i2,j1+1:j1+j2) = sa2; ox(1:i2,j1+1:j1+j2) = ox2;
save '../CTD/A13/a13_1983.mat' stations pr te sa ox
