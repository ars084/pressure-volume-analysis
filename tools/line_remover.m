function [out] = line_remover(pts,sensitivity)
z = 0;
while z == 0
    figure(1)
    plot(pts(:,1),pts(:,2),'.')
    [x,y_ref] = getpts;
    ind = ~(pts(:,2) > y_ref - sensitivity & pts(:,2) < y_ref + sensitivity);
    out = [pts(ind,1),pts(ind,2)];
    disp([num2str(sum(~ind)), ' pts found'])
    pts = out;
    plot(pts(:,1),pts(:,2),'.')
    q=0;
    while q == 0
        cont = questdlg('Remove another line?',' ','yes','no','yes');
        switch cont
            case 'no'
               out = pts;
               q = 1;
               z = 1;
            case 'yes'
               q = 1;
               z = 0;
        end
    end
end
end

