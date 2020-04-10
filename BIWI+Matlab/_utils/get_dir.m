function [dirs] = get_dir()                         %该函数得到一个结构体，结构体里保存工作文件夹和数据文件夹等相关信息

dirs = struct;                        %定义了一个结构体，存储文件夹的名字和其他信息
%      选择工作文件夹
dirs.w_dir = uigetdir([], '选择工作目录');          %结构体的w_dir属性定义工作文件夹
pause(0.3);
if (dirs.w_dir == 0)
    return;
end

dirs.d_dir = uigetdir([], '选择文件夹 .bin Depth Images: "kinect_head_pose_db"');    %属性d_dir定义深度数据文件夹
if (dirs.d_dir == 0)
    return;
end
pause(0.3);


dirs.m_dir = uigetdir([], '选择文件夹Binary Masks: "head_pose_masks"');    %定义mask文件夹
if (dirs.m_dir == 0)
    return;
end
pause(0.3);


dirs.gt_dir = uigetdir([], '选择文件夹Ground Truth: "db_annotations"');        %定义groundtruth文件夹
if (dirs.gt_dir == 0)
    return;
end
pause(0.3);

dirs.mx_dir = uigetdir([],'选择文件夹矩阵matrix');    %选择存放矩阵的文件夹
if (dirs.mx_dir == 0)
    return;
end
pause(0.3)

dirs.position_dir = uigetdir([],'选择存放头部位置的文件夹position');    %选择存放角度和头部位置的文件夹
if (dirs.position_dir == 0)
    return;
end
pause(0.3)

dirs.cal_dir = uigetdir([],'选择存放相机校正参数的文件夹 cal');    %选择存放相机校正参数的文件夹cal
if (dirs.cal_dir == 0)
    return;
end
pause(0.3)

addpath(dirs.w_dir);      %把工作文件夹添加进搜索路径
disp('[Info] 所有文件夹载入完成')