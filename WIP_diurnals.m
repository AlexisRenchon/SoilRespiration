% Fun: 3d plot
% use = find(daytime_Euc == 1 & Ring_Euc == 3 & Collar_Euc == 0 & month(DateTime_Euc) == 1);
% figure; scatter3(VWC_Euc(use),Tsoil_Euc(use),Rsoil_Euc(use),'MarkerEdgeColor','none','MarkerFaceColor','r','SizeData',2)
% use = find(daytime_Euc == 0 & Ring_Euc == 3 & Collar_Euc == 0 & month(DateTime_Euc) == 1);
% hold on; scatter3(VWC_Euc(use),Tsoil_Euc(use),Rsoil_Euc(use),'MarkerEdgeColor','none','MarkerFaceColor','b','SizeData',2)
% axis([0 0.4 5 35 0 10])

% HARVARD 
ratio = nan(12,4);
for y = 2003:2006
    figure;
    for m = 1:12
        Mean_Co2_data = nan(23,1);
        Mean_Co2_model = nan(23,1);
        if length(find(find(month(DateTime_Har) == m & daytime_Har == 0 & isnan(Rsoil_Har) == 0 & isnan(Tsoil_Har) == 0 & year(DateTime_Har) == y))) > 50
            [beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x,conf] = Q10FIT(Tsoil_Har,Rsoil_Har,find(month(DateTime_Har) == m & ...
            daytime_Har == 0 & year(DateTime_Har) == y),nanmin(Tsoil_Har(month(DateTime_Har) == m & daytime_Har == 0 & year(DateTime_Har) == y)),nanmax(Tsoil_Har(month(DateTime_Har) == m & daytime_Har == 0 & year(DateTime_Har) == y)));
            use = find (daytime_Har == 1 & month(DateTime_Har) == m & isnan(Rsoil_Har) == 0 & isnan(Tsoil_Har) == 0 & year(DateTime_Har) == y);
            ratio(m,y-2002) = sum(NEE_Q10_ALL(use))/sum(Rsoil_Har(use));
            for h = 1:23
                use = find(month(DateTime_Har) == m & isnan(Rsoil_Har) == 0 & isnan(Tsoil_Har) == 0 & year(DateTime_Har) == y & hour(DateTime_Har) == h);
                Mean_Co2_data(h) = nanmean(Rsoil_Har(use)); 
                Mean_Co2_model(h) = nanmean(NEE_Q10_ALL(use));
            end
                subplot(3,4,m); hold on; p1 = plot(1:23,Mean_Co2_data,'k','LineWidth',2); p2 = plot(1:23,Mean_Co2_model,'k--','LineWidth',2);  
                lgd = legend('Data','Night Q10 model'); lgd.FontSize = 8; legend('boxoff');
                text(0.02,0.98,'ratio daytime model/data:','Units', 'Normalized', 'VerticalAlignment', 'Top');
                text(0.02,0.88,num2str(ratio(m,y-2002)),'Units', 'Normalized', 'VerticalAlignment', 'Top');
                %TO DO: add shade for nighttime
                title(sprintf('Harvard %d %d',y,m));
                ax = gca; ax.FontSize = 14;
                ax.XTick = 0:2:24; ax.YTick = 0:2:10;
                xlabel('Hour of the day');
                ylabel('Soil respiration');
                axis([0 24 0 10]);
        end
    end
end

% EucFACE
% TO DO: plot diurnal of each ring separately, with defined color for each ring. 
% I hypothesise that some ring will be constantly lagged, some other not, depending on tree proximity (deep root or not), deep root will have higher SR during night?  
ratio = nan(12,4);
for y = 2012:2015 % each year
    figure;
    for m = 1:12 % each month
        Mean_Co2_data = nan(23,1);
        Mean_Co2_model = nan(23,1);
        if length(find(find(month(DateTime_Euc) == m & daytime_Euc == 0 & isnan(Rsoil_Euc) == 0 & isnan(Tsoil_Euc) == 0 & year(DateTime_Euc) == y))) > 50
            [beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x,conf] = Q10FIT(Tsoil_Euc,Rsoil_Euc,find(month(DateTime_Euc) == m & ...
            daytime_Euc == 0 & year(DateTime_Euc) == y),nanmin(Tsoil_Euc(month(DateTime_Euc) == m & daytime_Euc == 0 & year(DateTime_Euc) == y)),nanmax(Tsoil_Euc(month(DateTime_Euc) == m & daytime_Euc == 0 & year(DateTime_Euc) == y)));
            use = find (daytime_Euc == 1 & month(DateTime_Euc) == m & isnan(Rsoil_Euc) == 0 & isnan(Tsoil_Euc) == 0 & year(DateTime_Euc) == y);
            ratio(m,y-2011) = sum(NEE_Q10_ALL(use))/sum(Rsoil_Euc(use));
            for h = 1:23
                use = find(month(DateTime_Euc) == m & isnan(Rsoil_Euc) == 0 & isnan(Tsoil_Euc) == 0 & year(DateTime_Euc) == y & hour(DateTime_Euc) == h);
                Mean_Co2_data(h) = nanmean(Rsoil_Euc(use)); 
                Mean_Co2_model(h) = nanmean(NEE_Q10_ALL(use));
            end
                subplot(3,4,m); hold on; p1 = plot(1:23,Mean_Co2_data,'k','LineWidth',2); p2 = plot(1:23,Mean_Co2_model,'k--','LineWidth',2);  
                lgd = legend('Data','Night Q10 model'); lgd.FontSize = 8; legend('boxoff');
                text(0.02,0.98,'ratio daytime model/data:','Units', 'Normalized', 'VerticalAlignment', 'Top');
                text(0.02,0.88,num2str(ratio(m,y-2011)),'Units', 'Normalized', 'VerticalAlignment', 'Top');
                %TO DO: add shade for nighttime
                title(sprintf('EucFACE %d %d',y,m));
                ax = gca; ax.FontSize = 14;
                ax.XTick = 0:2:24; ax.YTick = 0:2:10;
                xlabel('Hour of the day');
                ylabel('Soil respiration');
                axis([0 24 0 10]);
        end
    end
end

for y = 2012:2015 % each year
    figure;
    for r = 1:6
        for c = 0:7
            for m = 1:12 % each month
                Mean_Co2_data = nan(23,1);
                Mean_Co2_model = nan(23,1);
                if length(find(find(month(DateTime_Euc) == m & daytime_Euc == 0 & isnan(Rsoil_Euc) == 0 & isnan(Tsoil_Euc) == 0 & year(DateTime_Euc) == y & Ring_Euc == r & Collar_Euc == c))) > 50
                    for h = 1:23
                        use = find(month(DateTime_Euc) == m & isnan(Rsoil_Euc) == 0 & isnan(Tsoil_Euc) == 0 & year(DateTime_Euc) == y & hour(DateTime_Euc) == h & Ring_Euc == r & Collar_Euc == c);
                        Mean_Co2_data(h) = nanmean(Rsoil_Euc(use)); 
                    end
                        subplot(3,4,m); hold on; p1 = plot(1:23,Mean_Co2_data); 
                        lgd = legend('Data'); lgd.FontSize = 8; legend('boxoff');
                        %TO DO: add shade for nighttime
                        title(sprintf('EucFACE %d %d',y,m));
                        ax = gca; ax.FontSize = 14;
                        ax.XTick = 0:2:24; ax.YTick = 0:2:10;
                        xlabel('Hour of the day');
                        ylabel('Soil respiration');
                        axis([0 24 0 10]);
                end
            end
        end
    end
end

% Wombat
