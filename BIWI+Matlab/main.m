

%  向搜索路径中添加文件夹
addpath('_utils');   
[dirs] = get_dir();       %调用函数文件，用来获取相关文件夹信息。此时需要手动选择工作文件夹和数据文件夹


%%    循环得到所有文件夹
fID = 1; fIDmax = 3;        % fIDmax规定要循环的子文件夹数量

while(fID <= fIDmax)

    %    得到文件夹名
    d_name = fID2Dir(fID);     % 格式化fID，输出字符文件夹名01.02.03.
    fprintf('\n**********************************\n')
    fprintf('[Info] Processing folder ID: %s\n', d_name)                      % d_name为文件夹名
    
    % 得到文件名和groundtruth数据
    [f_names, n_frames] = get_filenames(dirs, d_name);                       % 此处有BUG，已经修改.得到01文件夹下文件名字矩阵，文件数量
    gt_data = get_groundtruth(dirs, d_name);                                 % 此处有BUG，已修改。用于读取pose的位置和角度信息
    
   
    % 判断三个文件是否存在   分别是png，mask，depth文件
    success = validate_data(f_names, n_frames, gt_data);                      %此处有BUG，已修改   f_names储存文件夹中文件信息 n_frames是文件的数量，gt_data是文件的背景信息
   
    if (success)
        
        %  得到相机固有参数

        dep_intrinsic = load_calib(dirs,d_name);                    %使用函数读取相机校准数据
    

        for frame_id = 1:1:10    %n_frames                          %控制每个文件夹循环的文件数目
            
            fprintf('[Info] Processing frame: %s\n', f_names.depth(frame_id,:))
            
            % 得到mask depth文件进行校准           

            [mask, pt_cld] = get_maskndepth(dep_intrinsic, dirs, d_name, f_names, frame_id );
            
            % 得到头部标定数据，头部中心位置和角度参数

            write_in_txt(dirs,pt_cld,d_name,f_names，frame_id);   %此处调用函数用于将矩阵写入文件

            plot_pose(pt_cld,gt_data,dep_intrinsic,frame_id);
         
    
                        
        end
    
    else
       fprintf('[Warning] Folder %s  %.5d.\n',d_name, frame_id)
       fprintf('[Warning] 忽略 文件夹 ID %s.\n',d_name)
    end
    
    % 移动到下一个文件夹
    fID = fID+1;
end

disp('任务完成')
