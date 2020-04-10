function write_in_csv(dirs, gt, d_name)    %将矩阵数据写入csv文件中,在文件main中调用,t_name表示传入的文件名

    cd(dirs.position_dir);   

    filename = sprintf('position%s.csv', d_name);
 

    % fid = fopen(filename,'w');

    csvwrite(gt.gt_loc, fid)       ;  %把头部中心位置写入csv文件中
    csvwrite(gt.gt_ang, fid, 3, 0);

   % fprintf(fid,'%f',pt_cld.z)

    % fclose(fid);

    disp('文件写入完成');