% Precipitation in past and merging


clear;
% Site: EucFACE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load input data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Inputs:
% ! I still need rain and daytime vector for the analysis

% Load raw data (.csv file)
% Location of raw input file
source_Euc = 'Input\Input EucFACE\Rsoil_env_AR.csv';
% Create datastore to access collection of data
ds_Euc = datastore(source_Euc);
% Select variable of interest
ds_Euc.SelectedVariableNames = {'datetime','Rsoil','collar','ring','RsoilCV','Tsoil','VWC','daytime'}; 
% Read selected variables, save it in the workspace as a table
Euc_Data = readall(ds_Euc);
% Get data from the table, change format if necessary
DateTime_Euc = Euc_Data.datetime; DateTime_Euc = datetime(DateTime_Euc,'InputFormat','dd/MM/yyyy HH:mm');
Rsoil_Euc = Euc_Data.Rsoil;
Collar_Euc = Euc_Data.collar;
Ring_Euc = Euc_Data.ring;
RsoilCV_Euc = Euc_Data.RsoilCV;
Tsoil_Euc = Euc_Data.Tsoil;
VWC_Euc = Euc_Data.VWC;
daytime_Euc = Euc_Data.daytime;
% clear unused variables
clearvars Euc_Data ds_Euc source_Euc; 


% Load raw data (.csv file)
% Location of raw input file
source_PEuc = 'Input\Input EucFACE\FACELawn_FACE_Rain_20122017.csv';
ds_PEuc = datastore(source_PEuc);
% Select variable of interest
ds_PEuc.SelectedVariableNames = {'Date','Time','Rain_mm_Tot_sum'};
% Read selected variables, save it in the workspace as a table
PEuc_Data = readall(ds_PEuc);
Date_PEuc = PEuc_Data.Date; Date_PEuc = datetime(Date_PEuc,'InputFormat','dd/MM/yyyy');
Time_PEuc = PEuc_Data.Time; Time_PEuc = datetime(Time_PEuc,'InputFormat','HH:mm:ss');
DateTime_rain_Euc = Date_PEuc + timeofday(Time_PEuc);
Rain_Euc = PEuc_Data.Rain_mm_Tot_sum;
% clear unused variables
clearvars PEuc_Data ds_PEuc source_PEuc Date_PEuc Time_PEuc; 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Data processing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rain in the past 12 hour

% filter after rain event
% Rain in the past 2 days, 1 day and 12 hour
n = length(Rain_Euc);
Precip_2daysago = NaN(n,1); % 96 half-hour (2 days)
Precip_1daysago = NaN(n,1); % 48 half-hour (1 day)
Precip_halfdayago = NaN(n,1); % 24 half-hour (12 hour)
for i = 97:n
   Precip_2daysago(i) = sum(Rain_Euc(i-96:i)); 
end
for i = 49:n
   Precip_1daysago(i) = sum(Rain_Euc(i-48:i)); 
end
for i = 25:n
   Precip_halfdayago(i) = sum(Rain_Euc(i-24:i)); 
end

% merge

% Determine which elements of A are also in B as well as their corresponding 
% locations in B.
[Lia,Locb] = ismember(DateTime_Euc,DateTime_rain_Euc);
% A = [5 3 4 2]; B = [2 4 4 4 6 8];
% Lia = 0     0     1     1
% Locb = 0     0     2     1
% The lowest index to A(3) is B(2).
% A(4) is found in B(1).

n = length(DateTime_Euc);
Precip_Euc = nan(n,1);
Precip_2daysago_Euc = NaN(n,1); % 96 half-hour (2 days)
Precip_1daysago_Euc = NaN(n,1); % 48 half-hour (1 day)
Precip_halfdayago_Euc = NaN(n,1); % 24 half-hour (12 hour)
for i = 1:n
    if Locb(i) > 0
        Precip_Euc(i,1) = Rain_Euc(Locb(i),1);
        Precip_2daysago_Euc(i,1) = Precip_2daysago(Locb(i),1); % 96 half-hour (2 days)
        Precip_1daysago_Euc(i,1) = Precip_1daysago(Locb(i),1); % 48 half-hour (1 day)
        Precip_halfdayago_Euc(i,1) = Precip_halfdayago(Locb(i),1); % 24 half-hour (12 hour)
    end
end


