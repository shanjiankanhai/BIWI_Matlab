% Before running the main.m file, first compile all the mex files by
% executing the following command 'run compile_mex' in the Command Window

% - Get the directories  向搜索路径中添加文件夹
addpath('_utils');   
[dirs] = get_dir();       %调用函数文件，用来获取相关文件夹信息。此时需要手动选择工作文件夹和数据文件夹


%% Loop through all the foldersIDs     循环得到所有文件夹
fID = 1; fIDmax = 3;        % fIDmax规定要循环的子文件夹数量

while(fID <= fIDmax)

    % - get the folder name    得到文件夹名
    d_name = fID2Dir(fID);     % 格式化fID，输出字符文件夹名01.02.03.
    fprintf('\n**********************************\n')
    fprintf('[Info] Processing folder ID: %s\n', d_name)                      % d_name为文件夹名
    
    % - Get the binary mask and depth img file names and ground truth
    [f_names, n_frames] = get_filenames(dirs, d_name);                       % 此处有BUG，已经修改.得到01文件夹下文件名字矩阵，文件数量
    gt_data = get_groundtruth(dirs, d_name);                                 % 此处有BUG，已修改。用于读取pose的位置和角度信息
    
    % - Check if the groundtruth,depth and mask frame nos correspond to each other   
    % 判断三个文件是否存在
    success = validate_data(f_names, n_frames, gt_data);                      %此处有BUG，已修改   f_names储存文件夹中文件信息 n_frames是文件的数量，gt_data是文件的背景信息
   
    if (success)
        
        % - Get the calibration data  得到相机固有参数

        dep_intrinsic = load_calib(dirs,d_name);                    %使用函数读取相机校准数据
      
        % - Loop through all the images in the folder d_name 
        % setting the upper limit in for loop below to n_frames
        % results in reading all the depth images in XX folder(XX= 01,02,...)

        for frame_id = 1:1:10    %n_frames                          %控制每个文件夹循环的文件数目
            
            fprintf('[Info] Processing frame: %s\n', f_names.depth(frame_id,:))
            
                        % - Get the mask and pt_cld data
                        % mask is the binary face mask and pt_cld.x pt_cld.y and 
                        % pt_cld.z are 480 x 640 matrices containing point cloud in mm

            [mask, pt_cld] = get_maskndepth(dep_intrinsic, dirs, d_name, f_names, frame_id );
            
                         % - plot head location and orientation

            write_in_txt(dirs,pt_cld,d_name,f_names，frame_id);   %此处调用函数用于将矩阵写入文件

            plot_pose(pt_cld,gt_data,dep_intrinsic,frame_id);
         
            % Now you can use the mask and pt_cld data in your algorithm
                        
        end
    
    else
       fprintf('[Warning] Folder %s does have corresponding depth and mask @ frame id: %.5d.\n',d_name, frame_id)
       fprintf('[Warning] Ignored folder ID %s.\n',d_name)
    end
    
    % - Move to the next folderID
    fID = fID+1;
end

disp('finish the project')
