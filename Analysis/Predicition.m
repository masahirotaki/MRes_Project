%% Ventral hippocampus activity
xlabel = {'A','A*','B*','B'};
x = [1, 2, 3, 4];
y1 = [0.01, 0.03, 0.97, 0.99];
y2 = [0.98, 0.97, 0.04, 0.01];

figure(1),clf
subplot(1,2,1)
plot(x,y1,'o-b')
set(set(gca,'XTick',1:4,'XTickLabel',xlabel))
hold on
plot(x,y2,'o-r')
title('Predicted Ventral CA1 response to different stimuli')
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

%% Behavioral respond
xlabel = {'A','A*','B*','B'};
x = [1, 2, 3, 4];
y2 = [1, 0.97, 0.3, 0.26];

figure(1),clf
subplot(1,2,1)
plot(x,y1,'o-b')
set(set(gca,'XTick',1:4,'XTickLabel',xlabel))
hold on
plot(x,y2,'o-r')
title('Predicted behavioral response to different stimuli')
ylim([-0.05, 1.05])				%... and y-limits.
ylabel('Normalised Freezing Time')
legend('Fear response')

%% before and after fear retrival
xlabel = {'A','A*','B*','B'};
x = [1, 2, 3, 4];
y1 = [0.31, 0.35, 0.97, 0.99];
y2 = [0.98, 0.97, 0.32, 0.31];
y3 = [0.32, 0.50, 0.83, 0.99];
y4 = [0.98, 0.81, 0.51, 0.29];

figure(2),clf
plot(x,y1,'o-b','DisplayName','After Retrieval')
set(set(gca,'XTick',1:4,'XTickLabel',xlabel))
hold on
plot(x,y2,'o-r','DisplayName','After Retrieval')
plot(x,y3,'o--b','DisplayName','Before Retrieval')
plot(x,y4,'o--r','DisplayName','Before Retrieval')
title('Predicted AC response before and after memory retrieval')
ylim([-0.05, 1.05])				%... and y-limits.
ylabel('Populational Vector Correlation')
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


