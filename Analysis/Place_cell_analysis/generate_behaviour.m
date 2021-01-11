    function [x,v]=generate_behaviour(t,t_step1)
        global parameters
        x=1.5*vco(linspace(-1,1,length(t)),[0.05 0.15],1./t_step1);
        x(find(x>1))=1; % clamp at 1
        x(find(x<-1))=-1; % Clamp at -1
        x=0.5*x+0.5; %normalize from 0 to 1
        v=diff([x(1) x x(end)])/t_step1;
        v=interp1([t-(t_step1/2) t(end)+t_step1/2],v,t,'linear');
    end