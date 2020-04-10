function  write_in_csv_cal(dirs,pt_cld,d_name,t_name)    %
%myFun - Description
%
% Syntax: 
%
% Long description
    cd(dirs.mx_dir);cd(d_name);    %

    [~,name,~] = fileparts(t_name);   %
    filename = sprintf('%s.csv', name);

    disp('filename')

    fid = fopen(filename,'w');
    
    csvwrite(filename,pt_cld.z)

    %fprintf(fid,'%f,',pt_cld.z)

    fclose(fid);

    disp('写入完成')

    
end