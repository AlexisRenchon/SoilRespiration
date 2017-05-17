% Load raw data (.csv file)
% Location of raw input file
source_Euc = 'Input\Input EucFACE\EucFACE_Rsoil_met.csv';
% Create datastore to access collection of data
ds_Euc = datastore(source_Euc);
% Select variable of interest
ds_Euc.SelectedVariableNames = {'DateTime_Euc_c','Rsoil_R3c0','Ta_HMP155','PAR'}; 
%ds_Euc.TreatAsMissing = 'NA';
% Read selected variables, save it in the workspace as a table
Euc_Data = readall(ds_Euc);
% Get data from the table, change format if necessary
DateTime_Euc_c = Euc_Data.DateTime_Euc_c;
DateTime_Euc = datetime(DateTime_Euc_c,'InputFormat','dd/MM/yyyy HH:mm');
R3c0 = Euc_Data.Rsoil_R3c0;
R1c3 = Euc_Data.Rsoil_R1c3;
R1c5 = Euc_Data.Rsoil_R1c5;
R2c4 = Euc_Data.Rsoil_R2c4;
R2c6 = Euc_Data.Rsoil_R2c6;
R3c2 = Euc_Data.Rsoil_R3c2;
R4c0 = Euc_Data.Rsoil_R4c0;
R4c2 = Euc_Data.Rsoil_R4c2;
R5c6 = Euc_Data.Rsoil_R5c6;
R5c7 = Euc_Data.Rsoil_R5c7;
R6c0 = Euc_Data.Rsoil_R6c0;
R6c3 = Euc_Data.Rsoil_R6c3;
Ta = Euc_Data.Ta_HMP155;
PAR = Euc_Data.PAR;
% clear unused variables
clearvars Date_Euc Time_Euc Euc_Data ds_Euc source_Euc;


for i = 1:n
mean_Euc(i,1) = nanmean([R1c3(i) R1c5(i) R2c4(i) R2c6(i) R3c2(i) R3c0(i) R4c0(i) R4c2(i) R5c6(i) R5c7(i) ...
    R6c0(i) R6c3(i) ]);
end

hold on; plot(DateTime_RsoilCUP,RsoilCUP,'g');
datetick('x','mYY');

use = find(qc == 0 & qc_Sc == 0 & u > 0.2 & AGC_c == 0);
NEE_qc = NEE_c(use);
DateTime_CUPqc = DateTime_CUP(use);
daytime_qc = daytime(use);
n = length(DateTime_Euc_c);
[Lia,Locb] = ismember(DateTime_Euc,DateTime_CUPqc);
NEE_qc_c = nan(n,1);
daytime_qc_c = nan(n,1);
for i = 1:n
    if Locb(i) > 0
        NEE_qc_c(i,1) = NEE_qc(Locb(i),1);
        daytime_qc_c(i,1) = daytime_qc(Locb(i),1);
    end
end
clearvars Rsoil_r6c3_temp DateTime_Euc_temp use i Lia Locb n;

GPP_AR = NEE_qc_c - mean_Euc;

x_p = [7.5 7.5 7.5 12.5 12.5 12.5 17.5 17.5 17.5 22.5 22.5 22.5 27.5 27.5 27.5 32.5 32.5 32.5];
y_p(1:3) = quantile(GPP_AR(daytime_qc_c == 0 & Ta > 5 & Ta < 10),[0.25 0.5 0.75]);
y_p(4:6) = quantile(GPP_AR(daytime_qc_c == 0 & Ta > 10 & Ta < 15),[0.25 0.5 0.75]);
y_p(7:9) = quantile(GPP_AR(daytime_qc_c == 0 & Ta > 15 & Ta < 20),[0.25 0.5 0.75]);
y_p(10:12) = quantile(GPP_AR(daytime_qc_c == 0 & Ta > 20 & Ta < 25),[0.25 0.5 0.75]);
y_p(13:15) = quantile(GPP_AR(daytime_qc_c == 0 & Ta > 25 & Ta < 30),[0.25 0.5 0.75]);
y_p(16:18) = quantile(GPP_AR(daytime_qc_c == 0 & Ta > 30 & Ta < 35),[0.25 0.5 0.75]);
figure; scatter(x_p,y_p);

params = sigm_fit(x_pm,y_pm);
n = length(Ta);
for i = 1:n
    AR_fT(i,1) = params(1)+(params(2)-params(1))/(1+10^((params(3)-Ta(i))*params(4)));
end

ER_new = AR_fT + mean_Euc;
GPP_new = GPP_AR - AR_fT;
use = find(qc == 0 & qc_Sc == 0 & AGC_c == 0 & u > 0.2 & daytime == 1);
figure; scatter(PAR(use),GPP_new(use),20,Ta(use));

use = find(qc == 0 & qc_Sc == 0 & AGC_c == 0 & u > 0.2 & daytime == 1);
hold on; plot(DateTime_CUP(use),NEE_c(use));



x_p = [7.5 7.5 7.5 12.5 12.5 12.5 17.5 17.5 17.5 22.5 22.5 22.5 27.5 27.5 27.5 32.5 32.5 32.5];
y_p(1:3) = quantile(GPP_AR(daytime_qc_c == 0 & Ta > 5 & Ta < 10 & month(DateTime_Euc) >= 5 & month(DateTime_Euc) <= 8),[0.25 0.5 0.75]);
y_p(4:6) = quantile(GPP_AR(daytime_qc_c == 0 & Ta > 10 & Ta < 15 & month(DateTime_Euc) >= 5 & month(DateTime_Euc) <= 8),[0.25 0.5 0.75]);
y_p(7:9) = quantile(GPP_AR(daytime_qc_c == 0 & Ta > 15 & Ta < 20 & month(DateTime_Euc) >= 5 & month(DateTime_Euc) <= 8),[0.25 0.5 0.75]);
y_p(10:12) = quantile(GPP_AR(daytime_qc_c == 0 & Ta > 20 & Ta < 25 & month(DateTime_Euc) >= 5 & month(DateTime_Euc) <= 8),[0.25 0.5 0.75]);
y_p(13:15) = quantile(GPP_AR(daytime_qc_c == 0 & Ta > 25 & Ta < 30 & month(DateTime_Euc) >= 5 & month(DateTime_Euc) <= 8),[0.25 0.5 0.75]);
y_p(16:18) = quantile(GPP_AR(daytime_qc_c == 0 & Ta > 30 & Ta < 35 & month(DateTime_Euc) >= 5 & month(DateTime_Euc) <= 8),[0.25 0.5 0.75]);
figure; scatter(x_p,y_p);

x_p = [7.5 7.5 7.5 12.5 12.5 12.5 17.5 17.5 17.5 22.5 22.5 22.5 27.5 27.5 27.5 32.5 32.5 32.5];
y_p(1:3) = quantile(GPP_AR(daytime_qc_c == 0 & Ta > 5 & Ta < 10 & (month(DateTime_Euc) >= 10 | month(DateTime_Euc) <= 3)),[0.25 0.5 0.75]);
y_p(4:6) = quantile(GPP_AR(daytime_qc_c == 0 & Ta > 10 & Ta < 15 & (month(DateTime_Euc) >= 10 | month(DateTime_Euc) <= 3)),[0.25 0.5 0.75]);
y_p(7:9) = quantile(GPP_AR(daytime_qc_c == 0 & Ta > 15 & Ta < 20 & (month(DateTime_Euc) >= 10 | month(DateTime_Euc) <= 3)),[0.25 0.5 0.75]);
y_p(10:12) = quantile(GPP_AR(daytime_qc_c == 0 & Ta > 20 & Ta < 25 & (month(DateTime_Euc) >= 10 | month(DateTime_Euc) <= 3)),[0.25 0.5 0.75]);
y_p(13:15) = quantile(GPP_AR(daytime_qc_c == 0 & Ta > 25 & Ta < 30 & (month(DateTime_Euc) >= 10 | month(DateTime_Euc) <= 3)),[0.25 0.5 0.75]);
y_p(16:18) = quantile(GPP_AR(daytime_qc_c == 0 & Ta > 30 & Ta < 35 & (month(DateTime_Euc) >= 10 | month(DateTime_Euc) <= 3)),[0.25 0.5 0.75]);
hold on; scatter(x_p,y_p);

% Light inhibition: 30% of AR if daytime
n = length(DateTime_Euc);
AR_fT_LI = AR_fT;
for i = 1:n
   if PAR(i) > 20
       AR_fT_LI(i) = AR_fT(i)*0.7;
   end
end

ER_new_LI = mean_Euc + AR_fT_LI;

hold on; plot(DateTime_Euc,ER_new_LI);

figure;
subplot(4,1,1); hold off; hold on;
scatter(datenum(DateTime_CUP),ER,5,[0.3 1 0.3]);
scatter(datenum(DateTime_Euc),ER_new,5,'c');
scatter(datenum(DateTime_Euc),mean_Euc,5,'k');
h = legend('Reco standard','Reco new','Rsoil');
h.FontSize = 6;
ylabel('Rsoil (\mumol m^-^2 s^-^1)'); datetick('x','mmm yy');
ax = gca; ax.FontSize = 12;

subplot(4,1,2);
scatter(datenum(DateTime_Euc),mean(horzcat(Euc_Data.FM1,Euc_Data.FM2,Euc_Data.FM3),2),5,[0 0 1]);
hold on; scatter(datenum(DateTime_Euc),mean(horzcat( ...
    Euc_Data.SWC5cm_1_R1,Euc_Data.SWC5cm_2_R1,Euc_Data.SWC5cm_1_R2,Euc_Data.SWC5cm_2_R2,Euc_Data.SWC5cm_1_R3,Euc_Data.SWC5cm_2_R3,Euc_Data.SWC5cm_1_R4,Euc_Data.SWC5cm_2_R4,Euc_Data.SWC5cm_1_R5,Euc_Data.SWC5cm_2_R5,Euc_Data.SWC5cm_1_R6,Euc_Data.SWC5cm_2_R6),2),5,[0.3 0.3 1]);
hold on; scatter(datenum(DateTime_Euc),mean(horzcat( ...
    Euc_Data.SWC30cm_1_R1,Euc_Data.SWC30cm_2_R1,Euc_Data.SWC30cm_1_R2,Euc_Data.SWC30cm_2_R2,Euc_Data.SWC30cm_1_R3,Euc_Data.SWC30cm_2_R3,Euc_Data.SWC30cm_1_R4,Euc_Data.SWC30cm_2_R4,Euc_Data.SWC30cm_1_R5,Euc_Data.SWC30cm_2_R5,Euc_Data.SWC30cm_1_R6,Euc_Data.SWC30cm_2_R6),2),5,[0.5 0.5 1]);
hold on; scatter(datenum(DateTime_Euc),mean(horzcat( ...
    Euc_Data.SWC75cm_1_R1,Euc_Data.SWC75cm_2_R1,Euc_Data.SWC75cm_1_R2,Euc_Data.SWC75cm_2_R2,Euc_Data.SWC75cm_1_R3,Euc_Data.SWC75cm_2_R3,Euc_Data.SWC75cm_1_R4,Euc_Data.SWC75cm_2_R4,Euc_Data.SWC75cm_1_R5,Euc_Data.SWC75cm_2_R5,Euc_Data.SWC75cm_1_R6,Euc_Data.SWC75cm_2_R6),2),5, [0.8 0.8 1]);
h = legend('0 cm','0-5 cm','5-30 cm','30-75 cm');
h.FontSize = 6;
%h.Location = 'northeastoutside';
datetick('x','mmm yy');
ylabel('Soil moisture (%)');
ax = gca; ax.FontSize = 12;

subplot(4,1,3);
scatter(datenum(DateTime_Euc),Euc_Data.Rain,5,'k');
ylabel('Precip (mm)'); datetick('x','mmm yy');
ax = gca; ax.FontSize = 12;

subplot(4,1,4); 
hold on; scatter(datenum(DateTime_Euc),nanmean(horzcat( ...
    Euc_Data.Ts5_1_R1,Euc_Data.Ts5_2_R1,Euc_Data.Ts5_1_R2,Euc_Data.Ts5_2_R2,Euc_Data.Ts5_1_R3,Euc_Data.Ts5_2_R3,Euc_Data.Ts5_1_R4,Euc_Data.Ts5_2_R4,Euc_Data.Ts5_1_R5,Euc_Data.Ts5_2_R5,Euc_Data.Ts5_1_R6,Euc_Data.Ts5_2_R6),2),5,[1 0 1]);
hold on; scatter(datenum(DateTime_Euc),nanmean(horzcat( ...
    Euc_Data.Ts10_1_R1,Euc_Data.Ts10_2_R1,Euc_Data.Ts10_1_R2,Euc_Data.Ts10_2_R2,Euc_Data.Ts10_1_R3,Euc_Data.Ts10_2_R3,Euc_Data.Ts10_1_R4,Euc_Data.Ts10_2_R4,Euc_Data.Ts10_1_R5,Euc_Data.Ts10_2_R5,Euc_Data.Ts10_1_R6,Euc_Data.Ts10_2_R6),2),5,[1 0.2 1]);
hold on; scatter(datenum(DateTime_Euc),nanmean(horzcat( ...
    Euc_Data.Ts30_1_R1,Euc_Data.Ts30_2_R1,Euc_Data.Ts30_1_R2,Euc_Data.Ts30_2_R2,Euc_Data.Ts30_1_R3,Euc_Data.Ts30_2_R3,Euc_Data.Ts30_1_R4,Euc_Data.Ts30_2_R4,Euc_Data.Ts30_1_R5,Euc_Data.Ts30_2_R5,Euc_Data.Ts30_1_R6,Euc_Data.Ts30_2_R6),2),5,[1 0.4 1]);
hold on; scatter(datenum(DateTime_Euc),nanmean(horzcat( ...
    Euc_Data.Ts50_1_R1,Euc_Data.Ts50_2_R1,Euc_Data.Ts50_1_R2,Euc_Data.Ts50_2_R2,Euc_Data.Ts50_1_R3,Euc_Data.Ts50_2_R3,Euc_Data.Ts50_1_R4,Euc_Data.Ts50_2_R4,Euc_Data.Ts50_1_R5,Euc_Data.Ts50_2_R5,Euc_Data.Ts50_1_R6,Euc_Data.Ts50_2_R6),2),5,[1 0.6 1]);
hold on; scatter(datenum(DateTime_Euc),nanmean(horzcat( ...
    Euc_Data.Ts100_1_R1,Euc_Data.Ts100_2_R1,Euc_Data.Ts100_1_R2,Euc_Data.Ts100_2_R2,Euc_Data.Ts100_1_R3,Euc_Data.Ts100_2_R3,Euc_Data.Ts100_1_R4,Euc_Data.Ts100_2_R4,Euc_Data.Ts100_1_R5,Euc_Data.Ts100_2_R5,Euc_Data.Ts100_1_R6,Euc_Data.Ts100_2_R6),2),5,[1 0.8 1]);
h = legend('5 cm','10 cm','30 cm','50 cm','100 cm');
h.FontSize = 6;
%h.Location = 'northeastoutside';
datetick('x','mmm yy');
ylabel('Soil temperature (°C)');
ax = gca; ax.FontSize = 12;

% Zoom in, Zoom out (highlight and F9 to run section)

% February 2014, small continuous rain event, higher SR at night
for i = 1:4
    subplot(4,1,i);
    xlim([datenum(datetime(2014,02,12)) datenum(datetime(2014,02,18))]);
    datetick('x','dd-mmm-yyyy');
end
subplot(4,1,4); ylim([20 30]);
subplot(4,1,3); ylim([0 1]);

% November 2014, local big rain event
for i = 1:4
    subplot(4,1,i);
    xlim([datenum(datetime(2014,11,21)) datenum(datetime(2014,11,28))]);
    datetick('x','dd-mmm-yyyy');
end
subplot(4,1,3); ylim([0 20]);

% 2012 to 2017
for i = 1:4
    subplot(4,1,i);
    xlim([datenum(datetime(2012,01,01)) datenum(datetime(2017,01,01))]);
    datetick('x','mmm yy');
end
subplot(4,1,1); ylim([0 15]);
subplot(4,1,4); ylim([5 30]);
subplot(4,1,3); ylim([0 20]);

