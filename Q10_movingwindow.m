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
source_Euc = 'Input\Input EucFACE\FACE_R3_B1_SoilVars_2012_2017.csv';
% Create datastore to access collection of data
ds_Euc = datastore(source_Euc);
% Select variable of interest
ds_Euc.SelectedVariableNames = {'Date','Time','T5cm_2_Avg_mean','T5cm_1_Avg_mean','Theta5_1_Avg_mean'}; 
ds_Euc.TreatAsMissing = 'NA';
% Read selected variables, save it in the workspace as a table
Euc_Data = readall(ds_Euc);
% Get data from the table, change format if necessary
Date_Euc = Euc_Data.Date; Date_Euc = datetime(Date_Euc,'InputFormat','dd/MM/yyyy');
Time_Euc = Euc_Data.Time; Time_Euc = datetime(Time_Euc,'InputFormat','HH:mm:ss');
DateTime_EucR3 = Date_Euc + timeofday(Time_Euc);
T5cm_2_R3 = Euc_Data.T5cm_2_Avg_mean;
T5cm_1_R3 = Euc_Data.T5cm_1_Avg_mean;
SWC_R3 = Euc_Data.Theta5_1_Avg_mean;
% clear unused variables
clearvars Date_Euc Time_Euc Euc_Data ds_Euc source_Euc; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Data processing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% DateTime_EucR3 has no timestep gaps (I checked)
% Merge Rsoil to continuous timestep
n = length(DateTime_EucR3);
use = find(strcmp(Campaign_Euc, 'Auto') & Ring_Euc == 3 & Collar_Euc == 0 & RsoilCV_Euc <= 1.1);
Rsoil_r3c0_temp = Rsoil_Euc(use);
DateTime_Euc_temp = DateTime_Euc(use);
[Lia,Locb] = ismember(DateTime_EucR3,DateTime_Euc_temp);
Rsoil_R3c0 = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        Rsoil_R3c0(i,1) = Rsoil_r3c0_temp(Locb(i),1);
    end
end
clearvars Rsoil_r3c0_temp DateTime_Euc_temp use i Lia Locb n Tsoil_r3c0_temp;

% Fit 48 Q10s each day (1 per half-hour time lag, from 0 to 1 day lag), on
% a moving window
% Retrieve the best fit time lag
days_mw = 10; % size of the moving window in days
these = []; % initialize these
hour_t = hour(DateTime_EucR3);
minute_t = minute(DateTime_EucR3);
All_midnight = find(hour_t == 0 & minute_t == 0);
n = length(All_midnight);
m = length(DateTime_EucR3);
lag = nan(n,1);
rsq = nan(48,1);
Q10 = nan(48,1);
Rref = nan(48,1);
rsqopt = nan(n,1);
Q10opt = nan(n,1);
Rrefopt = nan(n,1);
Tsavg = nan(n,1);
SWCavg = nan(n,1);
for d = 1:n % n days 
    Window_centre = All_midnight(d); % find the element number corresponding to that day (midnight)
    if isempty(Window_centre) == 0 && Window_centre-48*(days_mw/2) > 0 && Window_centre+48*(days_mw/2) <= m
        these = (Window_centre - 48*(days_mw/2) : 1 : Window_centre + 48*(days_mw/2)); % these is the data inside the moving window, center +- size/2
    elseif isempty(Window_centre) == 0 && Window_centre-48*(days_mw/2) <= 0 % We look at X month of data ahead of time: does this data exist?
        these = (Window_centre : 1 : Window_centre + 48*days_mw);    
    elseif isempty(Window_centre) == 0 && Window_centre-48*(days_mw/2) > m % We look at 3 month of data backward in time: does this data exist?
        these = (Window_centre - 48*days_mw/2 : 1 : Window_centre);
    end
    if isempty(these) == 0 && sum(~isnan(Rsoil_R3c0(these))) >= 300 % We run the following code only if there is data in that time window. These is data from the current window. (window centre = year y and day d)
        for p = 1:48 % 0 half-hour lag to 7 day lag
        Tsoil_past = nan(m,1);
        Tsoil_past(p:m) = T5cm_1_R3(1:m-(p-1));
        try % if Q10 can't fit, will jump to next p
        [beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x,conf] ...
            = Q10FIT(Tsoil_past,Rsoil_R3c0,these,nanmin(Tsoil_past(these)),nanmax(Tsoil_past(these)));
        catch % I could do something when error occur, such as writing a message...
            % nothing to do
            continue % next p
        end
        rsq(p) = rsq_Q10;
        Q10(p) = beta_Q10(2);
        Rref(p) = beta_Q10(1);
        end
        lagopt = find(rsq == nanmax(rsq));
        lag(d,1) = lagopt;
        rsqopt(d,1) = rsq(lagopt);
        Q10opt(d,1) = Q10(lagopt);
        Rrefopt(d,1) = Rref(lagopt);
        Tsavg(d,1) = nanmean(Tsoil_past(these));
        SWCavg(d,1) = nanmean(SWC_R3(these));
    end
end

Midnight_DT = DateTime_EucR3(All_midnight);
figure; subplot(7,1,1); plot(DateTime_EucR3,Rsoil_R3c0); ylabel('Rsoil');
subplot(7,1,2); plot(DateTime_EucR3,T5cm_1_R3); ylabel('Tsoil');
subplot(7,1,3); plot(DateTime_EucR3,SWC_R3); ylabel('SWC');
subplot(7,1,4); plot(Midnight_DT,(lag-1)/2); ylabel('lag (h)');
subplot(7,1,5); plot(Midnight_DT,rsqopt); ylabel('r^2');
subplot(7,1,6); plot(Midnight_DT,Q10opt); ylabel('Q10'); ylim([0 5]);
subplot(7,1,7); plot(Midnight_DT,Rrefopt); ylabel('Rref');
for i = 1:7
   subplot(7,1,i); xlim([datenum(datetime(2013,9,1)) datenum(datetime(2015,12,1))]);
end
subplot(7,1,4); ylim([0 24]);

lagh = (lag-1)/2;
figure; 
subplot(4,1,1); scatter(Tsavg,Q10opt,10,SWCavg); xlabel('Soil temperature'); ylabel('Q10opt'); ylim([0 5]); xlim([9 26]);
hold on; binplot(Tsavg(SWCavg > nanmedian(SWCavg)),Q10opt(SWCavg > nanmedian(SWCavg)),3,'y',1);
hold on; binplot(Tsavg(SWCavg < nanmedian(SWCavg)),Q10opt(SWCavg < nanmedian(SWCavg)),3,'b',1);
subplot(4,1,2); scatter(Tsavg,Rrefopt,10,SWCavg); xlabel('Soil temperature'); ylabel('Rrefopt'); xlim([9 26]);
hold on; binplot(Tsavg(SWCavg > nanmedian(SWCavg)),Rrefopt(SWCavg > nanmedian(SWCavg)),3,'y',1);
hold on; binplot(Tsavg(SWCavg < nanmedian(SWCavg)),Rrefopt(SWCavg < nanmedian(SWCavg)),3,'b',1);
subplot(4,1,3); scatter(Tsavg,lagh,10,SWCavg); xlabel('Soil temperature'); ylabel('lag (hour)'); xlim([9 26]);
hold on; binplot(Tsavg(SWCavg > nanmedian(SWCavg)),lagh(SWCavg > nanmedian(SWCavg)),3,'y',1);
hold on; binplot(Tsavg(SWCavg < nanmedian(SWCavg)),lagh(SWCavg < nanmedian(SWCavg)),3,'b',1);
subplot(4,1,4); scatter(Tsavg,rsqopt,10,SWCavg); xlabel('Soil temperature'); ylabel('r^2 Q10opt'); xlim([9 26]);
hold on; binplot(Tsavg(SWCavg > nanmedian(SWCavg)),rsqopt(SWCavg > nanmedian(SWCavg)),3,'y',1);
hold on; binplot(Tsavg(SWCavg < nanmedian(SWCavg)),rsqopt(SWCavg < nanmedian(SWCavg)),3,'b',1);
subplot(4,1,1); c = colorbar('northoutside'); c.Label.String = 'SWC';
c.FontSize = 9;
