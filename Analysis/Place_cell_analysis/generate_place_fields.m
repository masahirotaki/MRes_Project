    function [place_field,spike_times,spike_id]=generate_place_fields(number_of_place_cells,t2,x2,v2)
        
        global parameters
        
        spontaneous_rate=0.1;
       
        spike_times=[];
        spike_id=[];
        t_step=t2(2)-t2(1);
       
        if parameters.spacing==0
            place_cell_centres=sort(rand(1,number_of_place_cells));
        else
            place_cell_centres=(0:number_of_place_cells-1)/(number_of_place_cells-1);
        end
        
        for j=1:number_of_place_cells
            place_field(j).x=0:0.001:1;
            place_field(j).rate=zeros(size(place_field(j).x));
           place_field(j).centre=place_cell_centres(j);
            place_field(j).peak_rate=parameters.rate(1)+parameters.rate(2)*rand(1);
            index=interp1(place_field(j).x,1:length(place_field(j).x),place_field(j).centre,'nearest');
            if parameters.bandwidth==0
                bandwidth=round(length(place_field(j).x)/(4+2*rand(1)));
            else
                bandwidth=round(length(place_field(j).x)/5);
            end
            place_field(j).index=(index-bandwidth):(index+bandwidth);
            place_field(j).shape=place_field(j).peak_rate*gausswin(length(place_field(j).index),5).^2;
            
            m=find(place_field(j).index>0 & place_field(j).index<=length(place_field(j).x));
            if ~isempty(m)
                place_field(j).rate(place_field(j).index(m))=place_field(j).shape(m);
            end
            
            rate=interp1(place_field(j).x,place_field(j).rate,x2);
            
            rate=rate+spontaneous_rate;
            spike_probability=(rate*t_step).*exp(-rate*t_step);
            
            replay_spikes_max=place_field(j).peak_rate/15;

            index=find(rand(size(t2))<=spike_probability);
            spike_times=[spike_times t2(index)];
            spike_id=[spike_id j*ones(size(index))];
        end
    end
