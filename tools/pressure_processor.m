function pressure_processor(vargin)
% This code cleans up the data for digitized pressure waveforms
% It takes no inputs and has no outputs
% You need to be in a folder with the data points labeled 'RV.csv'
% It works on 'RV.csv' and saves a new file named 'RV_processed.csv'

if isempty(vargin)
    pressure = 'RV';
else
    pressure = vargin(1);
end

smoothing = 1;
home = pwd;

addpath('/Volumes/McVeighLab/projects/Anderson/PV_loops')

pts = csvread([pressure,'.csv']);

% Removing the Average Line / Grid lines
questdlg('Click a point on the a line to remove it',' ','ok','ok');
[final_pts] = line_remover(newpts,.3);
close all

% Cropping final_pts
final_x = final_pts(:,1);
final_y = final_pts(:,2);
cont_crop = questdlg('Click the top left and bottom right bounds around the data',' ','ok','ok');
plot(final_x,final_y,'.')
[x,y] = ginput(2);
close all

boundsx = [min(x),max(x)];
boundsy = [min(y),max(y)];

cropx = btw(final_x,boundsx);
cropy = btw(final_y,boundsy);
crop_ind = cropx & cropy;

cropped = [final_x(crop_ind),final_y(crop_ind)];

% Smoothing and Removing large jumps in the Data

last = cropped;
k=1;
for i = 2:length(last)
    if abs(last(i-1,2)-last(i,2)) < 50
        data(k,:) = last(i,:);
        k=k+1;
    end
end

% Linking data to Cardiac Cycle
cont = questdlg('Click the point as they show up on ECG',' ','ok','ok');

cd(home)
if ~isfile('ECG.png')
    warning('No ECG image found. Use R peak in QRS')
else
    figure
    imshow('ECG.png')
end

figure
plot(pts(:,1),pts(:,2),'.')
hold on
plot(data(:,1),data(:,2),'.')
hold off

[x,y] = getpts;
close all

% First we collect the processed data in that range
xdata = data(:,1);
ydata = data(:,2);

FirstBeatInd = btw(xdata,[x(1),x(2)]);
SecBeatInd = btw(xdata,[x(2),x(3)]);

FirstBeatx = xdata(logical(FirstBeatInd)); 
SecBeatx = xdata(logical(SecBeatInd));
ydata = ydata(FirstBeatInd | SecBeatInd);

FirstBeatx = 100 * (FirstBeatx - x(1))/max(FirstBeatx - x(1));
SecBeatx = 100 * (SecBeatx - x(2))/max(SecBeatx - x(2)) + 100;

xdata = [FirstBeatx;SecBeatx];
data_cycle = [xdata, ydata];

if smoothing == 1
    data_cycle = smoothdata(data_cycle,1,'gauss',5);
end

holder = 0;
while holder == 0
    plot(xdata,ydata,'.')
    contwhy = questdlg('Remove individual point?',' ','yes','no','yes');
    switch contwhy
        case 'yes'
            [data] = pt_remover([xdata,ydata]);
            xdata = data(:,1);
            ydata = data(:,2);
        case 'no'
            disp('No points removed')
            holder = 1;
    end
end

plot(data_cycle(:,1),data_cycle(:,2),'.')
hold on
plot(xdata,ydata,'.')
title('Points to be Saved')
legend('post-processed pts','pts')

% Saving the Processed Data
cont = questdlg('Save this data?',' ','yes','no','yes');
switch cont
    case 'yes'
        filename = [pressure,'_processed.csv'];
        cont_new = questdlg('Which data?',' ','original','smooth','original');
        switch cont_new
            case 'original'
                csvwrite([pat_dir,'/',filename],[xdata, ydata])
            case 'smooth'
                csvwrite([pat_dir,'/',filename],data_cycle)
        end
    case 'no'
end
close all

end