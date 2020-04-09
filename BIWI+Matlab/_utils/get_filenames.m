function [f_names,n_frames] = get_filenames(dirs, d_name)                % dirs是文件夹路径等信息，d_name是文件夹名01.02等

   f_names = struct ;               %建立一个新的结构体，名字是f_name用来储存文件夹下的文件的信息
   cd(dirs.d_dir); cd(d_name);
   
   % 得到深度文件的文件名
   f_names.depth = ls('*.bin');                 %所有bin文件名的矩阵，是按照列排列的
   n_dframes = size(f_names.depth,1);           %n_dframes指的是depth文件的数量

   %此处为了实验ls得到的数据是什么
   for amd=1:1:n_dframes
      fprintf(f_names.depth(amd,:))
   end
   
   % 读取rgb文件
   f_names.rgb = ls('*.png');
   n_rgbframes = size(f_names.rgb,1);
   cd(dirs.w_dir);
    
   cd(dirs.m_dir); cd(d_name);         %转到mask文件夹下
   
   % 读取mask文件
   f_names.mask = ls('*.png') ;
   n_mframes = size(f_names.mask,1);
   
   cd(dirs.w_dir);

   if (n_dframes ~= n_rgbframes )
       fprintf('[Error] rgb和depth文件数量不相等\n')                  %以上执行正常
       return,
   end
   
   if (n_dframes ~= n_mframes )
       fprintf('[Error] depth和mask文件数量不相等\n')                 %mask缺少一个文件，删掉一个depth系列即可
       return,
   end
   
   n_frames = n_dframes;
   fprintf('[Info] 完成验证文件数量 ID: %s\n',d_name)