% Full pressure volume data
clc
clear all 
close all

cd('/Volumes/McVeighLab/projects/Anderson/PV loops')
addpath('./tools')
addpath('../TR-fig')
pats = load_pats;
pats = add_pv(pats);
%%
close all
PVpats = find([pats.General.PV_path_exists] == 1);
patdir = dir('./LVAD_Waveforms/CVC*');
for i = 1:length(PVpats)
    plotsy = floor(sqrt(length(PVpats)));
    plotsx = round(length(PVpats)/plotsy);
    %subplot(plotsx,plotsy,i)
    if ~isempty(pats.General(PVpats(i)).PV)
        figure(i)
        plot(pats.General(PVpats(i)).PV(:,1),pats.General(PVpats(i)).PV(:,2),'b','linewidth',12)
        vol = pats.General(PVpats(i)).PV(:,1);
        pressure = pats.General(PVpats(i)).PV(:,2);
        centerx = mean(vol);
        centery = mean(pressure);
        hold on
        w = 1000*([pats.Cath(PVpats(i)).CO]./[pats.Cath(PVpats(i)).HR])/2;
        h = (pats.Cath(PVpats(i)).MPAP)/2;
        plot([centerx-w, centerx+w , centerx+w , centerx-w, centerx-w ],...
        [centery-h , centery-h , centery+h , centery+h, centery-h ],'r','linewidth',12)
        xlim([60 350])
        xlabel('Volume (mL)','fontsize',20)
        ylabel('Pressure (mmHg)','fontsize',20)
        ylim([-10 90])
    else
        text(0.2,0.5,'PV data unavailable')
    end
    title(pats.General(i).AnonName,'fontsize',22)
    saveas(gcf,['./figs/',pats.General(i).AnonName,'.jpg'])
end
%subplot(plotsx,plotsy,2)
hold off