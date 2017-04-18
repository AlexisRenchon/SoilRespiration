% Q10 fit function 
% Alexis code, written 08/11/2016

function [beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10,rsq_Q10,NEE_Q10_ALL,Tref,Rplot_y,Rplot_x,conf] = Q10FIT(X,Y,Condition,minT,maxT)
% minR and maxR should be optional (I use it for SoilR_EucF.m). How to add optional input in a
% function? I know it's doable but I have never done it.
% Condition example = find(qc == 0 & qc_Sc == 0 & AGC_c == 0 & u > 0.2 & isnan(NEE) == 0 & daytime == 0 & year_t == 2015);
Dep_var = Y(Condition);
Ind_var = X(Condition);
Tref = nanmedian(Ind_var);

Model_Q10 = @(Param,Ind_var) Param(1)*Param(2).^((Ind_var(:,1)-Tref)./10);
Ini_param = [4 1.5]; % Rtref, Q10
[beta_Q10,R_Q10,J_Q10,CovB_Q10,MSE_Q10,ErrorModelInfo_Q10] = nlinfit(Ind_var,Dep_var,Model_Q10,Ini_param);

NEE_Q10 = Model_Q10(beta_Q10,Ind_var);
NEE_Q10_ALL = Model_Q10(beta_Q10,X);
Rplot_x = minT:0.1:maxT;
Rplot_y = Model_Q10(beta_Q10,Rplot_x');
% Calculation of rsquare
C = corrcoef(Dep_var,NEE_Q10);
rsq_Q10 = C(1,2)^2;
conf = nlparci(beta_Q10,R_Q10,'jacobian',J_Q10);
end