%% PSO Optimization Algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Name:       Particle Swarm Optimization Algorithm
%   Author:     Iman Tahbaz-zadeh Moghaddam
%               Iran University of Science and Technology
%               i.tahbaz@gmail.com
%   Purpose:    Setup for Travelling Salesman Problem (TSP)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;clear;close all;
tic;

%% Generating 2D Point's Coordinates
global x y;

% x = randi([0 100], 1, 20);
% y = randi([0 100], 1, 20);

% Example
% x = [58 76 79 64];
% y = [24 58 49 70];
% x = [58 76 79 64 11 68 32 32 14 79];
% y = [24 58 49 70 5 7 79 9 21 47];
% x = [87 23 17 0 54 40 76 66 39 20 32 36 21 35 80];
% y = [50 53 3 50 35 40 24 87 20 37 80 82 9 76 30];
x = [65 26 45 4 77 1 84 68 85 67 99 68 48 56 61 16 63 92 9 4];
y = [97 15 16 39 37 8 50 79 29 62 27 69 29 62 66 10 22 66 1 50];

%% Problem Definition
dimension = length(x)-1; % start of tour would be from random Coor.
p_max = ones(1,dimension);
p_min = zeros(1,dimension);
VelMax = 0.4*(p_max-p_min);
VelMin = -VelMax;

%% PSO Parameters Definition
max_iterations = 1000;
num_of_particles = 300;
w = 1; %100*(max(p_max-p_min))/max_iterations;
wdamp = 0.99;
c1 = 2;
c2 = 2;

global NFE;
NFE=0;

%% PSO Particles Initializing
for i = 1:dimension
    p_position(:,i) = (p_max(i)-p_min(i))*rand(num_of_particles,1)+p_min(i);
    p_velocity(:,i) = 0.01*rand(num_of_particles,1);
end

%% PSO Main Loop
for count = 1:max_iterations
    for i = 1:num_of_particles
        [current_cost(i), resp(i,:)] = Cost(p_position(i,:));
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
    best_resp(count,:) = resp(g_best_index,:);
        
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
        
    figure(1)
    plot(x(best_resp(count,:)),y(best_resp(count,:)),'-s',...
        'LineWidth',2,...
        'MarkerSize',12,...
        'MarkerFaceColor','y');
    hold on;
    plot(x(best_resp(count,1)),y(best_resp(count,1)),'-p',...
        'LineWidth',2,...
        'MarkerSize',20,...
        'MarkerFaceColor','r');
    hold off;
    pause(0.05);
    for e = 1:length(x)
        text(x(best_resp(count,e)),y(best_resp(count,e)),num2str(e),'fontweight','b')
    end
    
    w = w*wdamp;
    nfe(count) = NFE;
    count
end
toc;

figure(2)
plot(g_best_Mat,'LineWidth',3)
xlabel('Iteration')
ylabel('Cost')

figure(3)
plot(nfe,g_best_Mat,'LineWidth',3)
xlabel('NFE')
ylabel('Cost')

Best_Tour = [x(best_resp(count,:)); y(best_resp(count,:))]

Best_IndeXes = (best_resp(count,:))


