function out=place_cell_model_KATA(number_of_place_cells)
%basic model of place cell firing based on a varied position, 
%with Bayesian decoding
%written by Daniel Bendor, 2018

global parameters
parameters.rate=[60 0];   %[10 100]; %[fixed rate additive random rate]
parameters.spacing=1; %0 is random, %1 is equally spaced
parameters.bandwidth=1;  %0 is random, %1 is equally spaced
parameters.speed_threshold=0.1;

time_end=60;
t_step1=0.01;
t=0:t_step1:time_end;
%model animal's running behaviour as running laps at different speeds with
%stopping times propotional to running speeds (slow speeds->longer waiting
%times)
[x,v]=generate_behaviour(t,t_step1);

%reinterpolate to desired sampling rate
t_step=0.0001;
t2=t(1):t_step:t(end);
x2=interp1(t,x,t2,'linear');
v2=interp1(t,v,t2,'linear');
speed=abs(v2);

%generate model place fields and spike times
[place_field,spike_times,spike_id]=generate_place_fields(number_of_place_cells,t2,x2,v2);


%calculate place fields from data
x_bins=linspace(0,1,100);
place_field=calculate_place_fields(place_field,x_bins,t2,x2,v2,spike_times,spike_id);

%%%%%%%%%%Bayesian decoding
bin_width=.1;
t0=0:bin_width:(time_end-bin_width);
position_bins=linspace(0,1,30);
[position,estimated_position_time,estimated_position_interp]=calculate_estimated_position(t,t0,bin_width,place_field,spike_times,spike_id,position_bins);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%save variables
out.place_field=place_field;
out.spike_times=spike_times;
out.spike_id=spike_id;
out.Bayes_position=position;
out.Bayes_time=estimated_position_time;
out.Bayes_probability=estimated_position_interp;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%generate figures
%FIGURE 1: animal behaviour, LFP, place cells

figure
ax=[];
ax(1)=subplot(3,1,1);
plot(t,x,'b')
hold on
plot(t,v,'r--')
title('animal behaviour')
ylabel('position (normalized)')
xlabel('time(s)')


subplot(3,1,2);
hold on
for j=1:number_of_place_cells
    plot(place_field(j).x,place_field(j).rate);
end
title('place fields')
xlabel('position (normalized)')
ylabel('rate(Hz)')

subplot(3,1,3);
hold on
for j=1:number_of_place_cells
    plot(x_bins,place_field(j).calculated)
end
title('place fields')
xlabel('position (normalized)')
ylabel('rate(Hz)')


%%%%%%%%%%FIGURE 2: Bayesian decoding

figure
ax=[];
ax(1)=subplot(2,1,1);
raster_plot(out.spike_times,out.spike_id,'b')
title('place cell activity')
ylabel('place cell id')
xlabel('time(s)')
hold on

ax(2)=subplot(2,1,2);
imagesc(estimated_position_time,position_bins,position)
a=colormap(bone);
colormap(flipud(a));
axis xy
hold on
plot(t,x,'r')
plot(t,estimated_position_interp,'g--')
title('Bayesian decoding')
ylabel('position (normalized)')
xlabel('time(s)')

linkaxes(ax,'x');

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%Bayesian decoding 
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
    
    
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function [x,v]=generate_behaviour(t,t_step1)
        global parameters
        x=1.5*vco(linspace(-1,1,length(t)),[0.05 0.15],1./t_step1);
        x(find(x>1))=1;
        x(find(x<-1))=-1;
        x=0.5*x+0.5; %normalize from 0 to 1
        v=diff([x(1) x x(end)])/t_step1;
        v=interp1([t-(t_step1/2) t(end)+t_step1/2],v,t,'linear');
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
