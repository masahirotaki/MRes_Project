%% Freezing time Analysis
%% Load Data
cd 'C:\Users\masah\OneDrive\Documents\GitHub\MRes_Project\Bonsai\Freezing_detection'
files2import = dir('Immobility*.csv')

%% Immobility calculation (put each immobility epoch into one cell for later analysis )
immobility = cell(1,length(files2import));

for filei = 1:length(files2import)
    filename = sprintf('Immobility%d.csv',filei);
    data = xlsread(filename);
    data = data(:,1)';
    
    ii = zeros(size(data));
    jj = data > 0;
    ii(strfind([0,jj(:)'],[0 1])) = 1;
    idx = cumsum(ii).*jj;
    freeze = accumarray(idx(jj)',data(jj)',[],@(x){x'});
    immobility{filei} = freeze
    clear ii jj idx freeze
end

%% Freezing calculation by only including the epoches of immobility longer than 2 sec (60 frames)
freezetime = zeros(1,length(immobility))

for i = 1:length(immobility)
    for j = 1:length(immobility{i})
        if length(immobility{i}{j})> 60 % Only > 2 sec are included
            freezetime(i) = freezetime(i) + length(immobility{i}{j})/30;
        end
    end
end
clear i j

sprintf(['The amount of time spent freezing for CNO mice was %.2f.\n'...
    'The amount of time spent freezing for vehicle mice was %.2f.'],freezetime(1),freezetime(2))
        