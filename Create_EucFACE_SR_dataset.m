clear;
% Site: EucFACE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load input data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load raw data (.csv file)
% Location of raw input file
source_Euc = 'Input\Input EucFACE\Rsoil_env_AR.csv';
% Create datastore to access collection of data
ds_Euc = datastore(source_Euc);
% Select variable of interest
ds_Euc.SelectedVariableNames = {'datetime','Rsoil','collar','ring','RsoilCV','Tsoil','VWC','daytime','rainSum','Rain_past12h','Rain_past1day','Rain_past2days','campaign'}; 
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
Rain_Euc = Euc_Data.rainSum;
Rain_p05_Euc = Euc_Data.Rain_past12h;
Rain_p1_Euc = Euc_Data.Rain_past1day;
Rain_p2_Euc = Euc_Data.Rain_past2days;
Campaign_Euc = Euc_Data.campaign;
% clear unused variables
clearvars Euc_Data ds_Euc source_Euc; 

% Load raw data (.csv file)
% Location of raw input file
source_Euc = 'Input\Input EucFACE\FACE_R1_B1_SoilVars_2012_2017.csv';
% Create datastore to access collection of data
ds_Euc = datastore(source_Euc);
% Select variable of interest
ds_Euc.SelectedVariableNames = {'Date','Time','Theta5_1_Avg_mean','Theta5_2_Avg_mean','Theta30_1_Avg_mean','Theta30_2_Avg_mean','Theta75_1_Avg_mean', ...
    'Theta75_2_Avg_mean','T5cm_1_Avg_mean','T5cm_2_Avg_mean','T10cm_1_Avg_mean','T10cm_2_Avg_mean','T30cm_1_Avg_mean','T30cm_2_Avg_mean', ...
    'T50cm_1_Avg_mean','T50cm_2_Avg_mean','T100cm_1_Avg_mean','T100cm_2_Avg_mean',}; 
ds_Euc.TreatAsMissing = 'NA';
% Read selected variables, save it in the workspace as a table
Euc_Data = readall(ds_Euc);
% Get data from the table, change format if necessary
Date_Euc = Euc_Data.Date; Date_Euc = datetime(Date_Euc,'InputFormat','dd/MM/yyyy');
Time_Euc = Euc_Data.Time; Time_Euc = datetime(Time_Euc,'InputFormat','HH:mm:ss');
DateTime_EucR1 = Date_Euc + timeofday(Time_Euc);
SWC5_1_R1 = Euc_Data.Theta5_1_Avg_mean; SWC5_2_R1 = Euc_Data.Theta5_2_Avg_mean;
SWC30_1_R1 = Euc_Data.Theta30_1_Avg_mean; SWC30_2_R1 = Euc_Data.Theta30_2_Avg_mean;
SWC75_1_R1 = Euc_Data.Theta75_1_Avg_mean; SWC75_2_R1 = Euc_Data.Theta75_2_Avg_mean;
T5cm_1_R1 = Euc_Data.T5cm_1_Avg_mean; T5cm_2_R1 = Euc_Data.T5cm_2_Avg_mean;
T10cm_1_R1 = Euc_Data.T10cm_1_Avg_mean; T10cm_2_R1 = Euc_Data.T10cm_2_Avg_mean;
T30cm_1_R1 = Euc_Data.T30cm_1_Avg_mean; T30cm_2_R1 = Euc_Data.T30cm_2_Avg_mean;
T50cm_1_R1 = Euc_Data.T50cm_1_Avg_mean; T50cm_2_R1 = Euc_Data.T50cm_2_Avg_mean;
T100cm_1_R1 = Euc_Data.T100cm_1_Avg_mean; T100cm_2_R1 = Euc_Data.T100cm_2_Avg_mean;
% clear unused variables
clearvars Date_Euc Time_Euc Euc_Data ds_Euc source_Euc; 

% Load raw data (.csv file)
% Location of raw input file
source_Euc = 'Input\Input EucFACE\FACE_R2_B1_SoilVars_2012_2017.csv';
% Create datastore to access collection of data
ds_Euc = datastore(source_Euc);
% Select variable of interest
ds_Euc.SelectedVariableNames = {'Date','Time','Theta5_1_Avg_mean','Theta5_2_Avg_mean','Theta30_1_Avg_mean','Theta30_2_Avg_mean','Theta75_1_Avg_mean', ...
    'Theta75_2_Avg_mean','T5cm_1_Avg_mean','T5cm_2_Avg_mean','T10cm_1_Avg_mean','T10cm_2_Avg_mean','T30cm_1_Avg_mean','T30cm_2_Avg_mean', ...
    'T50cm_1_Avg_mean','T50cm_2_Avg_mean','T100cm_1_Avg_mean','T100cm_2_Avg_mean',}; 
ds_Euc.TreatAsMissing = 'NA';
% Read selected variables, save it in the workspace as a table
Euc_Data = readall(ds_Euc);
% Get data from the table, change format if necessary
Date_Euc = Euc_Data.Date; Date_Euc = datetime(Date_Euc,'InputFormat','dd/MM/yyyy');
Time_Euc = Euc_Data.Time; Time_Euc = datetime(Time_Euc,'InputFormat','HH:mm:ss');
DateTime_EucR2 = Date_Euc + timeofday(Time_Euc);
SWC5_1_R2 = Euc_Data.Theta5_1_Avg_mean; SWC5_2_R2 = Euc_Data.Theta5_2_Avg_mean;
SWC30_1_R2 = Euc_Data.Theta30_1_Avg_mean; SWC30_2_R2 = Euc_Data.Theta30_2_Avg_mean;
SWC75_1_R2 = Euc_Data.Theta75_1_Avg_mean; SWC75_2_R2 = Euc_Data.Theta75_2_Avg_mean;
T5cm_1_R2 = Euc_Data.T5cm_1_Avg_mean; T5cm_2_R2 = Euc_Data.T5cm_2_Avg_mean;
T10cm_1_R2 = Euc_Data.T10cm_1_Avg_mean; T10cm_2_R2 = Euc_Data.T10cm_2_Avg_mean;
T30cm_1_R2 = Euc_Data.T30cm_1_Avg_mean; T30cm_2_R2 = Euc_Data.T30cm_2_Avg_mean;
T50cm_1_R2 = Euc_Data.T50cm_1_Avg_mean; T50cm_2_R2 = Euc_Data.T50cm_2_Avg_mean;
T100cm_1_R2 = Euc_Data.T100cm_1_Avg_mean; T100cm_2_R2 = Euc_Data.T100cm_2_Avg_mean;
% clear unused variables
clearvars Date_Euc Time_Euc Euc_Data ds_Euc source_Euc; 


source_Euc = 'Input\Input EucFACE\FACE_R3_B1_SoilVars_2012_2017.csv';
% Create datastore to access collection of data
ds_Euc = datastore(source_Euc);
% Select variable of interest
ds_Euc.SelectedVariableNames = {'Date','Time','Theta5_1_Avg_mean','Theta5_2_Avg_mean','Theta30_1_Avg_mean','Theta30_2_Avg_mean','Theta75_1_Avg_mean', ...
    'Theta75_2_Avg_mean','T5cm_1_Avg_mean','T5cm_2_Avg_mean','T10cm_1_Avg_mean','T10cm_2_Avg_mean','T30cm_1_Avg_mean','T30cm_2_Avg_mean', ...
    'T50cm_1_Avg_mean','T50cm_2_Avg_mean','T100cm_1_Avg_mean','T100cm_2_Avg_mean',}; 
ds_Euc.TreatAsMissing = 'NA';
% Read selected variables, save it in the workspace as a table
Euc_Data = readall(ds_Euc);
% Get data from the table, change format if necessary
Date_Euc = Euc_Data.Date; Date_Euc = datetime(Date_Euc,'InputFormat','dd/MM/yyyy');
Time_Euc = Euc_Data.Time; Time_Euc = datetime(Time_Euc,'InputFormat','HH:mm:ss');
DateTime_EucR3 = Date_Euc + timeofday(Time_Euc);
SWC5_1_R3 = Euc_Data.Theta5_1_Avg_mean; SWC5_2_R3 = Euc_Data.Theta5_2_Avg_mean;
SWC30_1_R3 = Euc_Data.Theta30_1_Avg_mean; SWC30_2_R3 = Euc_Data.Theta30_2_Avg_mean;
SWC75_1_R3 = Euc_Data.Theta75_1_Avg_mean; SWC75_2_R3 = Euc_Data.Theta75_2_Avg_mean;
T5cm_1_R3 = Euc_Data.T5cm_1_Avg_mean; T5cm_2_R3 = Euc_Data.T5cm_2_Avg_mean;
T10cm_1_R3 = Euc_Data.T10cm_1_Avg_mean; T10cm_2_R3 = Euc_Data.T10cm_2_Avg_mean;
T30cm_1_R3 = Euc_Data.T30cm_1_Avg_mean; T30cm_2_R3 = Euc_Data.T30cm_2_Avg_mean;
T50cm_1_R3 = Euc_Data.T50cm_1_Avg_mean; T50cm_2_R3 = Euc_Data.T50cm_2_Avg_mean;
T100cm_1_R3 = Euc_Data.T100cm_1_Avg_mean; T100cm_2_R3 = Euc_Data.T100cm_2_Avg_mean;
% clear unused variables
clearvars Date_Euc Time_Euc Euc_Data ds_Euc source_Euc; 


source_Euc = 'Input\Input EucFACE\FACE_R4_B1_SoilVars_2012_2017.csv';
% Create datastore to access collection of data
ds_Euc = datastore(source_Euc);
% Select variable of interest
ds_Euc.SelectedVariableNames = {'Date','Time','Theta5_1_Avg_mean','Theta5_2_Avg_mean','Theta30_1_Avg_mean','Theta30_2_Avg_mean','Theta75_1_Avg_mean', ...
    'Theta75_2_Avg_mean','T5cm_1_Avg_mean','T5cm_2_Avg_mean','T10cm_1_Avg_mean','T10cm_2_Avg_mean','T30cm_1_Avg_mean','T30cm_2_Avg_mean', ...
    'T50cm_1_Avg_mean','T50cm_2_Avg_mean','T100cm_1_Avg_mean','T100cm_2_Avg_mean',}; 
ds_Euc.TreatAsMissing = 'NA';
% Read selected variables, save it in the workspace as a table
Euc_Data = readall(ds_Euc);
% Get data from the table, change format if necessary
Date_Euc = Euc_Data.Date; Date_Euc = datetime(Date_Euc,'InputFormat','dd/MM/yyyy');
Time_Euc = Euc_Data.Time; Time_Euc = datetime(Time_Euc,'InputFormat','HH:mm:ss');
DateTime_EucR4 = Date_Euc + timeofday(Time_Euc);
SWC5_1_R4 = Euc_Data.Theta5_1_Avg_mean; SWC5_2_R4 = Euc_Data.Theta5_2_Avg_mean;
SWC30_1_R4 = Euc_Data.Theta30_1_Avg_mean; SWC30_2_R4 = Euc_Data.Theta30_2_Avg_mean;
SWC75_1_R4 = Euc_Data.Theta75_1_Avg_mean; SWC75_2_R4 = Euc_Data.Theta75_2_Avg_mean;
T5cm_1_R4 = Euc_Data.T5cm_1_Avg_mean; T5cm_2_R4 = Euc_Data.T5cm_2_Avg_mean;
T10cm_1_R4 = Euc_Data.T10cm_1_Avg_mean; T10cm_2_R4 = Euc_Data.T10cm_2_Avg_mean;
T30cm_1_R4 = Euc_Data.T30cm_1_Avg_mean; T30cm_2_R4 = Euc_Data.T30cm_2_Avg_mean;
T50cm_1_R4 = Euc_Data.T50cm_1_Avg_mean; T50cm_2_R4 = Euc_Data.T50cm_2_Avg_mean;
T100cm_1_R4 = Euc_Data.T100cm_1_Avg_mean; T100cm_2_R4 = Euc_Data.T100cm_2_Avg_mean;
% clear unused variables
clearvars Date_Euc Time_Euc Euc_Data ds_Euc source_Euc; 


source_Euc = 'Input\Input EucFACE\FACE_R5_B1_SoilVars_2012_2017.csv';
% Create datastore to access collection of data
ds_Euc = datastore(source_Euc);
% Select variable of interest
ds_Euc.SelectedVariableNames = {'Date','Time','Theta5_1_Avg_mean','Theta5_2_Avg_mean','Theta30_1_Avg_mean','Theta30_2_Avg_mean','Theta75_1_Avg_mean', ...
    'Theta75_2_Avg_mean','T5cm_1_Avg_mean','T5cm_2_Avg_mean','T10cm_1_Avg_mean','T10cm_2_Avg_mean','T30cm_1_Avg_mean','T30cm_2_Avg_mean', ...
    'T50cm_1_Avg_mean','T50cm_2_Avg_mean','T100cm_1_Avg_mean','T100cm_2_Avg_mean',}; 
ds_Euc.TreatAsMissing = 'NA';
% Read selected variables, save it in the workspace as a table
Euc_Data = readall(ds_Euc);
% Get data from the table, change format if necessary
Date_Euc = Euc_Data.Date; Date_Euc = datetime(Date_Euc,'InputFormat','dd/MM/yyyy');
Time_Euc = Euc_Data.Time; Time_Euc = datetime(Time_Euc,'InputFormat','HH:mm:ss');
DateTime_EucR5 = Date_Euc + timeofday(Time_Euc);
SWC5_1_R5 = Euc_Data.Theta5_1_Avg_mean; SWC5_2_R5 = Euc_Data.Theta5_2_Avg_mean;
SWC30_1_R5 = Euc_Data.Theta30_1_Avg_mean; SWC30_2_R5 = Euc_Data.Theta30_2_Avg_mean;
SWC75_1_R5 = Euc_Data.Theta75_1_Avg_mean; SWC75_2_R5 = Euc_Data.Theta75_2_Avg_mean;
T5cm_1_R5 = Euc_Data.T5cm_1_Avg_mean; T5cm_2_R5 = Euc_Data.T5cm_2_Avg_mean;
T10cm_1_R5 = Euc_Data.T10cm_1_Avg_mean; T10cm_2_R5 = Euc_Data.T10cm_2_Avg_mean;
T30cm_1_R5 = Euc_Data.T30cm_1_Avg_mean; T30cm_2_R5 = Euc_Data.T30cm_2_Avg_mean;
T50cm_1_R5 = Euc_Data.T50cm_1_Avg_mean; T50cm_2_R5 = Euc_Data.T50cm_2_Avg_mean;
T100cm_1_R5 = Euc_Data.T100cm_1_Avg_mean; T100cm_2_R5 = Euc_Data.T100cm_2_Avg_mean;
% clear unused variables
clearvars Date_Euc Time_Euc Euc_Data ds_Euc source_Euc; 


source_Euc = 'Input\Input EucFACE\FACE_R6_B1_SoilVars_2012_2017.csv';
% Create datastore to access collection of data
ds_Euc = datastore(source_Euc);
% Select variable of interest
ds_Euc.SelectedVariableNames = {'Date','Time','Theta5_1_Avg_mean','Theta5_2_Avg_mean','Theta30_1_Avg_mean','Theta30_2_Avg_mean','Theta75_1_Avg_mean', ...
    'Theta75_2_Avg_mean','T5cm_1_Avg_mean','T5cm_2_Avg_mean','T10cm_1_Avg_mean','T10cm_2_Avg_mean','T30cm_1_Avg_mean','T30cm_2_Avg_mean', ...
    'T50cm_1_Avg_mean','T50cm_2_Avg_mean','T100cm_1_Avg_mean','T100cm_2_Avg_mean',}; 
ds_Euc.TreatAsMissing = 'NA';
% Read selected variables, save it in the workspace as a table
Euc_Data = readall(ds_Euc);
% Get data from the table, change format if necessary
Date_Euc = Euc_Data.Date; Date_Euc = datetime(Date_Euc,'InputFormat','dd/MM/yyyy');
Time_Euc = Euc_Data.Time; Time_Euc = datetime(Time_Euc,'InputFormat','HH:mm:ss');
DateTime_EucR6 = Date_Euc + timeofday(Time_Euc);
SWC5_1_R6 = Euc_Data.Theta5_1_Avg_mean; SWC5_2_R6 = Euc_Data.Theta5_2_Avg_mean;
SWC30_1_R6 = Euc_Data.Theta30_1_Avg_mean; SWC30_2_R6 = Euc_Data.Theta30_2_Avg_mean;
SWC75_1_R6 = Euc_Data.Theta75_1_Avg_mean; SWC75_2_R6 = Euc_Data.Theta75_2_Avg_mean;
T5cm_1_R6 = Euc_Data.T5cm_1_Avg_mean; T5cm_2_R6 = Euc_Data.T5cm_2_Avg_mean;
T10cm_1_R6 = Euc_Data.T10cm_1_Avg_mean; T10cm_2_R6 = Euc_Data.T10cm_2_Avg_mean;
T30cm_1_R6 = Euc_Data.T30cm_1_Avg_mean; T30cm_2_R6 = Euc_Data.T30cm_2_Avg_mean;
T50cm_1_R6 = Euc_Data.T50cm_1_Avg_mean; T50cm_2_R6 = Euc_Data.T50cm_2_Avg_mean;
T100cm_1_R6 = Euc_Data.T100cm_1_Avg_mean; T100cm_2_R6 = Euc_Data.T100cm_2_Avg_mean;
% clear unused variables
clearvars Date_Euc Time_Euc Euc_Data ds_Euc source_Euc; 

% Load raw data (.csv file)
% Location of raw input file
source_Euc = 'Input\Input EucFACE\EddyFlux_slow_met_2012_2017.csv';
% Create datastore to access collection of data
ds_Euc = datastore(source_Euc);
% Select variable of interest
ds_Euc.SelectedVariableNames = {'Date','Time','Ta_HMP_155_Avg','Ah_HMP_155_Avg','Ta_HMP_01_Avg','Ah_HMP_01_Avg'}; 
ds_Euc.TreatAsMissing = 'NA';
% Read selected variables, save it in the workspace as a table
Euc_Data = readall(ds_Euc);
% Get data from the table, change format if necessary
Date_Euc = Euc_Data.Date; Date_Euc = datetime(Date_Euc,'InputFormat','dd/MM/yyyy');
Time_Euc = Euc_Data.Time; Time_Euc = datetime(Time_Euc,'InputFormat','HH:mm:ss');
DateTime_CUP = Date_Euc + timeofday(Time_Euc);
Ta_HMP155 = Euc_Data.Ta_HMP_155_Avg;
Ta_HMP01 = Euc_Data.Ta_HMP_01_Avg;
AH_HMP155 = Euc_Data.Ah_HMP_155_Avg;
AH_HMP01 = Euc_Data.Ah_HMP_01_Avg;
% clear unused variables
clearvars Euc_Data ds_Euc source_Euc Date_Euc Time_Euc; 


% Load raw data (.csv file)
% Location of raw input file
source_Euc = 'Input\Input EucFACE\EFS_S00_CS505_R_2012_2017.csv';
% Create datastore to access collection of data
ds_Euc = datastore(source_Euc);
% Select variable of interest
ds_Euc.SelectedVariableNames = {'Date','Time','FuelM_1__mean','FuelM_2__mean','FuelM_3__mean'}; 
ds_Euc.TreatAsMissing = 'NA';
% Read selected variables, save it in the workspace as a table
Euc_Data = readall(ds_Euc);
% Get data from the table, change format if necessary
Date_Euc = Euc_Data.Date; Date_Euc = datetime(Date_Euc,'InputFormat','dd/MM/yyyy');
Time_Euc = Euc_Data.Time; Time_Euc = datetime(Time_Euc,'InputFormat','HH:mm:ss');
DateTime_FM = Date_Euc + timeofday(Time_Euc);
FM1 = Euc_Data.FuelM_1__mean;
FM2 = Euc_Data.FuelM_2__mean;
FM3 = Euc_Data.FuelM_3__mean;
% clear unused variables
clearvars Euc_Data ds_Euc source_Euc Date_Euc Time_Euc; 


% Load raw data (.csv file)
% Location of raw input file
source_Euc = 'Input\Input EucFACE\FACELawn_FACE_diffPAR_2012_2017.csv';
% Create datastore to access collection of data
ds_Euc = datastore(source_Euc);
% Select variable of interest
ds_Euc.SelectedVariableNames = {'Date','Time','PAR_Avg_mean'}; 
ds_Euc.TreatAsMissing = 'NA';
% Read selected variables, save it in the workspace as a table
Euc_Data = readall(ds_Euc);
% Get data from the table, change format if necessary
Date_Euc = Euc_Data.Date; Date_Euc = datetime(Date_Euc,'InputFormat','dd/MM/yyyy');
Time_Euc = Euc_Data.Time; Time_Euc = datetime(Time_Euc,'InputFormat','HH:mm:ss');
DateTime_PAR = Date_Euc + timeofday(Time_Euc);
PAR = Euc_Data.PAR_Avg_mean;
% clear unused variables
clearvars Euc_Data ds_Euc source_Euc Date_Euc Time_Euc; 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Data processing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Continuous timesteps 
DateTime_Euc_c = datetime(2012,06,01,00,00,00):minutes(30):datetime(2016,01,01,00,00,00);
DateTime_Euc_c = DateTime_Euc_c';

% Merge data to continuous timestep, in a table
n = length(DateTime_Euc_c);

use = find(strcmp(Campaign_Euc, 'Auto') & Ring_Euc == 3 & Collar_Euc == 0 & RsoilCV_Euc <= 1.1);
Rsoil_r3c0_temp = Rsoil_Euc(use);
DateTime_Euc_temp = DateTime_Euc(use);

[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_Euc_temp);
Rsoil_R3c0 = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        Rsoil_R3c0(i,1) = Rsoil_r3c0_temp(Locb(i),1);
    end
end
clearvars Rsoil_r3c0_temp DateTime_Euc_temp use i Lia Locb n;
n = length(DateTime_Euc_c);
[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_EucR3);
Ts5_1_R3 = nan(n,1); Ts5_2_R3 = nan(n,1);
Ts10_1_R3 = nan(n,1); Ts10_2_R3 = nan(n,1);
Ts30_1_R3 = nan(n,1); Ts30_2_R3 = nan(n,1);
Ts50_1_R3 = nan(n,1); Ts50_2_R3 = nan(n,1);
Ts100_1_R3 = nan(n,1); Ts100_2_R3 = nan(n,1);
SWC5cm_1_R3 = nan(n,1); SWC5cm_2_R3 = nan(n,1);
SWC30cm_1_R3 = nan(n,1); SWC30cm_2_R3 = nan(n,1);
SWC75cm_1_R3 = nan(n,1); SWC75cm_2_R3 = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        Ts5_1_R3(i,1) = T5cm_1_R3(Locb(i),1); Ts5_2_R3(i,1) = T5cm_2_R3(Locb(i),1);
        Ts10_1_R3(i,1) = T10cm_1_R3(Locb(i),1); Ts10_2_R3(i,1) = T10cm_2_R3(Locb(i),1);
        Ts30_1_R3(i,1) = T30cm_1_R3(Locb(i),1); Ts30_2_R3(i,1) = T30cm_2_R3(Locb(i),1);
        Ts50_1_R3(i,1) = T50cm_1_R3(Locb(i),1); Ts50_2_R3(i,1) = T50cm_2_R3(Locb(i),1);
        Ts100_1_R3(i,1) = T100cm_1_R3(Locb(i),1); Ts100_2_R3(i,1) = T100cm_2_R3(Locb(i),1);
        SWC5cm_1_R3(i,1) = SWC5_1_R3(Locb(i),1); SWC5cm_2_R3(i,1) = SWC5_2_R3(Locb(i),1);
        SWC30cm_1_R3(i,1) = SWC30_1_R3(Locb(i),1); SWC30cm_2_R3(i,1) = SWC30_2_R3(Locb(i),1);
        SWC75cm_1_R3(i,1) = SWC75_1_R3(Locb(i),1); SWC75cm_2_R3(i,1) = SWC75_2_R3(Locb(i),1);
    end
end
clearvars i Lia Locb n;


n = length(DateTime_Euc_c);
[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_EucR1);
Ts5_1_R1 = nan(n,1); Ts5_2_R1 = nan(n,1);
Ts10_1_R1 = nan(n,1); Ts10_2_R1 = nan(n,1);
Ts30_1_R1 = nan(n,1); Ts30_2_R1 = nan(n,1);
Ts50_1_R1 = nan(n,1); Ts50_2_R1 = nan(n,1);
Ts100_1_R1 = nan(n,1); Ts100_2_R1 = nan(n,1);
SWC5cm_1_R1 = nan(n,1); SWC5cm_2_R1 = nan(n,1);
SWC30cm_1_R1 = nan(n,1); SWC30cm_2_R1 = nan(n,1);
SWC75cm_1_R1 = nan(n,1); SWC75cm_2_R1 = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        Ts5_1_R1(i,1) = T5cm_1_R1(Locb(i),1); Ts5_2_R1(i,1) = T5cm_2_R1(Locb(i),1);
        Ts10_1_R1(i,1) = T10cm_1_R1(Locb(i),1); Ts10_2_R1(i,1) = T10cm_2_R1(Locb(i),1);
        Ts30_1_R1(i,1) = T30cm_1_R1(Locb(i),1); Ts30_2_R1(i,1) = T30cm_2_R1(Locb(i),1);
        Ts50_1_R1(i,1) = T50cm_1_R1(Locb(i),1); Ts50_2_R1(i,1) = T50cm_2_R1(Locb(i),1);
        Ts100_1_R1(i,1) = T100cm_1_R1(Locb(i),1); Ts100_2_R1(i,1) = T100cm_2_R1(Locb(i),1);
        SWC5cm_1_R1(i,1) = SWC5_1_R1(Locb(i),1); SWC5cm_2_R1(i,1) = SWC5_2_R1(Locb(i),1);
        SWC30cm_1_R1(i,1) = SWC30_1_R1(Locb(i),1); SWC30cm_2_R1(i,1) = SWC30_2_R1(Locb(i),1);
        SWC75cm_1_R1(i,1) = SWC75_1_R1(Locb(i),1); SWC75cm_2_R1(i,1) = SWC75_2_R1(Locb(i),1);
    end
end
clearvars i Lia Locb n;


n = length(DateTime_Euc_c);
[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_EucR2);
Ts5_1_R2 = nan(n,1); Ts5_2_R2 = nan(n,1);
Ts10_1_R2 = nan(n,1); Ts10_2_R2 = nan(n,1);
Ts30_1_R2 = nan(n,1); Ts30_2_R2 = nan(n,1);
Ts50_1_R2 = nan(n,1); Ts50_2_R2 = nan(n,1);
Ts100_1_R2 = nan(n,1); Ts100_2_R2 = nan(n,1);
SWC5cm_1_R2 = nan(n,1); SWC5cm_2_R2 = nan(n,1);
SWC30cm_1_R2 = nan(n,1); SWC30cm_2_R2 = nan(n,1);
SWC75cm_1_R2 = nan(n,1); SWC75cm_2_R2 = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        Ts5_1_R2(i,1) = T5cm_1_R2(Locb(i),1); Ts5_2_R2(i,1) = T5cm_2_R2(Locb(i),1);
        Ts10_1_R2(i,1) = T10cm_1_R2(Locb(i),1); Ts10_2_R2(i,1) = T10cm_2_R2(Locb(i),1);
        Ts30_1_R2(i,1) = T30cm_1_R2(Locb(i),1); Ts30_2_R2(i,1) = T30cm_2_R2(Locb(i),1);
        Ts50_1_R2(i,1) = T50cm_1_R2(Locb(i),1); Ts50_2_R2(i,1) = T50cm_2_R2(Locb(i),1);
        Ts100_1_R2(i,1) = T100cm_1_R2(Locb(i),1); Ts100_2_R2(i,1) = T100cm_2_R2(Locb(i),1);
        SWC5cm_1_R2(i,1) = SWC5_1_R2(Locb(i),1); SWC5cm_2_R2(i,1) = SWC5_2_R2(Locb(i),1);
        SWC30cm_1_R2(i,1) = SWC30_1_R2(Locb(i),1); SWC30cm_2_R2(i,1) = SWC30_2_R2(Locb(i),1);
        SWC75cm_1_R2(i,1) = SWC75_1_R2(Locb(i),1); SWC75cm_2_R2(i,1) = SWC75_2_R2(Locb(i),1);
    end
end
clearvars i Lia Locb n;


n = length(DateTime_Euc_c);
[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_EucR4);
Ts5_1_R4 = nan(n,1); Ts5_2_R4 = nan(n,1);
Ts10_1_R4 = nan(n,1); Ts10_2_R4 = nan(n,1);
Ts30_1_R4 = nan(n,1); Ts30_2_R4 = nan(n,1);
Ts50_1_R4 = nan(n,1); Ts50_2_R4 = nan(n,1);
Ts100_1_R4 = nan(n,1); Ts100_2_R4 = nan(n,1);
SWC5cm_1_R4 = nan(n,1); SWC5cm_2_R4 = nan(n,1);
SWC30cm_1_R4 = nan(n,1); SWC30cm_2_R4 = nan(n,1);
SWC75cm_1_R4 = nan(n,1); SWC75cm_2_R4 = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        Ts5_1_R4(i,1) = T5cm_1_R4(Locb(i),1); Ts5_2_R4(i,1) = T5cm_2_R4(Locb(i),1);
        Ts10_1_R4(i,1) = T10cm_1_R4(Locb(i),1); Ts10_2_R4(i,1) = T10cm_2_R4(Locb(i),1);
        Ts30_1_R4(i,1) = T30cm_1_R4(Locb(i),1); Ts30_2_R4(i,1) = T30cm_2_R4(Locb(i),1);
        Ts50_1_R4(i,1) = T50cm_1_R4(Locb(i),1); Ts50_2_R4(i,1) = T50cm_2_R4(Locb(i),1);
        Ts100_1_R4(i,1) = T100cm_1_R4(Locb(i),1); Ts100_2_R4(i,1) = T100cm_2_R4(Locb(i),1);
        SWC5cm_1_R4(i,1) = SWC5_1_R4(Locb(i),1); SWC5cm_2_R4(i,1) = SWC5_2_R4(Locb(i),1);
        SWC30cm_1_R4(i,1) = SWC30_1_R4(Locb(i),1); SWC30cm_2_R4(i,1) = SWC30_2_R4(Locb(i),1);
        SWC75cm_1_R4(i,1) = SWC75_1_R4(Locb(i),1); SWC75cm_2_R4(i,1) = SWC75_2_R4(Locb(i),1);
    end
end
clearvars i Lia Locb n;


n = length(DateTime_Euc_c);
[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_EucR5);
Ts5_1_R5 = nan(n,1); Ts5_2_R5 = nan(n,1);
Ts10_1_R5 = nan(n,1); Ts10_2_R5 = nan(n,1);
Ts30_1_R5 = nan(n,1); Ts30_2_R5 = nan(n,1);
Ts50_1_R5 = nan(n,1); Ts50_2_R5 = nan(n,1);
Ts100_1_R5 = nan(n,1); Ts100_2_R5 = nan(n,1);
SWC5cm_1_R5 = nan(n,1); SWC5cm_2_R5 = nan(n,1);
SWC30cm_1_R5 = nan(n,1); SWC30cm_2_R5 = nan(n,1);
SWC75cm_1_R5 = nan(n,1); SWC75cm_2_R5 = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        Ts5_1_R5(i,1) = T5cm_1_R5(Locb(i),1); Ts5_2_R5(i,1) = T5cm_2_R5(Locb(i),1);
        Ts10_1_R5(i,1) = T10cm_1_R5(Locb(i),1); Ts10_2_R5(i,1) = T10cm_2_R5(Locb(i),1);
        Ts30_1_R5(i,1) = T30cm_1_R5(Locb(i),1); Ts30_2_R5(i,1) = T30cm_2_R5(Locb(i),1);
        Ts50_1_R5(i,1) = T50cm_1_R5(Locb(i),1); Ts50_2_R5(i,1) = T50cm_2_R5(Locb(i),1);
        Ts100_1_R5(i,1) = T100cm_1_R5(Locb(i),1); Ts100_2_R5(i,1) = T100cm_2_R5(Locb(i),1);
        SWC5cm_1_R5(i,1) = SWC5_1_R5(Locb(i),1); SWC5cm_2_R5(i,1) = SWC5_2_R5(Locb(i),1);
        SWC30cm_1_R5(i,1) = SWC30_1_R5(Locb(i),1); SWC30cm_2_R5(i,1) = SWC30_2_R5(Locb(i),1);
        SWC75cm_1_R5(i,1) = SWC75_1_R5(Locb(i),1); SWC75cm_2_R5(i,1) = SWC75_2_R5(Locb(i),1);
    end
end
clearvars i Lia Locb n;


n = length(DateTime_Euc_c);
[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_EucR6);
Ts5_1_R6 = nan(n,1); Ts5_2_R6 = nan(n,1);
Ts10_1_R6 = nan(n,1); Ts10_2_R6 = nan(n,1);
Ts30_1_R6 = nan(n,1); Ts30_2_R6 = nan(n,1);
Ts50_1_R6 = nan(n,1); Ts50_2_R6 = nan(n,1);
Ts100_1_R6 = nan(n,1); Ts100_2_R6 = nan(n,1);
SWC5cm_1_R6 = nan(n,1); SWC5cm_2_R6 = nan(n,1);
SWC30cm_1_R6 = nan(n,1); SWC30cm_2_R6 = nan(n,1);
SWC75cm_1_R6 = nan(n,1); SWC75cm_2_R6 = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        Ts5_1_R6(i,1) = T5cm_1_R6(Locb(i),1); Ts5_2_R6(i,1) = T5cm_2_R6(Locb(i),1);
        Ts10_1_R6(i,1) = T10cm_1_R6(Locb(i),1); Ts10_2_R6(i,1) = T10cm_2_R6(Locb(i),1);
        Ts30_1_R6(i,1) = T30cm_1_R6(Locb(i),1); Ts30_2_R6(i,1) = T30cm_2_R6(Locb(i),1);
        Ts50_1_R6(i,1) = T50cm_1_R6(Locb(i),1); Ts50_2_R6(i,1) = T50cm_2_R6(Locb(i),1);
        Ts100_1_R6(i,1) = T100cm_1_R6(Locb(i),1); Ts100_2_R6(i,1) = T100cm_2_R6(Locb(i),1);
        SWC5cm_1_R6(i,1) = SWC5_1_R6(Locb(i),1); SWC5cm_2_R6(i,1) = SWC5_2_R6(Locb(i),1);
        SWC30cm_1_R6(i,1) = SWC30_1_R6(Locb(i),1); SWC30cm_2_R6(i,1) = SWC30_2_R6(Locb(i),1);
        SWC75cm_1_R6(i,1) = SWC75_1_R6(Locb(i),1); SWC75cm_2_R6(i,1) = SWC75_2_R6(Locb(i),1);
    end
end
clearvars i Lia Locb n;


% Merge data to continuous timestep, in a table
n = length(DateTime_Euc_c);

use = find(strcmp(Campaign_Euc, 'Auto') & Ring_Euc == 1 & Collar_Euc == 3 & RsoilCV_Euc <= 1.1);
Rsoil_r1c3_temp = Rsoil_Euc(use);
DateTime_Euc_temp = DateTime_Euc(use);

[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_Euc_temp);
Rsoil_R1c3 = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        Rsoil_R1c3(i,1) = Rsoil_r1c3_temp(Locb(i),1);
    end
end
clearvars Rsoil_r1c3_temp DateTime_Euc_temp use i Lia Locb n;

% Merge data to continuous timestep, in a table
n = length(DateTime_Euc_c);

use = find(strcmp(Campaign_Euc, 'Auto') & Ring_Euc == 1 & Collar_Euc == 5 & RsoilCV_Euc <= 1.1);
Rsoil_r1c5_temp = Rsoil_Euc(use);
DateTime_Euc_temp = DateTime_Euc(use);

[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_Euc_temp);
Rsoil_R1c5 = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        Rsoil_R1c5(i,1) = Rsoil_r1c5_temp(Locb(i),1);
    end
end
clearvars Rsoil_r1c5_temp DateTime_Euc_temp use i Lia Locb n;

% Merge data to continuous timestep, in a table
n = length(DateTime_Euc_c);

use = find(strcmp(Campaign_Euc, 'Auto') & Ring_Euc == 2 & Collar_Euc == 4 & RsoilCV_Euc <= 1.1);
Rsoil_r2c4_temp = Rsoil_Euc(use);
DateTime_Euc_temp = DateTime_Euc(use);

[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_Euc_temp);
Rsoil_R2c4 = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        Rsoil_R2c4(i,1) = Rsoil_r2c4_temp(Locb(i),1);
    end
end
clearvars Rsoil_r2c4_temp DateTime_Euc_temp use i Lia Locb n;

% Merge data to continuous timestep, in a table
n = length(DateTime_Euc_c);

use = find(strcmp(Campaign_Euc, 'Auto') & Ring_Euc == 2 & Collar_Euc == 6 & RsoilCV_Euc <= 1.1);
Rsoil_r2c6_temp = Rsoil_Euc(use);
DateTime_Euc_temp = DateTime_Euc(use);

[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_Euc_temp);
Rsoil_R2c6 = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        Rsoil_R2c6(i,1) = Rsoil_r2c6_temp(Locb(i),1);
    end
end
clearvars Rsoil_r2c6_temp DateTime_Euc_temp use i Lia Locb n;

% Merge data to continuous timestep, in a table
n = length(DateTime_Euc_c);

use = find(strcmp(Campaign_Euc, 'Auto') & Ring_Euc == 3 & Collar_Euc == 2 & RsoilCV_Euc <= 1.1);
Rsoil_r3c2_temp = Rsoil_Euc(use);
DateTime_Euc_temp = DateTime_Euc(use);

[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_Euc_temp);
Rsoil_R3c2 = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        Rsoil_R3c2(i,1) = Rsoil_r3c2_temp(Locb(i),1);
    end
end
clearvars Rsoil_r3c2_temp DateTime_Euc_temp use i Lia Locb n;

% Merge data to continuous timestep, in a table
n = length(DateTime_Euc_c);

use = find(strcmp(Campaign_Euc, 'Auto') & Ring_Euc == 4 & Collar_Euc == 0 & RsoilCV_Euc <= 1.1);
Rsoil_r4c0_temp = Rsoil_Euc(use);
DateTime_Euc_temp = DateTime_Euc(use);

[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_Euc_temp);
Rsoil_R4c0 = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        Rsoil_R4c0(i,1) = Rsoil_r4c0_temp(Locb(i),1);
    end
end
clearvars Rsoil_r4c0_temp DateTime_Euc_temp use i Lia Locb n;

% Merge data to continuous timestep, in a table
n = length(DateTime_Euc_c);

use = find(strcmp(Campaign_Euc, 'Auto') & Ring_Euc == 4 & Collar_Euc == 2 & RsoilCV_Euc <= 1.1);
Rsoil_r4c2_temp = Rsoil_Euc(use);
DateTime_Euc_temp = DateTime_Euc(use);

[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_Euc_temp);
Rsoil_R4c2 = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        Rsoil_R4c2(i,1) = Rsoil_r4c2_temp(Locb(i),1);
    end
end
clearvars Rsoil_r4c2_temp DateTime_Euc_temp use i Lia Locb n;

% Merge data to continuous timestep, in a table
n = length(DateTime_Euc_c);

use = find(strcmp(Campaign_Euc, 'Auto') & Ring_Euc == 5 & Collar_Euc == 6 & RsoilCV_Euc <= 1.1);
Rsoil_r5c6_temp = Rsoil_Euc(use);
DateTime_Euc_temp = DateTime_Euc(use);

[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_Euc_temp);
Rsoil_R5c6 = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        Rsoil_R5c6(i,1) = Rsoil_r5c6_temp(Locb(i),1);
    end
end
clearvars Rsoil_r5c6_temp DateTime_Euc_temp use i Lia Locb n;

% Merge data to continuous timestep, in a table
n = length(DateTime_Euc_c);

use = find(strcmp(Campaign_Euc, 'Auto') & Ring_Euc == 5 & Collar_Euc == 7 & RsoilCV_Euc <= 1.1);
Rsoil_r5c7_temp = Rsoil_Euc(use);
DateTime_Euc_temp = DateTime_Euc(use);

[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_Euc_temp);
Rsoil_R5c7 = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        Rsoil_R5c7(i,1) = Rsoil_r5c7_temp(Locb(i),1);
    end
end
clearvars Rsoil_r5c7_temp DateTime_Euc_temp use i Lia Locb n;

% Merge data to continuous timestep, in a table
n = length(DateTime_Euc_c);

use = find(strcmp(Campaign_Euc, 'Auto') & Ring_Euc == 6 & Collar_Euc == 0 & RsoilCV_Euc <= 1.1);
Rsoil_r6c0_temp = Rsoil_Euc(use);
DateTime_Euc_temp = DateTime_Euc(use);

[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_Euc_temp);
Rsoil_R6c0 = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        Rsoil_R6c0(i,1) = Rsoil_r6c0_temp(Locb(i),1);
    end
end
clearvars Rsoil_r6c0_temp DateTime_Euc_temp use i Lia Locb n;

% Merge data to continuous timestep, in a table
n = length(DateTime_Euc_c);

use = find(strcmp(Campaign_Euc, 'Auto') & Ring_Euc == 6 & Collar_Euc == 3 & RsoilCV_Euc <= 1.1);
Rsoil_r6c3_temp = Rsoil_Euc(use);
DateTime_Euc_temp = DateTime_Euc(use);

[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_Euc_temp);
Rsoil_R6c3 = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        Rsoil_R6c3(i,1) = Rsoil_r6c3_temp(Locb(i),1);
    end
end
clearvars Rsoil_r6c3_temp DateTime_Euc_temp use i Lia Locb n;

% Merge data to continuous timestep, in a table
n = length(DateTime_Euc_c);

[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_Euc);
Rain = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        Rain(i,1) = Rain_Euc(Locb(i),1);
    end
end
clearvars Rsoil_r6c3_temp DateTime_Euc_temp use i Lia Locb n;

TEuc = table(DateTime_Euc_c,Rain,Rsoil_R1c3,Rsoil_R1c5,Rsoil_R2c4,Rsoil_R2c6,Rsoil_R3c0,Rsoil_R3c2,Rsoil_R4c0,Rsoil_R4c2,Rsoil_R5c6,Rsoil_R5c7,Rsoil_R6c0,Rsoil_R6c3, ...
    SWC5cm_1_R1,SWC5cm_2_R1,SWC5cm_1_R2,SWC5cm_2_R2,SWC5cm_1_R3,SWC5cm_2_R3,SWC5cm_1_R4,SWC5cm_2_R4,SWC5cm_1_R5,SWC5cm_2_R5,SWC5cm_1_R6,SWC5cm_2_R6, ...
    SWC30cm_1_R1,SWC30cm_2_R1,SWC30cm_1_R2,SWC30cm_2_R2,SWC30cm_1_R3,SWC30cm_2_R3,SWC30cm_1_R4,SWC30cm_2_R4,SWC30cm_1_R5,SWC30cm_2_R5,SWC30cm_1_R6,SWC30cm_2_R6, ...
    SWC75cm_1_R1,SWC75cm_2_R1,SWC75cm_1_R2,SWC75cm_2_R2,SWC75cm_1_R3,SWC75cm_2_R3,SWC75cm_1_R4,SWC75cm_2_R4,SWC75cm_1_R5,SWC75cm_2_R5,SWC75cm_1_R6,SWC75cm_2_R6, ...
    Ts5_1_R1,Ts5_2_R1,Ts5_1_R2,Ts5_2_R2,Ts5_1_R3,Ts5_2_R3,Ts5_1_R4,Ts5_2_R4,Ts5_1_R5,Ts5_2_R5,Ts5_1_R6,Ts5_2_R6, ...
    Ts10_1_R1,Ts10_2_R1,Ts10_1_R2,Ts10_2_R2,Ts10_1_R3,Ts10_2_R3,Ts10_1_R4,Ts10_2_R4,Ts10_1_R5,Ts10_2_R5,Ts10_1_R6,Ts10_2_R6, ...
    Ts30_1_R1,Ts30_2_R1,Ts30_1_R2,Ts30_2_R2,Ts30_1_R3,Ts30_2_R3,Ts30_1_R4,Ts30_2_R4,Ts30_1_R5,Ts30_2_R5,Ts30_1_R6,Ts30_2_R6, ...
    Ts50_1_R1,Ts50_2_R1,Ts50_1_R2,Ts50_2_R2,Ts50_1_R3,Ts50_2_R3,Ts50_1_R4,Ts50_2_R4,Ts50_1_R5,Ts50_2_R5,Ts50_1_R6,Ts50_2_R6, ...
    Ts100_1_R1,Ts100_2_R1,Ts100_1_R2,Ts100_2_R2,Ts100_1_R3,Ts100_2_R3,Ts100_1_R4,Ts100_2_R4,Ts100_1_R5,Ts100_2_R5,Ts100_1_R6,Ts100_2_R6);

% Add tair, VPD, PAR and fuel moisture 
n = length(DateTime_Euc_c);
[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_CUP);
for i = 1:n
    if Locb(i) > 0
        Ta_HMP155c(i,1) = Ta_HMP155(Locb(i),1);
        Ta_HMP01c(i,1) = Ta_HMP01(Locb(i),1);
        AH_HMP155c(i,1) = AH_HMP155(Locb(i),1);
        AH_HMP01c(i,1) = AH_HMP01(Locb(i),1);
    end
end
clearvars Rsoil_r6c3_temp DateTime_Euc_temp use i Lia Locb n;

% Add tair, VPD, PAR and fuel moisture 
n = length(DateTime_Euc_c);
[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_FM);
FM1c = nan(n,1);FM2c = nan(n,1);FM3c = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        FM1c(i,1) = FM1(Locb(i),1);
        FM2c(i,1) = FM2(Locb(i),1);
        FM3c(i,1) = FM3(Locb(i),1);
    end
end
clearvars Rsoil_r6c3_temp DateTime_Euc_temp use i Lia Locb n;


% Add tair, VPD, PAR and fuel moisture 
n = length(DateTime_Euc_c);
[Lia,Locb] = ismember(DateTime_Euc_c,DateTime_PAR);
PARc = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        PARc(i,1) = PAR(Locb(i),1);
    end
end
clearvars Rsoil_r6c3_temp DateTime_Euc_temp use i Lia Locb n;





















