    function raster_plot(x,y,c)
        x2(1:3:length(x)*3)=x;
        x2(2:3:length(x)*3)=x;
        x2(3:3:length(x)*3)=NaN;
        y2(1:3:length(x)*3)=y;
        y2(2:3:length(x)*3)=y+0.9;
        y2(3:3:length(x)*3)=NaN;
        if isempty(c)
            plot(x2,y2);
        else
            plot(x2,y2,c);
        end
    end
