% Full pressure volume analysis
cd('/Volumes/McVeighLab/projects/Anderson/PV loops')
addpath('/Volumes/McVeighLab/projects/Anderson/PV loops/tools')

name = 'CVC1712041200';

p = get_pressure(name); 
v = get_volume(name);  
pv = get_pv(p,v);
plot(pv(:,1),pv(:,2))
