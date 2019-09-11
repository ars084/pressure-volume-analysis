% Full pressure volume analysis
clc
clear all 
close all

cd('/Volumes/McVeighLab/projects/Anderson/PV loops')
addpath('/Volumes/McVeighLab/projects/Anderson/PV loops/tools')

name = 'CVC1712041200';

p = get_pressure(name); 
v = get_volume(name);  
pv = get_pv(p,v);

plot(pv(:,1),pv(:,2),'-','linewidth',6)
xlabel('Volumes (mL)','fontsize',15)
ylabel('Pressure (mmHg)','fontsize',15)
axis square
title('Right Ventricle of LVAD Patient','fontsize',23)