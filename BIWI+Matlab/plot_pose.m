function plot_pose(pt_cld,gt_data,dep_intrinsic,frame_id)

% -    绘制头部位置
% plot_headloc(pt_cld,gt_data, dep_intrinsic, frame_id);

% - 
rot_mat = yrp2rot(gt_data.gt_ang(:,frame_id));     %调用函数得到旋转矩阵

% -   绘制头部方向图
plot_3d_headorientation(pt_cld, rot_mat);
            