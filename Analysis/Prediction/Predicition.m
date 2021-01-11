%% Ventral hippocampus activity
xlabel = {'A','A*','B*','B'};
x = [1, 2, 3, 4];
y1 = [0.01, 0.03, 0.97, 0.99];
y2 = [0.98, 0.97, 0.04, 0.01];

hold on
subplot(1,3,2)
plot(x,y1,'o-b')
set(set(gca,'XTick',1:4,'XTickLabel',xlabel))
hold on
plot(x,y2,'o-r')
title('Predicted Ventral CA1 response to different stimuli')
ylim([-0.05, 1.05])				%... and y-limits.
ylabel('Populational Firing Correlation')
legend('Compare to Stimulus B','Compare to Stimulus A')

%% Auditory cortex activity

xlabel = {'A','A*','B*','B'};
x = [1, 2, 3, 4];
y1 = [0.32, 0.50, 0.83, 0.99];
y2 = [0.98, 0.81, 0.51, 0.29];

subplot(1,2,2)
plot(x,y1,'o-b')
set(set(gca,'XTick',1:4,'XTickLabel',xlabel))
hold on
plot(x,y2,'o-r')
title('Predicted auditory cortical response to different stimuli')
ylim([-0.05, 1.05])				%... and y-limits.
ylabel('Populational Vector Correlation')
legend('Compare to Stimulus A','Compare to Stimulus B')

%% Behavioral respond
xlabel = {'A','A*','B*','B'};
x = [1, 2, 3, 4];
y2 = [1, 0.97, 0.3, 0.26];

figure(1),clf
subplot(1,3,1)
set(set(gca,'XTick',1:4,'XTickLabel',xlabel))
hold on
plot(x,y2,'o-r')
title('Predicted behavioral response to different stimuli')
ylim([-0.05, 1.05])				%... and y-limits.
ylabel('Normalised Freezing Time or Pupil Dilation')
legend('Fear response')

%% before and after fear retrival
xlabel = {'A','A*','B*','B'};
x = [1, 2, 3, 4];
y1 = [0.31, 0.35, 0.97, 0.99];
y2 = [0.98, 0.97, 0.32, 0.31];
y3 = [0.32, 0.50, 0.83, 0.99];
y4 = [0.98, 0.81, 0.51, 0.29];

subplot(1,3,3)
plot(x,y1,'o-b','DisplayName','Compared to stimulus B during Retrieval')
set(set(gca,'XTick',1:4,'XTickLabel',xlabel))
hold on
plot(x,y2,'o-r','DisplayName','Compared to stimulus A during Retrieval')
plot(x,y3,'o--b','DisplayName','Compared to stimulus B before Retrieval')
plot(x,y4,'o--r','DisplayName','Compared to stimulus A before Retrieval')
title('Predicted auditory cortical response before and during memory retrieval')
ylim([-0.05, 1.05])				%... and y-limits.
ylabel('Populational Firing Correlation')
legend

%% Auditory cortex activity

xlabel = {'A','A*','B*','B'};
x = [1, 2, 3, 4];
y1 = [0.32, 0.50, 0.83, 0.99];
y2 = [0.98, 0.81, 0.51, 0.29];

subplot(1,2,2)
plot(x,y1,'o-b')
set(set(gca,'XTick',1:4,'XTickLabel',xlabel))
hold on
plot(x,y2,'o-r')
title('Predicted auditory cortical response to different stimuli')
ylim([-0.05, 1.05])				%... and y-limits.
ylabel('Populational Vector Correlation')
legend('Compare to Stimulus A','Compare to Stimulus B')

%% Auditory cortex activity

xlabel = {'A','A*','B*','B'};
x = [1, 2, 3, 4];
y1 = [0.32, 0.50, 0.83, 0.99];
y2 = [0.98, 0.81, 0.51, 0.29];

subplot(1,2,2)
plot(x,y1,'o-b')
set(set(gca,'XTick',1:4,'XTickLabel',xlabel))
hold on
plot(x,y2,'o-r')
title('Predicted auditory cortical response to different stimuli')
ylim([-0.05, 1.05])				%... and y-limits.
ylabel('Populational Vector Correlation')
legend('Compare to Stimulus A','Compare to Stimulus B')


