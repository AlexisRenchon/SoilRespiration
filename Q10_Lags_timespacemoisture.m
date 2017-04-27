% TO DO: 
% add precipitations, 12 hour earlier precip, 24h earlier precip and 48h
% earlier precip

% discard precip half-hour and post-rain half-hour (up to a threshold in the past).

% in the remaining data, there should be no rain pulse effect

% For processing here under, just look at data between precipitation events

% calculate, for each month (or each 2-3-4? month), for each collar, a Q10 of R vs. T, with
% a lag of 1,2,3, ... 24 hour. Which lag has the highest r-square? plot
% RMSE vs. time lag (as in "A la recherche d'un algorithme de partition
% robuste, MA, slide 10)

% Question: Does a lag enhance the correlation? does this lag change
% between collars? does this lag change with soil moisture? does this lag
% change between years? does this lag change between seasons? 

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Data processing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

use = find(strcmp(Campaign_Euc, 'Auto') & Ring_Euc == 3 & Collar_Euc == 0);
n = length(DateTime_Euc);

for p = 1:336 % 0 half-hour lag to 7 day lag
    Tsoil_past = nan(n,1);
    Tsoil_past(p:n) = Tsoil_Euc(1:n-(p-1));
    [beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x,conf] ...
        = Q10FIT(Tsoil_past,Rsoil_Euc,use,nanmin(Tsoil_past(use)),nanmax(Tsoil_past(use)));
    rsq(p) = rsq_Q10;
end

scatter(1:336,rsq,'k');
figure;    
i = 1; 
for r = 1:6
    for c = 0:7
    use = find(strcmp(Campaign_Euc, 'Auto') & Ring_Euc == r & Collar_Euc == c);
    if length(use) > 5000
        for p = 1:336 % 0 half-hour lag to 7 day lag
        Tsoil_past = nan(n,1);
        Tsoil_past(p:n) = Tsoil_Euc(1:n-(p-1));
        for j = p:n
            if Ring_Euc(j) ~= Ring_Euc(j-p+1) % condition to nan past Tsoil_past if it does not correspond to its ring
                Tsoil_past(j) = nan;
            end
            if Collar_Euc(j) ~= Collar_Euc(j-p+1) % condition to nan past Tsoil_past if it does not correspond to its collar 
                Tsoil_past(j) = nan;
            end
        end
        [beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x,conf] ...
            = Q10FIT(Tsoil_past,Rsoil_Euc,use,nanmin(Tsoil_past(use)),nanmax(Tsoil_past(use)));
        rsq(p) = rsq_Q10;
        end
        subplot(4,4,i); scatter(1:336,rsq,'k');
        title(sprintf('EucFACE ring %d collar %d',r,c));
        xlabel('half-hour lag');
        ylabel('r-square');
        i = i + 1;
    end
    end
end



% by soil moisture

figure;    
i = 1; 
SWCbinedges = quantile(VWC_Euc,0:1/4:1);
rsq = nan(48,1);
for w = 1:4 % 4 quantiles of SWC
    use = find(strcmp(Campaign_Euc, 'Auto') & Ring_Euc == 3 & Collar_Euc == 0 & VWC_Euc > SWCbinedges(w) & VWC_Euc < SWCbinedges(w+1));
    if length(use) > 500
        for p = 1:48 % 0 half-hour lag to 1 day lag
        Tsoil_past = nan(n,1);
        Tsoil_past(p:n) = Tsoil_Euc(1:n-(p-1));
        for j = p:n
            if Ring_Euc(j) ~= Ring_Euc(j-p+1) % condition to nan past Tsoil_past if it does not correspond to its ring
                Tsoil_past(j) = nan;
            end
            if Collar_Euc(j) ~= Collar_Euc(j-p+1) % condition to nan past Tsoil_past if it does not correspond to its collar 
                Tsoil_past(j) = nan;
            end
        end
        [beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x,conf] ...
            = Q10FIT(Tsoil_past,Rsoil_Euc,use,nanmin(Tsoil_past(use)),nanmax(Tsoil_past(use)));
        rsq(p,1) = rsq_Q10;
        end
        subplot(2,2,i); hold on; scatter(0:47,rsq,'k');
        title(sprintf('SWC quantile %d',w));
        xlabel('half-hour lag');
        ylabel('r-square');
        xlim([0 47])
        i = i + 1;
    end
end



% by month

figure;    
i = 1; 
rsq = nan(48,1);
for m = 1:12 % month 1 to 12
    use = find(strcmp(Campaign_Euc, 'Auto') & Ring_Euc == 3 & Collar_Euc == 0 & month(DateTime_Euc) == m & year(DateTime_Euc) == 2014);
    if length(use) > 100
        for p = 1:48 % 0 half-hour lag to 1 day lag
        Tsoil_past = nan(n,1);
        Tsoil_past(p:n) = Tsoil_Euc(1:n-(p-1));
        for j = p:n
            if Ring_Euc(j) ~= Ring_Euc(j-p+1) % condition to nan past Tsoil_past if it does not correspond to its ring
                Tsoil_past(j) = nan;
            end
            if Collar_Euc(j) ~= Collar_Euc(j-p+1) % condition to nan past Tsoil_past if it does not correspond to its collar 
                Tsoil_past(j) = nan;
            end
        end
        [beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x,conf] ...
            = Q10FIT(Tsoil_past,Rsoil_Euc,use,nanmin(Tsoil_past(use)),nanmax(Tsoil_past(use)));
        rsq(p,1) = rsq_Q10;
        end
        subplot(3,4,i); hold on; scatter(0:47,rsq,'k');
        title(sprintf('Month %d',m));
        xlabel('half-hour lag');
        ylabel('r-square');
        xlim([0 47])
        i = i + 1;
    end
end
