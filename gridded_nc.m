function gridded_nc(line_id,inpath,repopath,outfname)
% function gridded_nc(line_id,infname,outfname)
% Inputs:   line_id (eg, P15) as character array
%           inpath: full path to location of 'gridded' folder under which
%               will sit individual line folders with the gridded mat files (eg. '/home/work/GoShip/')
%           repopath: full path to the 'WOCE-GO-SHIP-clean-sections' folder
%               that contains all the code to build the product under each line
%               folder (eg. '/home/work/GoShip/')
%           outfname (optional): full path and file name to output the netcdf gridded
%           data to. Default is the same as inpath.
%
% Loads the gridded mat file containing D_pr structure with gridded data 
%ll_grid (lat/long grid) and pr_grid (pressure grid)
% created from grid_data_pressure.m
% Outputs gridded_data to CF compliant NETCDF format
%
% Using a template text file for easy editing of metadata attributes.
% Bec Cowley, April 2020.

% the file is created in the following order
%
% 1. global attributes
% 2. dimensions / coordinate variables
% 3. variable definitions
% 4. data

% directory in upper case, filname in lower case (as of ver.1)
SECTION = upper(line_id);
fname = lower(line_id);

narginchk(3,4);
if nargin < 4
    outfname = inpath;
end
outfname = [outfname '/gridded/' SECTION '/' fname '.nc'];

%load the input file:
try
    load([inpath '/gridded/' SECTION '/' fname '.mat'])
catch
    error(['File ' inpath '/gridded/' SECTION '/' fname '.mat does not exist'])
end

%Netcdf file creation
cmode = netcdf.getConstant('NETCDF4');
cmode = bitor(cmode,netcdf.getConstant('CLOBBER'));
fidnc = netcdf.create(outfname, cmode);
if fidnc == -1, error(['Could not create ' filename]); end

% we don't want the API to automatically pre-fill with FillValue, we're
% taking care of it ourselves and avoid 2 times writting on disk
netcdf.setFill(fidnc, 'NOFILL');

%% get the global attributes template:
globalatts = parseNCTemplate('global_attributes_gridded.txt');

%populate empty fields where we can:
%list of fields
flds = fieldnames(globalatts);

%add the line name to the end of the text
%handle the 'goship_woce_line_id' here also
globalatts.title = [globalatts.title ' ' line_id];
globalatts.goship_woce_line_id = line_id;
%'date_issued'
globalatts.date_issued = datestr(now,'yyyymmdd');
%'source_file'
%put the expocode file names here with full web links from
%README.MD file for the line
%double quotes(?), separated by commas
pth = [repopath '/GO-SHIP-Easy-Ocean/' SECTION '/README.md'];
fid = fopen(pth,'r');
if fid < 1
    error(['Path to repo for ' line_id ', ' pth ' is incorrect'])
end
c = textscan(fid,'%s','delimiter','|');
fclose(fid);
c = c{:};
%get the http references:
ii = find(cellfun(@isempty,strfind(c,'http'))==0);
expocode = [];weblink = [];
for b = 1:length(ii)
    str = c{ii(b)};
    [tokens,matches] =regexp(str,'+ [(\w*).*((\https:[/\w*/\.]+))','tokens','match');
    if b == 1
        expocode = tokens{1}{1};
        weblink = tokens{1}{2};
    else
        expocode = [expocode ',' tokens{1}{1}];
        weblink = [weblink ',' tokens{1}{2}];
    end
end
globalatts.source_file = weblink;
globalatts.expocode = expocode;
%'goship_woce_line_id'
%input into function
globalatts.goship_woce_line_id = line_id;
% 'geospatial_bounds'
%also handle all the geospatial* etc here
%get the raw data:
m = length(D_pr);
for b = 1:length(D_pr)
    n(b) = length(D_pr(b).Station);
end
lat = NaN*ones(m,max(n));lon = lat; ti = lat;
for b = 1:length(D_pr)
    for c = 1:length(D_pr(b).Station)
        lat(b,c) = D_pr(b).Station{c}.Lat;
        lon(b,c) = D_pr(b).Station{c}.Lon;
        ti(b,c) = D_pr(b).Station{c}.Time;
    end
end

%include the years used in the global attributes:
tt = ti(~isnan(ti));
globalatts.all_years_used = ['Data from years ' num2str(unique(str2num(datestr(tt,'yyyy')))') ' was used to create this product'];
%is the ll_grid latitude or longitude?
[latm,latn] = range(lat);
[lm,ln] = range(ll_grid);
[lonm,lonn] = range(lon);
dmax = [abs(lm - latm),abs(lm - lonm)];

ilatlon = find(min(dmax));
if ilatlon == 1 %ll_grid is along latitude
    %create a longitude grid to match:
    lat_grid = ll_grid;
    lon_grid = mean(nanmean(lon));
else %ll_grid is along longitude
    %create a latitude grid to match:
    lon_grid = ll_grid;
    lat_grid = mean(nanmean(lat));
end

%assign the global attributes:
globalatts.geospatial_lat_min = min(lat_grid);
globalatts.geospatial_lat_max = max(lat_grid);
globalatts.geospatial_lon_min = min(lon_grid);
globalatts.geospatial_lon_max = max(lon_grid);
globalatts.geospatial_vertical_min = min(pr_grid);
globalatts.geospatial_vertical_max = max(pr_grid);
%also handle the other time* fields here
globalatts.time_coverage_start = datestr(min(min(ti)),'dd-mm-yyyy HH:MM:SS');
globalatts.time_coverage_end = datestr(max(max(ti)),'dd-mm-yyyy HH:MM:SS');

%write out global attributes:
vid = netcdf.getConstant('NC_GLOBAL'); %get the global attributes reference
flds = fieldnames(globalatts);
for a = 1:length(flds)
    name = flds{a};
    netcdf.putAtt(fidnc, vid, name, globalatts.(flds{a}));
end
%% get the dimension attributes templates, using pressure, longitude,
%dimensions
%set up the section data:
sect = 1:length(D_pr);

dimnames = {'gridded_section','longitude','latitude','pressure'};
dimdata = {'sect','lon_grid','lat_grid','pr_grid'};

sectatts = parseNCTemplate('section_attributes_gridded.txt');
pr_gridatts = parseNCTemplate('pressure_attributes_gridded.txt');
lon_gridatts = parseNCTemplate('longitude_attributes.txt');
lat_gridatts = parseNCTemplate('latitude_attributes.txt');

for m=1:length(dimnames)
    eval(['data = ' dimdata{m} ';']);
    % create dimension
    did(m) = netcdf.defDim(fidnc, dimnames{m}, length(data));
    % create coordinate variable and attributes
    eval(['atts = ' dimdata{m} 'atts;']);
    vid(m) = netcdf.defVar(fidnc, dimnames{m}, 'NC_DOUBLE', did(m));
    fldn = fieldnames(atts);
    for b = 1:length(fldn)
        netcdf.putAtt(fidnc,vid(m),fldn{b},atts.(fldn{b}))
    end
end
%% now for each variables attributes, DOXY, TEMP, PSAL, CONSERVATIVE TEMP, ABSOLUTE SALINITY 

%populate for each one:
varname = {'time','temperature','practical_salinity','oxygen','conservative_temperature','absolute_salinity'};
dataname = {'NTime','CTDtem','CTDsal','CTDoxy','CTDCT','CTDSA'};
stdn = {'time','sea_water_temperature','sea_water_practical_salinity',...
    'moles_of_oxygen_per_unit_mass_in_sea_water','seawater_conservative_temperature',...
    'sea_water_absolute_salinity'};
whpname = {'TIME','CTDTMP','CTDSAL','CTDOXY','CTDCT','CTDSA'}; 
units = {'days since 1950-01-01 00:00:00 UTC','degC','1','degC','umol kg-1','g kg-1'}; 
refscale = {'','IPTS-68','PSS-78','','',''};
vmin = [min(min(ti)),-2.5,2.0,-5.0,-2.5,0];
vmax = [max(max(ti)),40.0,41.0,600,40.0,42.0];

for a = 1:length(stdn)
%     varatts = parseNCTemplate('variable_attributes_gridded.txt');
    varatts.standard_name = stdn{a};
    varatts.units = units{a};
    varatts.valid_min = vmin(a);
    varatts.valid_max = vmax(a);    
    varatts.reference_scale = refscale{a};
    varatts.whp_name = whpname{a};
    if ilatlon == 1 & a == 1 %our time variable
        didv = did([1,3]);
    elseif ilatlon == 0 & a == 1
        didv = did([1,1]);
    else %other variables
        didv = did;
    end
    
    %create the variable:
    if a == 1
        vidv(a) = netcdf.defVar(fidnc,varname{a},'NC_DOUBLE',didv);
    else
        vidv(a) = netcdf.defVar(fidnc,varname{a},'NC_DOUBLE',didv);
    end
    fldn = fieldnames(varatts);
    %now write out the variable atts:
    for b = 1:length(fldn)
        name = fldn{b};
        if strcmpi(name, 'FillValue')
            netcdf.defVarFill(fidnc, vidv(a), false, NaN); % false means noFillMode == false
        else
            netcdf.putAtt(fidnc, vidv(a), name, varatts.(fldn{b}));
        end
    end
end
% we're finished defining dimensions/attributes/variables
netcdf.endDef(fidnc);

%% Now the data
% dimension data
for a = 1:length(dimnames)
    eval(['data = ' dimdata{a} ';']);
    netcdf.putVar(fidnc, vid(a), data);
end

%variable data
for a = 1:length(varname)
    %construct matrix for each section:
    if a == 1
        data = NaN*ones(length(sect),length(ll_grid));
    else
        data = NaN*ones(length(sect),length(lon_grid),length(lat_grid),length(pr_grid));
    end
    for b = 1:length(sect)
        eval(['dat = D_pr(b).' dataname{a} ';']);
        if a == 1
            dat = round(dat - datenum('1950-01-01 00:00:00'));
            data(b,:) = dat;
        else
            if ilatlon == 1%longitude is single value
                data(b,1,:,:) = dat';
            else %latitude is single value
                data(b,:,1,:) = dat';
            end
        end
    end

    netcdf.putVar(fidnc, vidv(a), data);
end
netcdf.close(fidnc)
end
