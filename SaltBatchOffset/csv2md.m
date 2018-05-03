function csv2md(inputfname, fout, second_line)
%
% Convert CSV to table in Markdown
%
fid = fopen(inputfname, 'r');
if fid < 0
    msg = ferror(fid);
    error(['csv2md: cannot open ' msg]);
end
% header
tline = fgets(fid);
if ischar(tline)
    items = textscan(tline, '%s', 16, 'Delimiter', ',');
    fprintf(fout, '| ');
    for i = 1:length(items{1})
        fprintf(fout, ' %s |', items{1}{i});
    end
    fprintf(fout, '\n');
    if nargin > 2
        fprintf(fout, second_line);
    end
end
while 1
    tline = fgets(fid);
    if ~ischar(tline)
        break;
    end
    items = textscan(tline, '%s', 16, 'Delimiter', ',');
    fprintf(fout, '| ');
    for i = 1:length(items{1})
        fprintf(fout, ' %s |', items{1}{i});
    end
    fprintf(fout, '\n');
end
fclose(fid);
end
