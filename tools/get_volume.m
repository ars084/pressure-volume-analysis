function [v] = get_volume(name)

home = pwd;
cd('/Volumes/McVeighLab/projects/Anderson/RV_SQUEEZ')

if ~isfolder(name)
    warning('Volum is not found in RV_SQUEEZ')
    cd('/Volumes/McVeighLab/wip/ucsd_lvad')
    if ~isfolder(name)
        cd('to_be_reviewed')
        if ~isfolder(name)
            error([name,' has not been segmented'])
        else
            error('Check that segmentation is complete and run SQUEEZ')
        end
    else
        cd(name)
        if isfolder('seg-nii')
            error('Check that segmentation is complete and run SQUEEZ')
        else
            error([name,' has not been segmented'])
        end
    end
else
    cd([name,'/MAT'])
    file = dir('VolOverTime*.mat');
    v = load(file.name); 
    v = v.vol;
end
cd(home)
end