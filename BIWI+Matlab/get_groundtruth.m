function [gt_data] = get_groundtruth(dirs, d_name)        %d_name是文件夹名 

cd(dirs.gt_dir); cd(d_name);

gt_data = struct;
gt_data.fnames = ls('*.bin');                      %列出文件夹01下的文件目录并保存为m×n矩阵
gt_data.nframes = size(gt_data.fnames,1);          %得到bin文件的数量
gt_data.gt_loc = zeros(3,gt_data.nframes);         %生成一个3行，gt_data.nframes列的零矩阵
gt_data.gt_ang = zeros(3,gt_data.nframes);

for frame_id = 1:1:gt_data.nframes                % 三个参数分别是开始，步长，终止。这个循环会遍历该文件夹下所有文件
    
    fid = fopen(fullfile('C:\Users\lennon\Desktop\biwi\db_annotations',d_name,gt_data.fnames(frame_id,:)), 'r');         %读取矩阵存储的文件名                                    此处需要路径但是传入的是文件名列表

    fprintf('zhengchang')

    disp(gt_data.fnames(frame_id,:)))
    
    % 
    gt_data.gt_loc(:,frame_id)= fread(fid, 3,'float');     %操作矩阵，读取文件的前3个数据，存储到所有行的相应列
    
    % 
    gt_data.gt_ang(:,frame_id) = fread(fid, 3,'float');           %操作矩阵
    
    fclose(fid);
    
end

% 把角度和位置矩阵写入csv文件
write_in_csv(dirs, gt_data, d_name)

cd(dirs.w_dir);

fprintf('[Info] 完成读取ground truth数据 ID: %s\n',d_name)


