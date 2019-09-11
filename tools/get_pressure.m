function [p] = get_pressure(pat_name)
% This code goes into the patient folder and retrieves the data
% for the pressure waveform, normalized to ECG

home = pwd;
cd('/Volumes/McVeighLab/projects/Anderson/PV loops/LVAD_Waveforms')


if isfolder(pat_name) % Go into patient folder
    cd(pat_name)
    if ~isfile('RV.csv') % Check for unprocessed pressure data
        error('RV pressure waveform not digitized') 
    end
    
    if ~isfile('RV_processed.csv') %If data hasn't been processed ...
        answer = questdlg('RV data is unprocessed. Would you like to process it?',...
            'Warning','Yes','No','Yes');
        p = load('RV.csv');
        
        if strcmp(answer,'Yes') % Process it
            pressure_processor
            p = load('RV_processed.csv');
        end
        
    else
        p = load('RV_processed.csv'); %Load the pressure data
    end
    
else
    cd(home)
    error([pat.name,' pressure waveform not found'])
end

cd(home)
end