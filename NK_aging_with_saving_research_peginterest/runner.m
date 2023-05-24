%% GC
clc,clear;
close all;
cd 'C:\Users\lzkzz\Desktop\matlearn\Dynare_train\NK_aging_series\NK_aging_with_saving_research_peginterest'
phi=0.85;
dynare GC_peg0 nolog
oo_peg0=oo_;
dynare GC_peg4 nolog
oo_peg4=oo_;
dynare GC_peg8 nolog
oo_peg8=oo_;

for j=1:length(oo_.var_list)
   eval(sprintf('steady_state.(oo_.var_list{%d})=oo_.steady_state(%d);',j,j));
end

irfnames=fieldnames(oo_peg0.irfs);
split_irfnames=split(irfnames,'_');
varlist=split_irfnames(:,1);
 for j=1:numel(irfnames)
     eval(sprintf('oo_peg0.irfs.(irfnames{%d})=oo_peg0.irfs.(irfnames{%d})./steady_state.(varlist{%d})*100;',j,j,j));
     eval(sprintf('oo_peg4.irfs.(irfnames{%d})=oo_peg4.irfs.(irfnames{%d})./steady_state.(varlist{%d})*100;',j,j,j));
     eval(sprintf('oo_peg8.irfs.(irfnames{%d})=oo_peg8.irfs.(irfnames{%d})./steady_state.(varlist{%d})*100;',j,j,j));
 end

oo_peg0.irfs.GCmulti_epsgc=(oo_peg0.irfs.Y_epsgc*steady_state.Y)./(oo_peg0.irfs.GC_epsgc*steady_state.GC);
oo_peg4.irfs.GCmulti_epsgc=(oo_peg4.irfs.Y_epsgc*steady_state.Y)./(oo_peg4.irfs.GC_epsgc*steady_state.GC);
oo_peg8.irfs.GCmulti_epsgc=(oo_peg8.irfs.Y_epsgc*steady_state.Y)./(oo_peg8.irfs.GC_epsgc*steady_state.GC);

oo_peg0.irfs.TRmulti_epsTR=(oo_peg0.irfs.Y_epsTR*steady_state.Y)./(oo_peg0.irfs.TR_epsTR*steady_state.TR);
oo_peg4.irfs.TRmulti_epsTR=(oo_peg4.irfs.Y_epsTR*steady_state.Y)./(oo_peg4.irfs.TR_epsTR*steady_state.TR);
oo_peg8.irfs.TRmulti_epsTR=(oo_peg8.irfs.Y_epsTR*steady_state.Y)./(oo_peg8.irfs.TR_epsTR*steady_state.TR);


endo_var_list=["GC" "Y" "C" "Cr" "Cw" "h" "w" "pi" "rk" "R" "b" "GCmulti"];
endo_var_name=["GC" "Output" "Aggregate consumption" "Consumption of retirees" "Consumption of workers" "Hours of work" "Real wage" "Inflation rate" "Real interest rate" "Nominal interest rate" "Debt" "GC multiplier"];
shock_var_list=["epsgc"];
irf_list=[];
for i=1:length(shock_var_list)
    for j=1:length(endo_var_list)
        irf_name=append(endo_var_list(j),'_',shock_var_list(i));
        irf_list=[irf_list; irf_name];
    end
end

fig(1)=figure('Name','government consumption shock');
tcl = tiledlayout(4,3,'TileSpacing','compact','Padding','compact');
for i=1:length(endo_var_list)
    irf_a=append('oo_peg0.irfs.',irf_list(i));
    irf_b=append('oo_peg4.irfs.',irf_list(i));
    irf_c=append('oo_peg8.irfs.',irf_list(i));
    
    nexttile(tcl);
    x=0:length(eval(irf_a))-1;
    plot(x,eval(irf_a),'Color','black','LineWidth',1.5); hold on;
    plot(x,eval(irf_b),'Color','blue','LineWidth',1.5); hold on;
    plot(x,eval(irf_c),'Color','red','LineWidth',1.5); hold on;
    
    yline(0,'--','Color','red','LineWidth',1);
    set(gca,'FontSize',12);
    set(gca,'FontName',"Times New Roman");
    title(endo_var_name(i),'Color','black','FontSize',12);
end
%sgtitle('Government consumption under liquidity trap (percent deviation from steady-state value)','FontSize',16);
fig(1).Position = [100 100 600*1.618 600]; %[left bottom width height]
lg=legend({'PEG=0, \phi=0.85','PEG=4, \phi=0.85','PEG=8, \phi=0.85'});
lg.Orientation='horizontal';
lg.Layout.Tile = 'south';
lg.FontSize = 12;
hold off;

%% TR
endo_var_list=["TR" "Y" "C" "Cr" "Cw" "h" "w" "pi" "rk" "R" "b" "TRmulti"];
endo_var_name=["Transfer" "Output" "Aggregate consumption" "Consumption of retirees" "Consumption of workers" "Hours of work" "Real wage" "Inflation rate" "Real interest rate" "Nominal interest rate" "Debt" "Multiplier"];
shock_var_list=["epsTR"];
irf_list=[];
for i=1:length(shock_var_list)
    for j=1:length(endo_var_list)
        irf_name=append(endo_var_list(j),'_',shock_var_list(i));
        irf_list=[irf_list; irf_name];
    end
end

fig(2)=figure('Name','Lump-sum transfer shock');
tcl = tiledlayout(4,3,'TileSpacing','compact','Padding','compact');
for i=1:length(endo_var_list)
    irf_a=append('oo_peg0.irfs.',irf_list(i));
    irf_b=append('oo_peg4.irfs.',irf_list(i));
    irf_c=append('oo_peg8.irfs.',irf_list(i));
    
    nexttile(tcl);
    x=0:length(eval(irf_a))-1;
    plot(x,eval(irf_a),'Color','black','LineWidth',1.5); hold on;
    plot(x,eval(irf_b),'Color','blue','LineWidth',1.5); hold on;
    plot(x,eval(irf_c),'Color','red','LineWidth',1.5); hold on;
    
    yline(0,'--','Color','red','LineWidth',1);
    title(endo_var_name(i),'Color','black','FontSize',12);
    set(gca,'FontSize',12);
    set(gca,'FontName',"Times New Roman");
end
fig(2).Position = [100 100 600*1.618 600]; %[left bottom width height]
lg=legend({'PEG=0','PEG=4','PEG=8'});
lg.Orientation='horizontal';
lg.Layout.Tile = 'south';
lg.FontSize = 12;
hold off;

%% INI
oo_peg0.irfs.INImulti_epsINI=(oo_peg0.irfs.Y_epsINI*steady_state.Y)./(oo_peg0.irfs.INI_epsINI*steady_state.INI);
oo_peg4.irfs.INImulti_epsINI=(oo_peg4.irfs.Y_epsINI*steady_state.Y)./(oo_peg4.irfs.INI_epsINI*steady_state.INI);
oo_peg8.irfs.INImulti_epsINI=(oo_peg8.irfs.Y_epsINI*steady_state.Y)./(oo_peg8.irfs.INI_epsINI*steady_state.INI);
%パーセントの偏差に修正
oo_peg0.irfs.rk_epsINI=oo_peg0.irfs.rk_epsINI/10;
oo_peg4.irfs.rk_epsINI=oo_peg4.irfs.rk_epsINI/10;
oo_peg8.irfs.rk_epsINI=oo_peg8.irfs.rk_epsINI/10;

oo_peg0.irfs.Cr_epsINI=oo_peg0.irfs.Cr_epsINI/10;
oo_peg4.irfs.Cr_epsINI=oo_peg4.irfs.Cr_epsINI/10;
oo_peg8.irfs.Cr_epsINI=oo_peg8.irfs.Cr_epsINI/10;

endo_var_list=["INI" "Y" "C" "Cr" "Cw" "h" "w" "pi" "rk" "R" "b" "mc" "INImulti"];
endo_var_name=["R&D expenditure" "Output" "Aggregate consumption" "Consumption of retirees" "Consumption of workers" "Hours of work" "Real wage" "Inflation rate" "Real interest rate" "Nominal interest rate" "Debt" "Marginal cost" "Multiplier"];
shock_var_list=["epsINI"];
irf_list=[];
for i=1:length(shock_var_list)
    for j=1:length(endo_var_list)
        irf_name=append(endo_var_list(j),'_',shock_var_list(i));
        irf_list=[irf_list; irf_name];
    end
end

fig(3)=figure('Name','government R&D expenditure shock');
tcl = tiledlayout(5,3,'TileSpacing','compact','Padding','compact');
for i=1:length(endo_var_list)
    irf_a=append('oo_peg0.irfs.',irf_list(i));
    irf_b=append('oo_peg4.irfs.',irf_list(i));
    irf_c=append('oo_peg8.irfs.',irf_list(i));
    
    nexttile(tcl);
    x=0:length(eval(irf_a))-1;
    plot(x,eval(irf_a),'Color','black','LineWidth',1.5); hold on;
    plot(x,eval(irf_b),'Color','blue','LineWidth',1.5); hold on;
    plot(x,eval(irf_c),'Color','red','LineWidth',1.5); hold on;
    
    yline(0,'--','Color','red','LineWidth',1);
    title(endo_var_name(i),'Color','black','FontSize',12);
    set(gca,'FontSize',12);
    set(gca,'FontName',"Times New Roman");

end
%sgtitle('R&D expenditure under liquidity trap (percent deviation from steady-state value)','FontSize',16);
fig(3).Position = [100 100 600*1.618 600]; %[left bottom width height]
lg=legend({'PEG=0, \phi=0.85','PEG=4, \phi=0.85','PEG=8, \phi=0.85'});
lg.Orientation='horizontal';
lg.Layout.Tile = 'south';
lg.FontSize = 12;
hold off;

%% TFP
oo_peg0.irfs.rk_epsa=oo_peg0.irfs.rk_epsa/10;
oo_peg4.irfs.rk_epsa=oo_peg4.irfs.rk_epsa/10;
oo_peg8.irfs.rk_epsa=oo_peg8.irfs.rk_epsa/10;

oo_peg0.irfs.Cr_epsa=oo_peg0.irfs.Cr_epsa/10;
oo_peg4.irfs.Cr_epsa=oo_peg4.irfs.Cr_epsa/10;
oo_peg8.irfs.Cr_epsa=oo_peg8.irfs.Cr_epsa/10;

endo_var_list=["A" "Y" "C" "Cr" "Cw" "h" "w" "pi" "rk" "R" "b" "mc"];
endo_var_name=["TFP" "Output" "Aggregate consumption" "Consumption of retirees" "Consumption of workers" "Hours of work" "Real wage" "Inflation rate" "Real interest rate" "Nominal interest rate" "Debt" "Marginal cost"];
shock_var_list=["epsa"];
irf_list=[];
for i=1:length(shock_var_list)
    for j=1:length(endo_var_list)
        irf_name=append(endo_var_list(j),'_',shock_var_list(i));
        irf_list=[irf_list; irf_name];
    end
end

fig(4)=figure('Name','TFP shock');
tcl = tiledlayout(4,3,'TileSpacing','compact','Padding','compact');
for i=1:length(endo_var_list)
    irf_a=append('oo_peg0.irfs.',irf_list(i));
    irf_b=append('oo_peg4.irfs.',irf_list(i));
    irf_c=append('oo_peg8.irfs.',irf_list(i));
    
    nexttile(tcl);
    x=0:length(eval(irf_a))-1;
    plot(x,eval(irf_a),'Color','black','LineWidth',1.5); hold on;
    plot(x,eval(irf_b),'Color','blue','LineWidth',1.5); hold on;
    plot(x,eval(irf_c),'Color','red','LineWidth',1.5); hold on;
    
    yline(0,'--','Color','red','LineWidth',1);
    title(endo_var_name(i),'Color','black','FontSize',12);
    set(gca,'FontSize',12);
    set(gca,'FontName',"Times New Roman");

end
fig(4).Position = [100 100 600*1.618 600]; %[left bottom width height]
lg=legend({'PEG=0, \phi=0.85','PEG=4, \phi=0.85','PEG=8, \phi=0.85'});
lg.Orientation='horizontal';
lg.Layout.Tile = 'south';
lg.FontSize = 12;
hold off;

%% Compare GC,TR,INI
endo_var_list=["GC" "INI" "TR" "A" "Y" "C" "Cr" "Cw" "h" "w" "T" "pi" "b" "rk" "R"];
endo_var_name=["GC" "R&D expenditure" "Transfer" "TFP" "Output" "Aggregate consumption" "Consumption of retirees" "Consumption of workers" "Hours of work" "Real wage" "Tax" "Inflation rate" "Debt" "Real interest rate" "Nominal interest rate"];
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

fig(5)=figure('Name','Comparison of Government R&D expenditure, Government consumption, and Transfer under liquidity trap');
tcl = tiledlayout(4,4,'TileSpacing','compact','Padding','compact');
for i=1:length(endo_var_list)
    irf_a=append('oo_peg8.irfs.',irf_list1(i));
    irf_b=append('oo_peg8.irfs.',irf_list2(i));    
    irf_c=append('oo_peg8.irfs.',irf_list3(i));

    nexttile(tcl);
    x=0:length(eval(irf_a))-1;
    plot(x,eval(irf_a),'Color','black','LineWidth',1.5); hold on;
    plot(x,eval(irf_b),'Color','red','LineWidth',1.5); hold on;
    plot(x,eval(irf_c),'Color','#77AC30','LineWidth',1.5); hold on;
    yline(0,'--','Color','red','LineWidth',1);
    title(endo_var_name(i),'Color','black','FontSize',12);
    set(gca,'FontSize',12);
    set(gca,'FontName',"Times New Roman");

end
nexttile(tcl);
x=0:length(eval(irf_a))-1;
plot(x,oo_peg8.irfs.GCmulti_epsgc,'Color','black','LineWidth',1.5); hold on;
plot(x,oo_peg8.irfs.INImulti_epsINI,'Color','red','LineWidth',1.5); hold on;
plot(x,oo_peg8.irfs.TRmulti_epsTR,'Color','#77AC30','LineWidth',1.5); hold on;
yline(0,'--','Color','red','LineWidth',1);
title('Multiplier','Color','black','FontSize',12);
set(gca,'FontSize',12);
set(gca,'FontName',"Times New Roman");
hold off;
lg=legend({'GC, PEG=8','Government R&D expenditure, PEG=8','Transfer, PEG=8'});
lg.Orientation='horizontal';
lg.Layout.Tile = 'south';
lg.FontSize = 12;
fig(5).Position = [100 100 600*1.618 600];



%% GC diff labor participation
phi_list=[0.55 0.85];
for ii=1:length(phi_list)
phi=phi_list(ii);
dynare GC_peg8 nolog
result_list(ii)=oo_;
end
oo_peg8_55=result_list(1);
oo_peg8_85=result_list(2);

for j=1:length(oo_.var_list)
   eval(sprintf('steady_state55.(oo_peg8_55.var_list{%d})=oo_peg8_55.steady_state(%d);',j,j));
   eval(sprintf('steady_state85.(oo_peg8_85.var_list{%d})=oo_peg8_85.steady_state(%d);',j,j));
end

irfnames=fieldnames(oo_peg8_55.irfs);
split_irfnames=split(irfnames,'_');
varlist=split_irfnames(:,1);
 for j=1:numel(irfnames)
     eval(sprintf('oo_peg8_55.irfs.(irfnames{%d})=oo_peg8_55.irfs.(irfnames{%d})./steady_state55.(varlist{%d})*100;',j,j,j));
     eval(sprintf('oo_peg8_85.irfs.(irfnames{%d})=oo_peg8_85.irfs.(irfnames{%d})./steady_state85.(varlist{%d})*100;',j,j,j));
 end
oo_peg8_55.irfs.GCmulti_epsgc=(oo_peg8_55.irfs.Y_epsgc*steady_state55.Y)./(oo_peg8_55.irfs.GC_epsgc*steady_state55.GC);
oo_peg8_85.irfs.GCmulti_epsgc=(oo_peg8_85.irfs.Y_epsgc*steady_state85.Y)./(oo_peg8_85.irfs.GC_epsgc*steady_state85.GC);

oo_peg8_55.irfs.TRmulti_epsTR=(oo_peg8_55.irfs.Y_epsTR*steady_state55.Y)./(oo_peg8_55.irfs.TR_epsTR*steady_state55.TR);
oo_peg8_85.irfs.TRmulti_epsTR=(oo_peg8_85.irfs.Y_epsTR*steady_state85.Y)./(oo_peg8_85.irfs.TR_epsTR*steady_state85.TR);

oo_peg8_55.irfs.INImulti_epsINI=(oo_peg8_55.irfs.Y_epsINI*steady_state55.Y)./(oo_peg8_55.irfs.INI_epsINI*steady_state55.INI);
oo_peg8_85.irfs.INImulti_epsINI=(oo_peg8_85.irfs.Y_epsINI*steady_state85.Y)./(oo_peg8_85.irfs.INI_epsINI*steady_state85.INI);

oo_peg8_55.irfs.rk_epsINI=oo_peg8_55.irfs.rk_epsINI/10;
oo_peg8_85.irfs.rk_epsINI=oo_peg8_85.irfs.rk_epsINI/10;
oo_peg8_55.irfs.Cr_epsINI=oo_peg8_55.irfs.Cr_epsINI/10;
oo_peg8_85.irfs.Cr_epsINI=oo_peg8_85.irfs.Cr_epsINI/10;

oo_peg8_55.irfs.rk_epsa=oo_peg8_55.irfs.rk_epsa/10;
oo_peg8_85.irfs.rk_epsa=oo_peg8_85.irfs.rk_epsa/10;
oo_peg8_55.irfs.Cr_epsa=oo_peg8_55.irfs.Cr_epsa/10;
oo_peg8_85.irfs.Cr_epsa=oo_peg8_85.irfs.Cr_epsa/10;


endo_var_list=["GC" "Y" "C" "Cr" "Cw" "h" "w" "pi" "rk" "R" "b" "GCmulti"];
endo_var_name=["GC" "Output" "Aggregate consumption" "Consumption of retirees" "Consumption of workers" "Hours of work" "Real wage" "Inflation rate" "Real interest rate" "Nominal interest rate" "Debt" "GC multiplier"];
shock_var_list=["epsgc"];
irf_list=[];
for i=1:length(shock_var_list)
    for j=1:length(endo_var_list)
        irf_name=append(endo_var_list(j),'_',shock_var_list(i));
        irf_list=[irf_list; irf_name];
    end
end

fig(6)=figure('Name','government consumption shock old');
tcl = tiledlayout(4,3,'TileSpacing','compact','Padding','compact');
for i=1:length(endo_var_list)
    irf_a=append('oo_peg8_55.irfs.',irf_list(i));
    irf_b=append('oo_peg8_85.irfs.',irf_list(i));
    
    nexttile(tcl);
    x=0:length(eval(irf_a))-1;
    plot(x,eval(irf_a),'Color','blue','LineWidth',1.5); hold on;
    plot(x,eval(irf_b),'Color','red','LineWidth',1.5); hold on;
    
    yline(0,'--','Color','red','LineWidth',1);
    title(endo_var_name(i),'Color','black','FontSize',12);
    set(gca,'FontSize',12);
    set(gca,'FontName',"Times New Roman");

end
%sgtitle('Government consumption under liquidity trap (percent deviation from steady-state value)','FontSize',16);
fig(6).Position = [100 100 600*1.618 600]; %[left bottom width height]
lg=legend({'PEG=8, \phi=0.55','PEG=8, \phi=0.85'});
lg.Orientation='horizontal';
lg.Layout.Tile = 'south';
lg.FontSize = 12;
hold off;

%% TR diff labor participation
endo_var_list=["TR" "Y" "C" "Cr" "Cw" "h" "w" "pi" "rk" "R" "b" "TRmulti"];
endo_var_name=["Transfer" "Output" "Aggregate consumption" "Consumption of retirees" "Consumption of workers" "Hours of work" "Real wage" "Inflation rate" "Real interest rate" "Nominal interest rate" "Debt" "Multiplier"];
shock_var_list=["epsTR"];
irf_list=[];
for i=1:length(shock_var_list)
    for j=1:length(endo_var_list)
        irf_name=append(endo_var_list(j),'_',shock_var_list(i));
        irf_list=[irf_list; irf_name];
    end
end

fig(7)=figure('Name','Transfer shock old');
tcl = tiledlayout(4,3,'TileSpacing','compact','Padding','compact');
for i=1:length(endo_var_list)
    irf_a=append('oo_peg8_55.irfs.',irf_list(i));
    irf_b=append('oo_peg8_85.irfs.',irf_list(i));
    
    nexttile(tcl);
    x=0:length(eval(irf_a))-1;
    plot(x,eval(irf_a),'Color','blue','LineWidth',1.5); hold on;
    plot(x,eval(irf_b),'Color','red','LineWidth',1.5); hold on;
    
    yline(0,'--','Color','red','LineWidth',1);
    title(endo_var_name(i),'Color','black','FontSize',12);
    set(gca,'FontSize',12);
    set(gca,'FontName',"Times New Roman");

end
fig(7).Position = [100 100 600*1.618 600]; %[left bottom width height]
lg=legend({'PEG=8, \phi=0.55','PEG=8, \phi=0.85'});
lg.Orientation='horizontal';
lg.Layout.Tile = 'south';
lg.FontSize = 12;
hold off;

%% INI diff labor participation
endo_var_list=["INI" "Y" "C" "Cr" "Cw" "h" "w" "pi" "rk" "R" "b" "mc" "INImulti"];
endo_var_name=["R&D expenditure" "Output" "Aggregate consumption" "Consumption of retirees" "Consumption of workers" "Hours of work" "Real wage" "Inflation rate" "Real interest rate" "Nominal interest rate" "Debt" "Marginal cost" "Multiplier"];
shock_var_list=["epsINI"];
irf_list=[];
for i=1:length(shock_var_list)
    for j=1:length(endo_var_list)
        irf_name=append(endo_var_list(j),'_',shock_var_list(i));
        irf_list=[irf_list; irf_name];
    end
end

fig(8)=figure('Name','INI shock old');
tcl = tiledlayout(5,3,'TileSpacing','compact','Padding','compact');
for i=1:length(endo_var_list)
    irf_a=append('oo_peg8_55.irfs.',irf_list(i));
    irf_b=append('oo_peg8_85.irfs.',irf_list(i));
    
    nexttile(tcl);
    x=0:length(eval(irf_a))-1;
    plot(x,eval(irf_a),'Color','blue','LineWidth',1.5); hold on;
    plot(x,eval(irf_b),'Color','red','LineWidth',1.5); hold on;
    
    yline(0,'--','Color','red','LineWidth',1);
    title(endo_var_name(i),'Color','black','FontSize',12);
    set(gca,'FontSize',12);
    set(gca,'FontName',"Times New Roman");

end
%sgtitle('R&D expenditure under liquidity trap (percent deviation from steady-state value)','FontSize',16);
fig(8).Position = [100 100 600*1.618 600]; %[left bottom width height]
lg=legend({'PEG=8, \phi=0.55','PEG=8, \phi=0.85'});
lg.Orientation='horizontal';
lg.Layout.Tile = 'south';
lg.FontSize = 12;
hold off;

%% TFP diff labor participation
endo_var_list=["A" "Y" "C" "Cr" "Cw" "h" "w" "pi" "rk" "R" "b" "mc"];
endo_var_name=["TFP" "Output" "Aggregate consumption" "Consumption of retirees" "Consumption of workers" "Hours of work" "Real wage" "Inflation rate" "Real interest rate" "Nominal interest rate" "Debt" "Marginal cost"];
shock_var_list=["epsa"];
irf_list=[];
for i=1:length(shock_var_list)
    for j=1:length(endo_var_list)
        irf_name=append(endo_var_list(j),'_',shock_var_list(i));
        irf_list=[irf_list; irf_name];
    end
end

fig(9)=figure('Name','TFP shock old');
tcl = tiledlayout(4,3,'TileSpacing','compact','Padding','compact');
for i=1:length(endo_var_list)
    irf_a=append('oo_peg8_55.irfs.',irf_list(i));
    irf_b=append('oo_peg8_85.irfs.',irf_list(i));
    
    nexttile(tcl);
    x=0:length(eval(irf_a))-1;
    plot(x,eval(irf_a),'Color','blue','LineWidth',1.5); hold on;
    plot(x,eval(irf_b),'Color','red','LineWidth',1.5); hold on;
    
    yline(0,'--','Color','red','LineWidth',1);
    title(endo_var_name(i),'Color','black','FontSize',12);
    set(gca,'FontSize',12);
    set(gca,'FontName',"Times New Roman");

end
fig(9).Position = [100 100 600*1.618 600]; %[left bottom width height]
lg=legend({'PEG=8, \phi=0.55','PEG=8, \phi=0.85'});
lg.Orientation='horizontal';
lg.Layout.Tile = 'south';
lg.FontSize = 12;
hold off;

%% policy effects on Y
    irf_a=append('oo_peg8_55.irfs.','Y_epsgc');
    irf_b=append('oo_peg8_55.irfs.','Y_epsINI');    
    irf_c=append('oo_peg8_55.irfs.','Y_epsTR');   
    irf_a55=append('oo_peg8_85.irfs.','Y_epsgc');
    irf_b55=append('oo_peg8_85.irfs.','Y_epsINI');    
    irf_c55=append('oo_peg8_85.irfs.','Y_epsTR');

    fig(10)=figure('Name','Comparison of GC,INI,TR on Y');
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
fig(10).Position = [100 100 600*1.618 600];

%% Graph output
cd 'C:\Users\lzkzz\Desktop\matlearn\Dynare_train\NK_aging_series\NK_aging_with_saving_research_peginterest\irfs'
graph_names=["GC" "TR" "INI" "A" "compare_GC_INI_TR" "GC_old" "TR_old" "INI_old" "A_old" "compare_GC_INI_TR_onY"];
for i=1:10
path=append(graph_names(i),'_LT','.png');
saveas(fig(i),path);
end
close all;