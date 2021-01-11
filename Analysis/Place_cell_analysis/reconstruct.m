    function position=reconstruct(t0,bin_width,place_field,spike_times,spike_id,position_bins)
        global parameters
        t1=t0+bin_width;
        total_spike_count=0;
        product_of_place_fields=ones(1,length(position_bins));
        sum_of_place_fields=zeros(1,length(position_bins));
        number_of_cells=length(place_field);
        parameters.bayesian_threshold=10.^(log2(number_of_cells)-log2(400)); % small value multiplied to all values to get rid of zeros

        for k=1:length(place_field)
            n=length(find(spike_times>=(t0) & spike_times<=(t1) & spike_id==k)); %count # of spikes in bin
            place_field(k).calculated(find(place_field(k).calculated<parameters.bayesian_threshold))=parameters.bayesian_threshold;  %avoid zeros
            single_place_field=interp1(place_field(k).x_bins,place_field(k).calculated,position_bins,'linear');
            if size(single_place_field,1)>size(single_place_field,2)
                single_place_field=single_place_field';
            end
            product_of_place_fields=product_of_place_fields.*((single_place_field).^(n'*ones(1,length(position_bins))));
            sum_of_place_fields=sum_of_place_fields+single_place_field;
            total_spike_count=total_spike_count+n;
        end
        position=product_of_place_fields.*(exp(-bin_width*sum_of_place_fields));
        position=position./(sum(position,2)*ones(1,length(position_bins)));
    end