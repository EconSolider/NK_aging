%% IRFs
clc,clear;
close all;
cd 'C:\Users\lzkzz\Desktop\matlearn\Dynare_train\NK_aging_series\NK_aging_with_saving_research_w'
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
   eval(sprintf('steady_state.(oo_55.var_list{%d})=oo_.steady_state(%d);',j,j));
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

fig(1)=figure('Name','Comparison of Government R&D expenditure, Government consumption, and Transfer');
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
    title(endo_var_name(i),'Color','black','FontSize',12);
    set(gca,'FontSize',12);
    set(gca,'FontName',"Times New Roman");
end
%sgtitle('Comparison of Government R&D expenditure, Transfer and Government consumption','FontSize',16);
hold off;
lg=legend({'GC','Government R&D expenditure','Transfer'});
lg.Orientation='horizontal';
lg.Layout.Tile = 'south';
lg.FontSize=12;
lg.FontName='Times New Roman';
fig(1).Position = [100 100 600*1.618 600];

%% Graph output
cd 'C:\Users\lzkzz\Desktop\matlearn\Dynare_train\NK_aging_series\NK_aging_with_saving_research_w\irfs'
path=append('compare_GC_INI_TR','_saving_research_w','.png');
saveas(fig(1),path);
close all;