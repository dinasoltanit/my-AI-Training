%% PSO Optimization Algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Name:       Particle Swarm Optimization Algorithm
%   Author:     Iman Tahbaz-zadeh Moghaddam
%               Iran University of Science and Technology
%               i.tahbaz@gmail.com
%   Purpose:    Setup for Minimizing functions with Constraint
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;clear;close all;
tic;

%% Problem Definition
dimension = 2;
p_max = [10 10];
p_min = [-10 -10];
VelMax = 0.1*(p_max-p_min);
VelMin = -VelMax;

%% PSO Parameters Definition
max_iterations = 100;
num_of_particles = 40;
w = 1; %100*(max(p_max-p_min))/max_iterations;
wdamp = 0.99;
c1 = 2;
c2 = 2;

% phi1=2.05;
% phi2=2.05;
% phi=phi1+phi2;
% chi=2/(phi-2+sqrt(phi^2-4*phi));
% w=chi;          % Inertia Weight
% wdamp=0.99;     % Inertia Weight Damping Ratio
% c1=chi*phi1;    % Personal Learning Coefficient
% c2=chi*phi2;    % Global Learning Coefficient

global NFE; % NFE = num_of_particles * max_iterations;
NFE = 0;

%% PSO Particles Initializing
for i = 1:dimension
    p_position(:,i) = (p_max(i)-p_min(i))*rand(num_of_particles,1)+p_min(i);
    p_velocity(:,i) = 0.01*rand(num_of_particles,1);
end

%% PSO Main Loop
for count = 1:max_iterations
    for i = 1:num_of_particles
        current_cost(i) = Cost(p_position(i,:));
    end
    
    % Particle Best Finding
    if count == 1
        p_best = current_cost;
        p_best_pos = p_position;
    else
        for i = 1:num_of_particles
            if current_cost(i) < p_best(i)
                p_best(i) = current_cost(i);
                p_best_pos(i,:) = p_position(i,:);
            end
        end
    end
    
    % Global Best Finding
    [g_best,g_best_index] = min(p_best);
    g_best_pos(count,:) = p_position(g_best_index,:);
    
    % for Plot
    p_pos_Mat(count,:,:) = p_position;
    p_best_pos_Mat(count,:,:) = p_best_pos;
    g_best_Mat(count) = g_best;
    
    % Updating Values
    for i = 1:num_of_particles
        for j = 1:dimension
            % Update Velocity
            p_velocity(i,j) = w*p_velocity(i,j) + c1*rand*(p_best_pos(i,j) - p_position(i,j)) + c2*rand*(g_best_pos(count,j) - p_position(i,j));
            
            % Apply Velocity Limits
            if p_velocity(i,j) < VelMin(j)
                p_velocity(i,j) = VelMin(j);
            elseif p_velocity(i,j) > VelMax(j)
                p_velocity(i,j) = VelMax(j);
            end
            
            % Update Position
            p_position(i,j) = p_position(i,j) + p_velocity(i,j);
            
            % Apply Position Limits and Velocity Mirror Effect
            if p_position(i,j) < p_min(j)
                p_position(i,j) = p_min(j);
                p_velocity(i,j) = -p_velocity(i,j);
            elseif p_position(i,j) > p_max(j)
                p_position(i,j) = p_max(j);
                p_velocity(i,j) = -p_velocity(i,j);
            end
            
        end
    end
    w = w*wdamp;
    nfe(count) = NFE;
    count
end
toc;

%% Results
designParams = g_best_pos(end,:)
bestCost = g_best(end)

figure;
plot(g_best_Mat,'LineWidth',2)
xlabel('Iteration')
ylabel('Cost')

figure;
plot(nfe,g_best_Mat,'LineWidth',2)
xlabel('NFE')
ylabel('Cost')
if dimension == 1
    figure;
    plot(g_best_pos(:,1),'ro--','LineWidth',2)
    xlabel('Iteration')
    ylabel('Global best position}')
elseif dimension == 2
    figure;
    plot(g_best_pos(:,1),g_best_pos(:,2),'ro--','LineWidth',2)
    hold on;
    plot(g_best_pos(1,1),g_best_pos(1,2),'bd','LineWidth',2);
    plot(g_best_pos(end,1),g_best_pos(end,2),'kd','LineWidth',2);
    text(g_best_pos(1,1),g_best_pos(1,2),' \leftarrow Start','FontSize',10)
    text(g_best_pos(end,1),g_best_pos(end,2),' \leftarrow End','FontSize',10)
    xlabel('Global best position_1')
    ylabel('Global best position_2')
    figure;
    for j = 1:2:max_iterations
        plot(p_pos_Mat(j,:,1),p_pos_Mat(j,:,2),'ro','LineWidth',2);
        hold on;
        plot(g_best_pos(j,1),g_best_pos(j,2),'bd','LineWidth',2);
        legend('Particles position','Global best position')
        xlabel('Particles position_1')
        ylabel('Particles position_2')
        grid;
        axis([p_min(1) p_max(1) p_min(2) p_max(2)])
        getframe();
        pause(0.005)
        hold off;
    end

    figure;
    for j = 1:2:max_iterations
        plot(p_best_pos_Mat(j,:,1),p_best_pos_Mat(j,:,2),'ro','LineWidth',2);
        hold on;
        plot(g_best_pos(j,1),g_best_pos(j,2),'b*','LineWidth',2);
        legend('Particles best position','Global best position')
        xlabel('Particles Best position_1')
        ylabel('Particles Best position_2')
        grid;
        axis([p_min(1) p_max(1) p_min(2) p_max(2)])
        getframe();
        pause(0.05)
        hold off;
    end
end


