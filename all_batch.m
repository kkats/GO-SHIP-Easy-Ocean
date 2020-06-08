%
% do all sections
%
A = {'A01', 'A02', 'A03', 'A05', 'A10', 'A12', 'A13', 'A16-A23', 'A20', 'A22'};
I = {'I01', 'I02', 'I03-I04', 'I05', 'I06S', 'I07', 'I08N', 'I08S-I09N', 'I09S', 'I10', 'IR06', 'IR06E', 'IR06-I10'};
P = {'P01', 'P02', 'P03', 'P04', 'P06', 'P09', 'P10', 'P11', 'P13', 'P14', 'P15', 'P16', 'P17', 'P17E', 'P18', 'P21'};
S = {'S04I', 'S04P', 'SR01', 'SR03', 'SR04'};
SECTIONS = [A, I, P, S];
for n = 1:length(SECTIONS)
    clearvars -except n SECTIONS;
    sec = SECTIONS{n};
    com = ['[s, m] = copyfile(''' sec '/batch.m'', ''batch.m'');'];
    eval(com);
    if s ~= 1, error(['copyfile ' num2str(n) ':', m]); end
    com = ['[s, m] = copyfile(''' sec '/batch.sh'', ''batch.sh'');'];
    eval(com);
    if s ~= 1, error(['copyfile ' num2str(n) ':', m]); end
    system(['touch /local/Shared/output/reported/work/LOCK']);
    batch
    system('./batch.sh');
    % wait for subshells
    while (exist(['/local/Shared/output/reported/work/LOCK'], 'file'))
        system('sleep 10');
    end
end
