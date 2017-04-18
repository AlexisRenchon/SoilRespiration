% Clear the workspace
clear;

% The aim of this figure is to:
% 1. show that short time scale Q10 (~ 7 days) differ from long time scale
    % Q10 (~ 1 year) ...
    % But, literature suggest short term Q10 is higher than long term, we
    % will show that it is not always the case, leading to 2.
% 2. show that Q10 decrease with T
% 3. show that at high T (summer), daytime soil R T sensitivity is lower than nighttime soil R
% 4. at which site to we see pattern 1, 2 and 3? During what season?

% NOTE -still need to do to improve the figure:
% 1. To avoid rain pulse events bias and to have a steady SWC, we use these 2 filter:
    % 1. only look at period (ex. 7 days) at least 2 days after a rain event
    % 2. only look at period where it did NOT rain
    
% 2. We separate daytime (continuous line) and nighttime (dashed line)

% Finally, we need do the figure for each site, each year, and each collar (?)


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
ds_Euc.SelectedVariableNames = {'datetime','Rsoil','collar','ring','RsoilCV','Tsoil','VWC'}; 
% Read selected variables, save it in the workspace as a table
Euc_Data = readall(ds_Euc);
% Get data from the table, change format if necessary
DateTime_Euc = Euc_Data.datetime; DateTime_Euc = datetime(DateTime_Euc,'InputFormat','yyyy-MM-dd HH:mm:ss');
Rsoil_Euc = Euc_Data.Rsoil;
Collar_Euc = Euc_Data.collar;
Ring_Euc = Euc_Data.ring;
RsoilCV_Euc = Euc_Data.RsoilCV;
Tsoil_Euc = Euc_Data.Tsoil;
VWC_Euc = Euc_Data.VWC;
% clear unused variables
clearvars Euc_Data ds_Euc source_Euc; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data analysis and figure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Latitude and longitude in rad
lat = -33.6132*pi/180;
lon = -150.72446*pi/180;

% get Day from Datetime



% Day of the year vector, same dimension as datetime vector
DOY_Euc = day(DateTime_Euc,'dayofyear');

% Define condition: i.e. which data we look into
use = find(RsoilCV_Euc <= 1.2 & Ring_Euc == 3 & Collar_Euc == 0);
% VWC condition for later
% & VWC_Euc <= quantile(VWC_Euc,0.1)
[beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x,conf] ...
    = Q10FIT(Tsoil_Euc,Rsoil_Euc,use,nanmin(Tsoil_Euc(use)),nanmax(Tsoil_Euc(use)));
figure; hold on;
scatter(Tsoil_Euc(use),Rsoil_Euc(use),10,[0.8 0.8 0.8]);
plot(Rplot_x,Rplot_y,'LineWidth',3,'Color','k');

d = 1;
i = 1;
while d < 358
    use = find(RsoilCV_Euc <= 1.2 & DOY_Euc >= d & DOY_Euc <= d+7 & Ring_Euc == 3 & Collar_Euc == 0);
    VWC_Euc_period(i) = mean(VWC_Euc(use));
    d = d+7;
    i = i + 1;
end
Quartiles_VWC = quantile(VWC_Euc_period,0:1/4:1);

d = 1;
while d < 358
    use = find(RsoilCV_Euc <= 1.2 & DOY_Euc >= d & DOY_Euc <= d+7 & Ring_Euc == 3 & Collar_Euc == 0);
    if length(Rsoil_Euc(use)) > 20
        if mean(VWC_Euc(use)) >= Quartiles_VWC(1) && mean(VWC_Euc(use)) <= Quartiles_VWC(2)
            swcquantilecolor = [1 0 0]; % red, very dry soil
        end
        if mean(VWC_Euc(use)) >= Quartiles_VWC(2) && mean(VWC_Euc(use)) <= Quartiles_VWC(3)
            swcquantilecolor = [1 0 1]; % magenta, dry soil
        end
        if mean(VWC_Euc(use)) >= Quartiles_VWC(3) && mean(VWC_Euc(use)) <= Quartiles_VWC(4)
            swcquantilecolor = [0 1 0]; % green, wet soil
        end
        if mean(VWC_Euc(use)) >= Quartiles_VWC(4) && mean(VWC_Euc(use)) <= Quartiles_VWC(5)
            swcquantilecolor = [0 0 1]; % blue, very wet soil
        end
        [beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x,conf] ...
            = Q10FIT(Tsoil_Euc,Rsoil_Euc,use,nanmin(Tsoil_Euc(use)),nanmax(Tsoil_Euc(use)));
        plot(Rplot_x,Rplot_y,'Color',swcquantilecolor);
        d = d+7;
    end
end








% clear workspace
clear;

% other site: Wombat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load input data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Inputs:
% ! I still need rain and daytime vector for the analysis

% Load raw data (.csv file)
% Location of raw input file
source_Wom = 'Input\Input Wombat\WombatForest_RSData_AV_2010_2011_UniMelb_NHN.csv';
% Create datastore to access collection of data
ds_Wom = datastore(source_Wom);
% Select variable of interest
ds_Wom.SelectedVariableNames = {'TIME_END_cycle','RS_AVmin4Ch_umolCO2_m2s1','T_10cm','Sws_10cm'}; 
ds_Wom.TreatAsMissing = 'NA';
% Read selected variables, save it in the workspace as a table
Wom_Data = readall(ds_Wom);
% Get data from the table, change format if necessary
DateTime_Wom = Wom_Data.TIME_END_cycle; DateTime_Wom = datetime(DateTime_Wom,'InputFormat','dd/MM/yyyy HH:mm');
Rsoil_Wom = Wom_Data.RS_AVmin4Ch_umolCO2_m2s1;
Tsoil_Wom = Wom_Data.T_10cm;
VWC_Wom = Wom_Data.Sws_10cm;
% clear unused variables
clearvars Wom_Data ds_Wom source_Wom; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data analysis and figure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Day of the year vector, same dimension as datetime vector
DOY_Wom = day(DateTime_Wom,'dayofyear');

% Define condition: i.e. which data we look into
use = find(isnan(Rsoil_Wom) == 0);
% VWC condition for later
% & VWC_Euc <= quantile(VWC_Euc,0.1)
[beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x,conf] ...
    = Q10FIT(Tsoil_Wom,Rsoil_Wom,use,nanmin(Tsoil_Wom(use)),nanmax(Tsoil_Wom(use)));
figure; hold on;
scatter(Tsoil_Wom(use),Rsoil_Wom(use),10,[0.8 0.8 0.8]);
plot(Rplot_x,Rplot_y,'LineWidth',3,'Color','k');

d = 1;
i = 1;
while d < 358
    use = find(isnan(Rsoil_Wom) == 0 & DOY_Wom >= d & DOY_Wom <= d+7);
    VWC_Wom_period(i) = mean(VWC_Wom(use));
    d = d+7;
    i = i + 1;
end
Quartiles_VWC = quantile(VWC_Wom_period,0:1/4:1);

d = 1;
while d < 358
    use = find(isnan(Rsoil_Wom) == 0 & DOY_Wom >= d & DOY_Wom <= d+7);
    if length(Rsoil_Wom(use)) > 20
        if mean(VWC_Wom(use)) >= Quartiles_VWC(1) && mean(VWC_Wom(use)) <= Quartiles_VWC(2)
            swcquantilecolor = [1 0 0]; % red, very dry soil
        end
        if mean(VWC_Wom(use)) >= Quartiles_VWC(2) && mean(VWC_Wom(use)) <= Quartiles_VWC(3)
            swcquantilecolor = [1 0 1]; % magenta, dry soil
        end
        if mean(VWC_Wom(use)) >= Quartiles_VWC(3) && mean(VWC_Wom(use)) <= Quartiles_VWC(4)
            swcquantilecolor = [0 1 0]; % green, wet soil
        end
        if mean(VWC_Wom(use)) >= Quartiles_VWC(4) && mean(VWC_Wom(use)) <= Quartiles_VWC(5)
            swcquantilecolor = [0 0 1]; % blue, very wet soil
        end
        [beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x,conf] ...
            = Q10FIT(Tsoil_Wom,Rsoil_Wom,use,nanmin(Tsoil_Wom(use)),nanmax(Tsoil_Wom(use)));
        plot(Rplot_x,Rplot_y,'Color',swcquantilecolor);
        d = d+7;
    end
end













% clear workspace
clear;

% other site: Harvard
