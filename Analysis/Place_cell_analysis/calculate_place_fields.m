    function place_field=calculate_place_fields(place_field,x_bins,t2,x2,v2,spike_times,spike_id)
        global parameters
        speed=interp1(t2,abs(v2),spike_times,'linear');
        x_bins_width=x_bins(2)-x_bins(1);
        x_hist=(t2(2)-t2(1)).*histcounts(x2(find(abs(v2)>parameters.speed_threshold)),[x_bins-x_bins_width/2 x_bins(end)+x_bins_width/2]);  %time spent at each location
        position_during_spike=interp1(t2,x2,spike_times,'linear');
        for j=1:length(place_field)
            place_field(j).spike_hist=histcounts(position_during_spike(find(spike_id==j & speed>parameters.speed_threshold)),[x_bins-x_bins_width/2 x_bins(end)+x_bins_width/2]);
            place_field(j).calculated= place_field(j).spike_hist./x_hist;
            place_field(j).x_bins=x_bins;
        end
    end