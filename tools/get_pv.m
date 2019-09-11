function [PV] = get_pv(pressure, vol)
%
% This code is for plotting PV loops when the ECG is known
% and hence, already aligned. This code upsamples the volume
% using interp1 and smooths the pressure

plotting = 0;

home = pwd;

addpath('/Volumes/McVeighLab/projects/Anderson/PV loops/tools')

front = 1;
back = 1;

% Load the pressure
pressure(:,2) = smoothdata(pressure(:,2),1,'gauss',5);
% Load the volume
vol = [vol, vol];
vol = interp1(linspace(0,200,length(vol)),vol,pressure(:,1));

if back == 1 && front == 0 %plot 0:100
    vol = vol(round(length(vol)/2):end);
    pressure = pressure(round(length(vol)/2):end,2);
elseif front == 1 && back == 0 %plot 100:200
    vol = vol(1:round(length(vol)/2)); 
    pressure(1:round(length(vol)/2),2);
elseif back == 1 && front == 1 %plot an average of the two
    vol = vol(round(length(vol)/2):end);
    pressure = (pressure(1:length(vol),2) + pressure(end-length(vol)+1:end,2))./2;
end

vol = [vol; vol(1)]; %close the loop
pressure = [pressure; pressure(1)]; %close the loop

if plotting == 1
    plot(vol,pressure,'-','linewidth',6)
    xlabel('Volumes (mL)','fontsize',15)
    ylabel('Pressure (mmHg)','fontsize',15)
    axis square
    title('Right Ventricle of LVAD Patient','fontsize',23)
end
cd(home)

PV = [vol,pressure];
end