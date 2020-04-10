function [cam_intrinsic] = load_calib(dirs,d_name)

cd(dirs.d_dir); cd(d_name);

cam_intrinsic = zeros(9,1);      %创建一个9行1列的零矩阵，为了存储相机校准数据
cam_rgb = zeros(9,1);

% fid = fopen('rgb.cal', 'r');
fid = fopen('depth.cal', 'r');
disp(fid)                        %判断文件是否打开


cam_intrinsic(1:3) = fscanf(fid, '%f %f %f\n',3);
cam_intrinsic(4:6) = fscanf(fid, '%f %f %f\n',3);
cam_intrinsic(7:9) = fscanf(fid, '%f %f %f\n',3);
fclose(fid);


% 读取rgb配置文件
fid = fopen('rgb.cal', 'r');
disp(fid)                        %判断文件是否打开

cam_rgb(1:3) = fscanf(fid, '%f %f %f\n',3);
cam_rgb(4:6) = fscanf(fid, '%f %f %f\n',3);
cam_rgb(7:9) = fscanf(fid, '%f %f %f\n',3);
fclose(fid);

disp('[Info] 完成读取深度相机数据.')

% 深度数据写入文件中
write_in_csv_cal(dirs, cam_intrinsic, cam_rgb, d_name)

cd(dirs.w_dir);