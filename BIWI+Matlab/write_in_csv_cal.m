function  write_in_csv_cal(dirs,cal_matrix,cal_rgb,d_name)    %
%myFun - Description
%
% Syntax: 
%
% Long description
    cd(dirs.cal_dir);

    %[~,name,~] = fileparts(t_name);   %

    % newstr = split(name,"_")
    % newname = strcat(newstr[1,1],newstr[2,1])
    filename_depth = sprintf('depth_cal_%s.csv', d_name);
    filename_rgb = sprintf('rgb_cal_%s.csv', d_name);

    % fid = fopen(filename,'w');
    
    csvwrite(filename_depth,cal_matrix);
    csvwrite(filename_rgb,cal_rgb)

    %fprintf(fid,'%f,',pt_cld.z);

   % fclose(fid);

    disp('写入完成');

    
end