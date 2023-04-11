function D_reported = fromGLODAP(fname_list, param)
%
% Given edited station list `fname_list`
% extract from GLODAPv2 a reported data structure
%
% `param` is one of
%
% aou, c13, c14, ccl4, cfc11, cfc113, cfc11, cfc12, chla, doc, doi, don, ...
% fco2, fco2temp, gamma, h3, he, he3, neon, nitrate, nitrite, o18, oxygen, ...
% pccl, pcfc11, pcfc113, pcfc12, phosphate, phts25p0, phtsinsitutp, ...
% psf6, sf6, sigma0, sigma1, sigma2, sigma3, sigma4, silicate, ...
% talk, tco2, tdn, theta, toc
%
% Note: output includes _pressure_ and `param`
%
% Algorithm:
%
% Read a list file (1st argument of the function) for EasyOcean. For each EXPOCODE on the list,
% extract from GLODAPv2 those data satisfying the following conditions;
% 1. Identical first 4 characters of EXPOCODE (usually country (2 chars) + ship (2 chars))
% 2. Identical year
% put the data into `candidate[]`
%
% From `candidate[]`, go through the list file (again, 1st argument of the function) for EasyOcean
% and for each station, extract those data satisfying the following conditions;
% 3. Identical month and day
% 4. Longitude and latitude within 0.01 degrees
% (optional) 5. Depth within 200 m difference
% put the data into `good[]`.
%
% The data is reformatted to EasyOcean's `reported` structure for output.
%
%

% GLODAPv2 for Matlab
load '/local/data/GLODAPv2/GLODAPv2.2022_Merged_Master_File.mat';

fid = fopen(fname_list, 'r');
if fid < 0
    error(['fromGLODAP: cannot find list file(', fname_list, ')']);
end
[lons, lats, years, months, days, times, depths, expos] = deal([]);
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    if tline(1) == '%' || tline(1) == '#'
        continue;
    end
    c = textscan(tline, '%d %s %f %f %s %s %d %s %d');
    lats = [cell2mat(c(3)); lats];
    lons = [cell2mat(c(4)); lons];
    date = cell2mat(c{5});
    years = [str2num(date(end-3:end)); years];
    months = [str2num(date(1:2)); months];
    days = [str2num(date(4:5)); days];
    times = [cell2mat(c{6}); times];
    depths = [cell2mat(c(7)); depths];
    expos = [c{8}; expos];
end
fclose(fid);
candidate = []; % GLODAP data on the same ship in the same year
expolist = unique(expos);
yearlist = unique(years);
for i = 1:length(expolist)
    ex = expolist{i};
    for j = 1:size(G2expocode, 1)
        % first 4 character of expocode and year match
        if strncmp(G2expocode(j,:), ex, 4) && ismember(G2year(j), yearlist)
            candidate = [j; candidate];
        end
    end
end
good = zeros(length(lons), 256);
% assuming length(candidate) > length(lons)
nbotmax = -99;
for n = 1:length(lons)
    nbottle = 1;
    % same month, same day
    ig = find(G2month(candidate) == months(n) & G2day(candidate) == days(n));
    for i = 1:length(ig)
        j = candidate(ig(i));
        if G2longitude(j) < 0
            glon = G2longitude(j) + 360;
        else
            glon = G2longitude(j);
        end
        % within 0.01 degree location, depth difference less than 100 m
        if abs(lons(n) - glon) < 0.01 && abs(lats(n) - G2latitude(j)) < 0.01
           %
           % uncomment to check depth
           %
           % && abs(depths(n) - G2bottomdepth(j)) < 200
           %
            good(n, nbottle) = j;
            nbottle = nbottle + 1;
            if nbottle > 256
                error('more than 256 bottles at one station');
            end
        end
    end
    if nbotmax < nbottle - 1
        nbotmax = nbottle - 1;
    end
end
good(:, [nbotmax+1:end]) = [];
%
addpath '../';
[idx, dummy1, dummy2] = sort_stations(lons, lats);
rmpath '../';

[data, pressure] = deal(NaN(nbotmax, length(lons)));
[SA, CT] = deal(NaN(nbotmax, length(lons)));
[latlist, lonlist, deplist] = deal(NaN(1, length(lons)));
stationlist = cell(length(lons),1);
paramU = upper(param);
for i = 1:length(idx)
    k = idx(i);
    jdx = unique(good(k,:)); % unique() for possible duplicates
    kdx = jdx(find(jdx > 0));
    lat1 = extract(G2latitude, kdx, 0.02);
    lon1 = extract(G2longitude, kdx, 0.02);
    dep1 = extract(G2bottomdepth, kdx, 100);
    expo1 = extractexact(G2expocode, kdx);
    stn1 = extractexact(G2station, kdx);
    % sometimes multiple casts are incorporated in one station.
    % no check performed w.r.t. date and time
    datetime = zeros(length(kdx), 1);
    for o = 1:length(kdx)
        datetime(o) = datenum(G2year(kdx(o)), G2month(kdx(o)), G2day(kdx(o)), ...
                              G2hour(kdx(o)), G2minute(kdx(o)), 0);
    end
    station1 = struct('EXPO', expo1, ...
                      'Stnnbr', num2str(stn1), ...
                      'Cast', -9, ...
                      'Lat', lat1, ...
                      'Lon', lon1, ...
                      'Time', mean(datetime), ...
                      'Depth', dep1);
    latlist(i) = lat1;
    lonlist(i) = lon1;
    deplist(i) = dep1;
    stationlist{i} = station1;
    pres1 = G2pressure(kdx);
    salt1 = G2salinity(kdx); saltf = G2salinityf(kdx);
    salt1(saltf ~= 2) = NaN;
    temp1 = G2temperature(kdx);
    if strncmp(paramU, 'AOU', 3)
        data1 = G2aou(kdx); flag1 = G2aouf(kdx);
    elseif strncmp(paramU, 'OXYGEN', 6)
        data1 = G2oxygen(kdx); flag1 = G2oxygenf(kdx);
    elseif strncmp(paramU, 'CFC11', 5)
        data1 = G2cfc11(kdx); flag1 = G2cfc11f(kdx);
    elseif strncmp(paramU, 'CFC12', 5)
        data1 = G2cfc12(kdx); flag1 = G2cfc12f(kdx);
    elseif strncmp(paramU, 'CFC113', 6)
        data1 = G2cfc113(kdx); flag1 = G2cfc113f(kdx);
    elseif strncmp(paramU, 'SF6', 3)
        data1 = G2sf6(kdx); flag1 = G2sf6f(kdx);
    elseif strncmp(paramU, 'NITRATE', 7)
        data1 = G2nitrate(kdx); flag1 = G2nitratef(kdx);
    elseif strncmp(paramU, 'NITRITE', 7)
        data1 = G2nitrite(kdx); flag1 = G2nitritef(kdx);
    elseif strncmp(paramU, 'SILICATE', 8)
        data1 = G2silicate(kdx); flag1 = G2silicatef(kdx);
    elseif strncmp(paramU, 'PHOSPHATE', 9)
        data1 = G2phosphate(kdx); flag1 = G2phosphatef(kdx);
    else
        error('not implemented yet');
    end
    %
    % Only data with flag=2 are used. See Olsen et al. (2016).
    %
    data1(flag1 ~= 2) = NaN;
    %
    %
    ig = find(~isnan(pres1) & ~isnan(data1));
    [ih, ldx] = sort(pres1(ig));
    nb = length(ih);
    pressure(1:nb, i) = pres1(ig(ldx));
    data(1:nb, i) = data1(ig(ldx));
    salt = salt1(ig(ldx));
    temp = temp1(ig(ldx));
    % (t, s) to (CT, SA)
    [SA(1:nb,i), in_ocean] = gsw_SA_from_SP(salt, pressure(1:nb,i), lon1, lat1);
    if any (in_ocean < 1)
        error('fromGLODAP.m: gsw_SA_form_SP, in_ocean == 0');
    end
    CT(1:nb,i) = gsw_CT_from_t(SA(1:nb,i), temp, pressure(1:nb,i));
end

D_reported = struct('Station', {stationlist}, ...
                    'latlist', latlist, ...
                    'lonlist', lonlist, ...
                    'deplist', deplist, ...
                    'pressure', pressure, ...
                    'CT', CT, ...
                    'SA', SA, ...
                    'data', data);
end
% exact equality
function v1 = extractexact(variable, indices)
    if isempty(indices)
        v1 = NaN;
    else
        if ndims(variable) == 2
            v1 = variable(indices(1),:);
            for i = 2:length(indices)
                if v1 ~= variable(indices(i),:)
                    error('Inconsist 2');
                end
            end
        else
            v1 = variable(indices(1));
            for i = 2:length(indices)
                if v1 ~= variable(indices(i))
                    error('Inconsist 1');
                end
            end
        end
    end
end
% with error for numerical values
function v1 = extract(variable, indices, err)
    if isempty(indices)
        v1 = NaN;
    else
        v1 = variable(indices(1));
        for i = 2:length(indices)
            if abs(v1 - variable(indices(i))) > err
                error('inconsist');
            end
        end
    end
end

