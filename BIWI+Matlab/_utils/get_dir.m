function [dirs] = get_dir()                         %该函数得到一个结构体，结构体里保存工作文件夹和数据文件夹等相关信息

dirs = struct;                        %定义了一个结构体，存储文件夹的名字和其他信息
% Select the working directory        选择工作文件夹
dirs.w_dir = uigetdir([], 'Select the working directory.');          %结构体的w_dir属性定义工作文件夹
pause(0.3);
if (dirs.w_dir == 0)
    return;
end
% - Get the parent directory of compressed binary depth images 
dirs.d_dir = uigetdir([], 'Select the parent directory of the of .bin Depth Images: "kinect_head_pose_db"');    %属性d_dir定义深度数据文件夹
if (dirs.d_dir == 0)
    return;
end
pause(0.3);

% - Get the parent directory of the binary masks
dirs.m_dir = uigetdir([], 'Select the parent directory of the of Binary Masks: "head_pose_masks"');    %定义mask文件夹
if (dirs.m_dir == 0)
    return;
end
pause(0.3);

% - Get the parent directory of the groundtruth
dirs.gt_dir = uigetdir([], 'Select the parent directory of the of Ground Truth: "db_annotations"');        %定义groundtruth文件夹
if (dirs.gt_dir == 0)
    return;
end
pause(0.3);

dirs.mx_dir = uigetdir([],'Select the dirs to save the matrix');    %选择存放矩阵的文件夹
if (dirs.mx_dir == 0)
    return;
end
pause(0.3)

addpath(dirs.w_dir);      %把工作文件夹添加进搜索路径
disp('[Info] Obtained all the directories')