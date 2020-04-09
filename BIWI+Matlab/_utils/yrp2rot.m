function [rot_mat] = yrp2rot(gt_angles)   % 这个函数是用来把角度数据转换成矩阵

pitch = gt_angles(1);
yaw   = gt_angles(2);
roll  = gt_angles(3);

% 

rot_z = [cosd(roll),-sind(roll), 0;
         sind(roll), cosd(roll), 0;
         0        , 0        , 1];

rot_y = [cosd(yaw),0, sind(yaw);
         0          ,1,       0;
         -sind(yaw),0,cosd(yaw)];
     
rot_x = [1,          0,          0;
         0, cosd(pitch),-sind(pitch);
         0, sind(pitch),cosd(pitch)];

% 设置矩阵相乘        
rot_mat = rot_z*rot_y*rot_x;



