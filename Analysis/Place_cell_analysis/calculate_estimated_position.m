    function [position,estimated_position_time,estimated_position_interp]=calculate_estimated_position(t,t0,bin_width,place_field,spike_times,spike_id,position_bins)
        global parameters
        for j=1:length(t0)
            position(:,j)=reconstruct(t0(j),bin_width,place_field,spike_times,spike_id,position_bins)';
        end
        
        for j=1:length(t0)
            [probability(j),position_index(j)]=max(position(:,j));
        end
        estimated_position=position_bins(position_index);
        index=find(probability>0.2);
        estimated_position_time=t0+bin_width/2;
        estimated_position_interp=interp1(estimated_position_time(index),estimated_position(index),t,'linear');
    end
    