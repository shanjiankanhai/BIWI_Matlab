function [mask,pt_cld] = get_maskndepth(dep_intrinsic, dirs, d_name, f_names, frame_id )

% 加载mask数据
cd(dirs.m_dir);
cd(d_name);
mask = logical(imread(f_names.mask(frame_id,:),'png'));     %logical函数，里面内容不为0则返回1.imread是读入图像的函数
                                                            
% 加载depth和rgb数据
cd(dirs.d_dir);
cd(d_name);

pt_cld = struct;
zThresh = 3.0;                

%   读取点云数据
[pt_cld.x, pt_cld.y, pt_cld.z] = mxReadDepthFile(f_names.depth(frame_id,:), dep_intrinsic, zThresh);

%      读取RGB图片
pt_cld.rgb = imread(f_names.rgb(frame_id,:),'png');


% 此处保留，用于将矩阵数据写入到txt文件中     此处有bug
%write_in_txt(dirs,pt_cld,d_name,f_names.mask(frame_id,:))

% 转到工作文件夹下
cd(dirs.w_dir);