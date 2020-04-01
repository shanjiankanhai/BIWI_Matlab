function [cam_intrinsic] = load_calib(dirs,d_name)

cd(dirs.d_dir); cd(d_name);

cam_intrinsic = zeros(9,1);      %创建一个9行1列的零矩阵，为了存储相机校准数据

fid = fopen('depth.cal', 'r');
disp(fid)                        %判断文件是否打开


cam_intrinsic(1:3) = fscanf(fid, '%f %f %f\n',3);
cam_intrinsic(4:6) = fscanf(fid, '%f %f %f\n',3);
cam_intrinsic(7:9) = fscanf(fid, '%f %f %f\n',3);
fclose(fid);

disp('[Info] Finished reading calibration file.')
cd(dirs.w_dir);