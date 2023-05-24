%% IRFs
clc,clear;
close all;
cd 'C:\Users\lzkzz\Desktop\matlearn\Dynare_train\NK_aging_series\NK_aging_with_saving_research_fix'
phi_list=[0.55 0.85];
for ii=1:length(phi_list)
phi=phi_list(ii);
dynare NK_aging_research nolog
result_list(ii)=oo_;
end

oo_55=result_list(1);
oo_85=result_list(2);

%定常値
for j=1:length(oo_.var_list)
   eval(sprintf('steady_state.(oo_85.var_list{%d})=oo_.steady_state(%d);',j,j));
   eval(sprintf('steady_state55.(oo_55.var_list{%d})=oo_55.steady_state(%d);',j,j));
   eval(sprintf('steady_state85.(oo_85.var_list{%d})=oo_85.steady_state(%d);',j,j));
end
irfnames=fieldnames(oo_.irfs);
split_irfnames=split(irfnames,'_');
varlist=split_irfnames(:,1);
 for j=1:numel(irfnames)
     eval(sprintf('oo_.irfs.(irfnames{%d})=oo_.irfs.(irfnames{%d})./steady_state.(varlist{%d})*100;',j,j,j));
     eval(sprintf('oo_55.irfs.(irfnames{%d})=oo_55.irfs.(irfnames{%d})./steady_state55.(varlist{%d})*100;',j,j,j));
     eval(sprintf('oo_85.irfs.(irfnames{%d})=oo_85.irfs.(irfnames{%d})./steady_state85.(varlist{%d})*100;',j,j,j));
 end
oo_.irfs.R_epsgc=oo_.irfs.R_epsgc*steady_state.R;
oo_.irfs.rk_epsgc=oo_.irfs.rk_epsgc*steady_state.rk;
oo_.irfs.R_epsTR=oo_.irfs.R_epsTR*steady_state.R;
oo_.irfs.rk_epsTR=oo_.irfs.rk_epsTR*steady_state.rk;
oo_.irfs.R_epsINI=oo_.irfs.R_epsINI*steady_state.R;
oo_.irfs.rk_epsINI=oo_.irfs.rk_epsINI*steady_state.rk;

oo_55.irfs.R_epsgc=oo_55.irfs.R_epsgc*steady_state55.R;
oo_55.irfs.rk_epsgc=oo_55.irfs.rk_epsgc*steady_state55.rk;
oo_55.irfs.R_epsTR=oo_55.irfs.R_epsTR*steady_state55.R;
oo_55.irfs.rk_epsTR=oo_55.irfs.rk_epsTR*steady_state55.rk;
oo_55.irfs.R_epsINI=oo_55.irfs.R_epsINI*steady_state55.R;
oo_55.irfs.rk_epsINI=oo_55.irfs.rk_epsINI*steady_state55.rk;

oo_85.irfs.R_epsgc=oo_85.irfs.R_epsgc*steady_state85.R;
oo_85.irfs.rk_epsgc=oo_85.irfs.rk_epsgc*steady_state85.rk;
oo_85.irfs.R_epsTR=oo_85.irfs.R_epsTR*steady_state85.R;
oo_85.irfs.rk_epsTR=oo_85.irfs.rk_epsTR*steady_state85.rk;
oo_85.irfs.R_epsINI=oo_85.irfs.R_epsINI*steady_state85.R;
oo_85.irfs.rk_epsINI=oo_85.irfs.rk_epsINI*steady_state85.rk;

%画像設定
% width=600*1.618;
% height=600;
width=600*1.618;
height=600;


%% GC
endo_var_list=["GC" "Y" "C" "Cr" "Cw" "I" "h" "w" "T" "pi" "b" "rk" "R"];
endo_var_name=["GC" "Output" "Aggregate consumption" "Consumption of retirees" "Consumption of workers" "Investment" "Hours of work" "Real wage" "Tax" "Inflation rate" "Debt" "Real interest rate" "Nominal interest rate"];
shock_var_list=["epsgc"];
irf_list=[];
for i=1:length(shock_var_list)
    for j=1:length(endo_var_list)
        irf_name=append(endo_var_list(j),'_',shock_var_list(i));
        irf_list=[irf_list; irf_name];
    end
end

fig(1)=figure('Name','government consumption shock');
tcl = tiledlayout(5,3,'TileSpacing','compact','Padding','compact');
for i=1:length(endo_var_list)
    irf_a=append('oo_55.irfs.',irf_list(i));
    irf_b=append('oo_85.irfs.',irf_list(i));
    nexttile(tcl);
    x=0:length(eval(irf_a))-1;
    plot(x,eval(irf_a),'Color','blue','LineWidth',1.5); hold on;
    plot(x,eval(irf_b),'Color','red','LineWidth',1.5); hold on;
    yline(0,'--','Color','red','LineWidth',1);
    title(endo_var_name(i),'Color','black','FontSize',12);
    set(gca,'FontSize',12);
    set(gca,'FontName',"Times New Roman");
end
fig(1).Position = [0 0 width height]; %[left bottom width height]
lg=legend({'\phi=0.55','\phi=0.85'});
lg.Orientation='horizontal';
lg.Layout.Tile = 'south';
lg.FontSize=12;
set(gcf, 'PaperType', 'A4');
hold off;


%% GI
endo_var_list=["GI" "Y" "C" "Cr" "Cw" "I" "h" "w" "T" "pi" "b" "rk" "R"];
endo_var_name=["GI" "Output" "Aggregate consumption" "Consumption of retirees" "Consumption of workers" "Investment" "Hours of work" "Real wage" "Tax" "Inflation rate" "Debt"  "Real interest rate" "Nominal interest rate"];
shock_var_list=["epsgi"];
irf_list=[];
for i=1:length(shock_var_list)
    for j=1:length(endo_var_list)
        irf_name=append(endo_var_list(j),'_',shock_var_list(i));
        irf_list=[irf_list; irf_name];
    end
end

fig(2)=figure('Name','government investment shock');
tcl = tiledlayout(5,3,'TileSpacing','compact','Padding','compact');
for i=1:length(endo_var_list)
   irf_a=append('oo_55.irfs.',irf_list(i));
    irf_b=append('oo_85.irfs.',irf_list(i));
    nexttile(tcl);
    x=0:length(eval(irf_a))-1;
    plot(x,eval(irf_a),'Color','blue','LineWidth',1.5); hold on;
    plot(x,eval(irf_b),'Color','red','LineWidth',1.5); hold on;
    yline(0,'--','Color','red','LineWidth',1);
    set(gca,'FontSize',10);
    title(endo_var_name(i),'Color','black','FontSize',12);
    set(gca,'FontSize',12);
    set(gca,'FontName',"Times New Roman");
end
fig(2).Position = [0 0 width height]; %[left bottom width height]
lg=legend({'\phi=0.55','\phi=0.85'});
lg.Orientation='horizontal';
lg.Layout.Tile = 'south';
lg.FontSize=12;
hold off;

%% TFP
endo_var_list=["A" "Y" "C" "Cr" "Cw" "I" "h" "w" "T" "pi" "b" "rk" "R"];
endo_var_name=["TFP" "Output" "Aggregate consumption" "Consumption of retirees" "Consumption of workers" "Investment" "Hours of work" "Wage" "Tax" "Inflation rate" "Debt"  "Nominal interest rate" "Nominal interest rate"];
shock_var_list=["epsa"];
irf_list=[];
for i=1:length(shock_var_list)
    for j=1:length(endo_var_list)
        irf_name=append(endo_var_list(j),'_',shock_var_list(i));
        irf_list=[irf_list; irf_name];
    end
end
fig(3)=figure('Name','TFP shock');
for i=1:length(endo_var_list)
    irf=append('oo_.irfs.',irf_list(i));
    subplot(5,3,i);
    x=0:length(eval(irf))-1;
    plot(x,eval(irf),'Color','blue','LineWidth',1.5); hold on;
    yline(0,'--','Color','red','LineWidth',1);
    set(gca,'FontSize',12);
    set(gca,'FontName',"Times New Roman");
    title(endo_var_name(i),'Color','black','FontSize',12);
end
fig(3).Position = [0 0 width height]; %[left bottom width height]

%% Intangible Investment by Gov
endo_var_list=["INI" "A" "Y" "C" "Cr" "Cw" "I" "h" "w" "T" "pi" "b" "rk" "R" ];
endo_var_name=["R&D expenditure" "TFP" "Output" "Aggregate consumption" "Consumption of retirees" "Consumption of workers" "Investment" "Hours of work" "Real wage" "Tax" "Inflation rate" "Debt" "Real interest rate" "Nominal interest rate"];
shock_var_list=["epsINI"];
irf_list=[];
for i=1:length(shock_var_list)
    for j=1:length(endo_var_list)
        irf_name=append(endo_var_list(j),'_',shock_var_list(i));
        irf_list=[irf_list; irf_name];
    end
end

fig(4)=figure('Name','R&D expenditure shock');
tcl = tiledlayout(5,3,'TileSpacing','compact','Padding','compact');
for i=1:length(endo_var_list)
    irf_a=append('oo_55.irfs.',irf_list(i));
    irf_b=append('oo_85.irfs.',irf_list(i));
    
    nexttile(tcl);
    x=0:length(eval(irf))-1;
    plot(x,eval(irf_a),'Color','blue','LineWidth',1.5); hold on;
    plot(x,eval(irf_b),'Color','red','LineWidth',1.5); hold on;
    yline(0,'--','Color','red','LineWidth',1);
    set(gca,'FontSize',12);
    set(gca,'FontName',"Times New Roman");
    title(endo_var_name(i),'Color','black','FontSize',12);
end
fig(4).Position = [0 0 width height]; %[left bottom width height]
lg=legend({'\phi=0.55','\phi=0.85'});
lg.Orientation='horizontal';
lg.Layout.Tile = 'south';
lg.FontSize=12;
hold off;

%% TR by Gov
endo_var_list=["TR" "Y" "C" "Cr" "Cw" "I" "h" "w" "T" "pi" "b" "rk" "R" ];
endo_var_name=["Social security transfer" "Output" "Aggregate consumption" "Consumption of retirees" "Consumption of workers" "Investment" "Hours of work" "Real wage" "Tax" "Inflation rate" "Debt" "Real interest rate" "Nominal interest rate"];
shock_var_list=["epsTR"];
irf_list=[];
for i=1:length(shock_var_list)
    for j=1:length(endo_var_list)
        irf_name=append(endo_var_list(j),'_',shock_var_list(i));
        irf_list=[irf_list; irf_name];
    end
end

fig(5)=figure('Name','transfer shock');
tcl = tiledlayout(5,3,'TileSpacing','compact','Padding','compact');
for i=1:length(endo_var_list)
    irf_a=append('oo_55.irfs.',irf_list(i));
    irf_b=append('oo_85.irfs.',irf_list(i));
    
    nexttile(tcl);
    x=0:length(eval(irf))-1;
    plot(x,eval(irf_a),'Color','blue','LineWidth',1.5); hold on;
    plot(x,eval(irf_b),'Color','red','LineWidth',1.5); hold on;
    yline(0,'--','Color','red','LineWidth',1);
    set(gca,'FontSize',12);
    set(gca,'FontName',"Times New Roman");
    title(endo_var_name(i),'Color','black','FontSize',12);
end
fig(5).Position = [100 100 width height]; %[left bottom width height]
lg=legend({'\phi=0.55','\phi=0.85'});
lg.Orientation='horizontal';
lg.Layout.Tile = 'south';
lg.FontSize=12;
hold off;

% %消費の動きの確認
% %phi=0.55のケース
% phi1=0.55;
% %総消費
% C_55A=oo_55.irfs.C_epsTR*steady_state55.C;
% %労働者と高齢者の合成した消費
% C_55B=phi1*oo_55.irfs.Cw_epsTR*steady_state55.Cw +(1-phi1)*oo_55.irfs.Cr_epsTR*steady_state55.Cr;
% 
% %phi=0.85のケース
% phi2=0.85;
% C_85A=oo_85.irfs.C_epsTR*steady_state85.C;
% C_85B=phi2*oo_85.irfs.Cw_epsTR*steady_state85.Cw +(1-phi2)*oo_85.irfs.Cr_epsTR*steady_state85.Cr;
% 
% figure(100)
% plot(C_55A,'LineWidth',1.5);hold on;plot(C_55B,'LineWidth',1.5);hold on;
% plot(C_85A,'LineWidth',1.5);hold on;plot(C_85B,'LineWidth',1.5);hold off;
% legend({'\phi=0.55,総消費C','\phi=0.55,合成消費,\phi*Cw+(1-\phi)*Cr','\phi=0.85,総消費C','\phi=0.85,合成消費,\phi*Cw+(1-\phi)*Cr'})
% set(gca,'FontSize',12);
% 
% figure(101)
% plot(oo_55.irfs.Cw_epsTR*steady_state55.Cw,'LineWidth',1.5);hold on;
% plot(oo_55.irfs.Cr_epsTR*steady_state55.Cr,'LineWidth',1.5);hold on;
% plot(C_55A,'LineWidth',1.5);hold off;
% legend({'\phi=0.55,労働者消費Cw','\phi=0.55,高齢者消費Cr','\phi=0.55,総消費C'})
% set(gca,'FontSize',12);
% 
% figure(102)
% plot(oo_85.irfs.Cw_epsTR*steady_state85.Cw,'LineWidth',1.5);hold on;
% plot(oo_85.irfs.Cr_epsTR*steady_state85.Cr,'LineWidth',1.5);hold on;
% plot(C_85A,'LineWidth',1.5);hold off;
% legend({'\phi=0.85,労働者消費Cw','\phi=0.85,高齢者消費Cr','\phi=0.85,総消費C'})
% set(gca,'FontSize',12);

%% Comparison of INI,GC and TR
endo_var_list=["GC" "INI" "TR" "A" "Y" "C" "Cr" "Cw" "I" "h" "w" "T" "pi" "b" "rk" "R"];
endo_var_name=["GC" "R&D expenditure" "Transfer" "TFP" "Output" "Aggregate consumption" "Consumption of retirees" "Consumption of workers" "Investment" "Hours of work" "Real wage" "Tax" "Inflation rate" "Debt" "Real interest rate" "Nominal interest rate"];
shock_var_list=["epsgc"];
irf_list1=[];
for i=1:length(shock_var_list)
    for j=1:length(endo_var_list)
        irf_name=append(endo_var_list(j),'_',shock_var_list(i));
        irf_list1=[irf_list1; irf_name];
    end
end

shock_var_list=["epsINI"];
irf_list2=[];
for i=1:length(shock_var_list)
    for j=1:length(endo_var_list)
        irf_name=append(endo_var_list(j),'_',shock_var_list(i));
        irf_list2=[irf_list2; irf_name];
    end
end

shock_var_list=["epsTR"];
irf_list3=[];
for i=1:length(shock_var_list)
    for j=1:length(endo_var_list)
        irf_name=append(endo_var_list(j),'_',shock_var_list(i));
        irf_list3=[irf_list3; irf_name];
    end
end

fig(6)=figure('Name','Comparison of Government R&D expenditure, Government consumption, and Transfer');
tcl = tiledlayout(4,4,'TileSpacing','compact','Padding','compact');
for i=1:length(endo_var_list)
    irf_a=append('oo_.irfs.',irf_list1(i));
    irf_b=append('oo_.irfs.',irf_list2(i));    
    irf_c=append('oo_.irfs.',irf_list3(i));
    
    nexttile(tcl);
    x=0:length(eval(irf_a))-1;
    plot(x,eval(irf_a),'Color','black','LineWidth',1.5); hold on;
    plot(x,eval(irf_b),'Color','red','LineWidth',1.5); hold on;
    plot(x,eval(irf_c),'Color','#77AC30','LineWidth',1.5); hold on;
    yline(0,'--','Color','red','LineWidth',1);
    set(gca,'FontSize',12);
    set(gca,'FontName',"Times New Roman");
    title(endo_var_name(i),'Color','black','FontSize',12);
end
%sgtitle('Comparison of Government R&D expenditure, Transfer and Government consumption','FontSize',16);
hold off;
lg=legend({'GC','Government R&D expenditure','Transfer'});
lg.Orientation='horizontal';
lg.Layout.Tile = 'south';
lg.FontSize=12;
fig(6).Position = [0 0 width height];

%% Comparison of INI,GC and TR on Y
endo_var_list=["Y"];
endo_var_name=["Output"];

fig(7)=figure('Name','Comparison of GC,INI,TR on Y');
    irf_a=append('oo_85.irfs.','Y_epsgc');
    irf_b=append('oo_85.irfs.','Y_epsINI');    
    irf_c=append('oo_85.irfs.','Y_epsTR');
    
    irf_a55=append('oo_55.irfs.','Y_epsgc');
    irf_b55=append('oo_55.irfs.','Y_epsINI');    
    irf_c55=append('oo_55.irfs.','Y_epsTR');
    
    tcl = tiledlayout(1,2,'TileSpacing','compact','Padding','compact');
    nexttile(tcl);
    x=0:length(eval(irf_a))-1;
    plot(x,eval(irf_a),'Color','black','LineWidth',1.5); hold on;
    plot(x,eval(irf_b),'Color','red','LineWidth',1.5); hold on;
    plot(x,eval(irf_c),'Color','#77AC30','LineWidth',1.5); hold on;
    yline(0,'--','Color','red','LineWidth',1);
    set(gca,'FontSize',12);
    set(gca,'FontName',"Times New Roman");
    title('Output, \phi=0.85','Color','black','FontSize',12);
hold off;
        nexttile(tcl);
    x=0:length(eval(irf_a))-1;
    plot(x,eval(irf_a55),'Color','black','LineWidth',1.5); hold on;
    plot(x,eval(irf_b55),'Color','red','LineWidth',1.5); hold on;
    plot(x,eval(irf_c55),'Color','#77AC30','LineWidth',1.5); hold on;
    yline(0,'--','Color','red','LineWidth',1);
    set(gca,'FontSize',12);
    set(gca,'FontName',"Times New Roman");
    title('Output, \phi=0.55','Color','black','FontSize',12);
hold off;
lg=legend({'GC','Government R&D expenditure','Transfer'});
lg.Orientation='horizontal';
lg.Layout.Tile = 'south';
lg.FontSize=12;
fig(7).Position = [0 0 width height];


%% Graph output
cd 'C:\Users\lzkzz\Desktop\matlearn\Dynare_train\NK_aging_series\NK_aging_with_saving_research_fix\irfs'
graph_names=["epsgc" "epsgi" "epsa" "epsINI" "epsTR" "compare_GC_INI_TR" "compare_GC_INI_TR_onY"];
for i=1:length(graph_names)
path=append(graph_names(i),'_saving_research','.png');
saveas(fig(i),path);
end
close all;

