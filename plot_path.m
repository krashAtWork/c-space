%this contains a non-viable path.  FIX ME!!

function  plot_path (path_start,path_end,a_vec)

%% code for continuous path, can be broken down into 3 parts
via_1=[-pi;0];
intmdt_pts = [ [1.958; pi],[1.958; -pi;],[1.5548; -2.242],[1.5548; -1.542]];
wrap_12=[pi;0];
part1 = [path_start, via_1];
part2 = [wrap_12, intmdt_pts(:,1)];
part3 = [intmdt_pts(:,2), intmdt_pts(:,3),intmdt_pts(:,4), path_end];
dq_size = 0.1;
[obstacle_ctr_pts,obstacle_radii] = get_environment_model;
fignum=3;
%% make a continuous valid path



 %% WHAT DO THESE MEAN WRAP_12 IS THE NEGATIVE VIA_1
figure(2)
hold on
 
 %% MARKS THE START AND END POINTS
 plot(path_start(1),path_start(2),'g.',"markersize",50)
 plot(path_end(1),path_end(2),'g.',"markersize",50)
[dummy, imp] = size(intmdt_pts);
for i = 1: imp
   plot(intmdt_pts(1,i),intmdt_pts(2,i),'r.',"markersize",25)
end
 
%% Part 1

dist1 = norm(path_start - via_1);%% CALCULATING DISTANCE BETWEEN TWO POINTS\

npts = round(dist1/dq_size); %% BREAKING A LINE SEGMENT INTO SMALLER UNITS

figure(fignum);
clf

plot_circles(obstacle_ctr_pts,obstacle_radii,fignum);
fignum=3;
figure(fignum)
for i=0:npts %% FOR EACH POINT ALONG THE ABOVE DISTANCE 
  figure(3)
clf
plot_circles(obstacle_ctr_pts,obstacle_radii,fignum)
hold on
axis([-3,3,-3,3])
grid on
axis('square')
  q_vec = path_start+(via_1-path_start)*i/npts;
  [arm_ctr_pts,arm_model_radii] = get_arm_collision_model(q_vec,a_vec);
[payload_ctr_pts,payload_radii] = get_payload_collision_model(q_vec,a_vec);

arm_ctr_pts=[arm_ctr_pts,payload_ctr_pts];
arm_model_radii=[arm_model_radii,payload_radii];
plot_circles(arm_ctr_pts,arm_model_radii,fignum)
axis([-3,3,-3,3])
 figure(2)
 hold on
 plot(q_vec(1),q_vec(2),'k.',"markersize",30)
pause
end
  
%% PART2 - SINGLE LINE
dist2 = norm(wrap_12 - intmdt_pts(:,1));
npts = round(dist2/dq_size);

for i=0:npts
  figure(3)
clf
plot_circles(obstacle_ctr_pts,obstacle_radii,fignum)
hold on
axis([-3,3,-3,3])
grid on
axis('square')  
  q_vec = wrap_12+(intmdt_pts(:,1)-wrap_12)*i/npts;
  [arm_ctr_pts,arm_model_radii] = get_arm_collision_model(q_vec,a_vec);
[payload_ctr_pts,payload_radii] = get_payload_collision_model(q_vec,a_vec);

arm_ctr_pts=[arm_ctr_pts,payload_ctr_pts];
arm_model_radii=[arm_model_radii,payload_radii];
plot_circles(arm_ctr_pts,arm_model_radii,fignum)
 figure(2)
  hold on

 plot(q_vec(1),q_vec(2),'k.',"markersize",30)
pause
end

%% PART3 - MULTIPLE LINES

% make a loop of the above process:
[dummy, imp] = size(part3);
% imp = 2;
dist3 = zeros(1, imp);
npts3 = zeros(1, imp);


for j= 1:(imp-1)
    dist3(j) = norm(part3(:,j) - part3(:,j+1)); 
    npts3(j) = round(dist3(j)/dq_size);
    for i=0: npts3(j)
    figure(3)
    clf
    plot_circles(obstacle_ctr_pts,obstacle_radii,fignum)
    hold on
    axis([-3,3,-3,3])
    grid on
    axis('square')
%     q_vec = wrap_12+(intmdt_pts(:,1)-wrap_12)*i/npts;
    q_vec = part3(:,j)+(part3(:,j+1)- part3(:,j))*i/npts3(j);
    [arm_ctr_pts,arm_model_radii] = get_arm_collision_model(q_vec,a_vec);
    [payload_ctr_pts,payload_radii] = get_payload_collision_model(q_vec,a_vec);

    arm_ctr_pts=[arm_ctr_pts,payload_ctr_pts];
    arm_model_radii=[arm_model_radii,payload_radii];
    plot_circles(arm_ctr_pts,arm_model_radii,fignum)
    figure(2)
    hold on

    plot(q_vec(1),q_vec(2),'k.',"markersize",30)
    pause
    
    end
    
end

end
