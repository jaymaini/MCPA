% Jay Maini 101037537
% MCPA


set(0, 'DefaultFigureWindowStyle','docked')
clear all
close all

%Force
F = 1;
n = 1;
%Time interval and simmulation time 
dt = 1;
nt = 1000;
%Number of particles - can be run with multiple
np = 1;
x = zeros(np,1);
v = zeros(np,1);
t = 0;
m = 0.1;

%Rebound critreion - where the velocity rebounds to 
re = 0;

for i=2:nt
    %Advance the electron in time updating its position and velocity with a
    %force present
    t(i) = t(i-1)+dt;
    v(:,i) = v(:,i-1) + F/m*dt;
    x(:,i) = x(:,i-1) + v(:,i-1)+dt + F/m*dt^2/2;
    
    %Add Scattreing chance
    %Fixed 5% chance (not used)
    %r = rand(np,1) < 0.05;
    
    %Use 2g equation:
    %Tau was found to be, using back calculation for 0.05 at midpoint of
    %simulation (500)
    tau = 9750;
    %Equation for probability of scattering:
    %Now dependent on simulation time elapsed!
    r = rand(np,1) < (1-exp(-t(i)/tau));
    
    %Apply the rebound
    v(r,i) = re*v(r,i);
    %Calculate average
    avgV(i,:) = mean(v,2);
    
    %Subplots for velocity
    subplot(3,1,1)
    plot(t,v,'-');
    hold on
    plot(t,avgV, 'r+');
    hold off;
    title("Velocity Over time, with average of " +  avgV(i,:));
    ylabel('velocity');
    xlabel('time');
    
    subplot(3,1,2)
    plot(x,v, 'g')
    ylabel('velocity');
    xlabel('position');

    subplot(3,1,3)
    plot(t,x, 'v')
    ylabel('position');
    xlabel('time');   
    
    pause(0.01)
end


