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