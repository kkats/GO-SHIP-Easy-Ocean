function lowpass = filtend(series, filtlen, type)
%
% function lowpass = filtend(series, filtlen, type)
%
% filters a series with a filter of filtlen points. (a half-width 
% of (filtlen+1)/2 for a hanning filter). The ends are taken
% care of by extending the time series out as seen in a "mirror"
% at either end, convolving the data with the filter, 
% and then truncating the resulting series to its original length.  
% The optional argument 'type' default is hanning but can also be 
% boxcar, bartlett, blackman, hamming, or triang.  Note that 
% filtlen is made an odd integer if is not already.  
%
% Gregory C. Johnson, Modified October 23, 1998
%
% K. Katsumata Modified 24 April 2018
%

% reorder the series to a column vector

series = series(:);

% find the length of the series and filter
% make the filter length an odd integer at least unity

filtlen = max(1, 2 * ceil(filtlen / 2) - 1);
len = length(series);

% construct filter
if nargin == 3
    str=['fil=', type, '(', int2str(filtlen),') / sum(', type, '(', int2str(filtlen), '));'];
    eval(str);
else
    fil = hanning(filtlen) / sum(hanning(filtlen));
end

% extend the series at both ends
% by its mirror image

half = round((filtlen + 1) / 2);
top = series(half+1:-1:2);
bb = max(size(series));
bot = series(bb-1:-1:bb-1-half);
r = [top; series; bot];

% convolve the filter and the series

rr = conv(r, fil);

% truncate the result to the original series length

%lowpass = rr(filtlen+(filtlen-1)/2+1:bb+filtlen+(filtlen-1)/2);
lowpass = rr(filtlen+1:length(rr)-filtlen-1);
end
%
% In case you do not have Signal Procesing Toolbox
%
function h = hanning(n)
    nn = [0:(n-1)];
    h = (sin(pi * nn / (n-1))).^2;
end
