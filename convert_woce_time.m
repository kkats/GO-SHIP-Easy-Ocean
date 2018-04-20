function mtime = parse_woce_time(w_date, w_time, flag)
%
% parse WOCE date (as INT, e.g. 19920516) and WOCE time (also as INT, e.g., 1926)
% and convert to matlab time
%
% Default is 'yyyymmdd' for w_date, but when `flag' exists
% 'ddmmyy' is expected.
%
wd = double(w_date);
wt = double(w_time);
if nargin < 3
    y = floor(wd / 10000);
    m = floor((wd - y * 10000) / 100);
    d = wd - y * 10000 - m * 100;
else
    d = floor(wd / 10000);
    m = floor((wd - d * 10000) / 100);
    y = wd - d * 10000 - m * 100;

    if y < 50
        y = y + 2000;
    else
        y = y + 1900;
    end
end
h = fix(wt / 100);
n = wt - h * 100;
mtime = datenum(y, m, d, h, n, 0);
end
