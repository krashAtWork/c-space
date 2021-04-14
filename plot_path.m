%this contains a non-viable path.  FIX ME!!

function  plot_path (path_start,path_end,a_vec)

%% make a continuous valid path
path_end = [2.34,1.358]
via_1=[-pi;0];

wrap_12=[pi;0]; %% WHAT DO THESE MEAN WRAP_12 IS THE NEGATIVE VIA_1
figure(2)
hold on
 
 %% MARKS THE START AND END POINTS
 plot(path_start(1),path_start(2),'g.',"markersize",50)
 plot(path_end(1),path_end(2),'g.',"markersize",50)
 

dq_size=0.1;
dist1 = norm(path_start - via_1);%% CALCULATING DISTANCE BETWEEN TWO POINTS
 
dist2 = norm(wrap_12 - path_end)

  
  
npts = round(dist1/dq_size); %% BREAKING A LINE SEGMENT INTO SMALLER UNITS
fignum=3;
figure(fignum);
clf
[obstacle_ctr_pts,obstacle_radii] = get_environment_model;
plot_circles(obstacle_ctr_pts,obstacle_radii,fignum)
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
  

dist2/dq_size
npts = round(dist2/dq_size);

for i=0:npts
  figure(3)
clf
plot_circles(obstacle_ctr_pts,obstacle_radii,fignum)
hold on
axis([-3,3,-3,3])
grid on
axis('square')  
  q_vec = wrap_12+(path_end-wrap_12)*i/npts;
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
