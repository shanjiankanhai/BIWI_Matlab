function write_in_txt(dirs,pt_cld，d_name,f_names,id)    %将矩阵数据写入txt文件中,在文件main中调用,t_name表示传入的文件名

    cd(dirs.mx_dir);cd(d_name);    %需要提前在mx文件夹下建立01.02等文件夹

    t_name = f_names.depth(id,:)

    [pathstr,name,ext,versn]=fileparts(t_name)   %把t_name分解，提取需要的文件名name

    filename = sprintf('%s.csv', name)

    disp('filename')

    fid = fopen(filename,'w')

    csvwrite(pt_cld.z,fid)

   % fprintf(fid,'%f',pt_cld.z)

    fclose(fid)

    disp('文件写入完成')