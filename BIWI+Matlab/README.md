
# 各个变量的含义整理

## get_dir

dirs:  指一个存储文件夹路径的结构体，文件夹路径是指绝对路径，会随着文件放置位置不同而变化
dirs.w_dir:  用来储存工作文件夹路径
dirs.d_dir:  kinect_head_pose_db文件夹路径
dirs.m_dir:  head_pose_masks文件夹路径
dirs.gt_dir: db_annotations文件夹路径

fID:
fIDmax:   用来循环得到主文件夹下的01，02等文件夹

## fID2Dir

fID2Dir: 格式化输出，为数字前面添加0变成文件夹名

d_name:  文件夹名01，02，03.等

## f_names

f_names:  定义一个结构体，用来存储`kinect_head_pose_db`的01、02等文件夹里有关文件的信息

f_names.depth:  定义用来储存`kinect_head_pose_db`文件夹下所有文件名为`.bin`的属性数组，按照m × n排列，m是文件的数量
n_frames：`kinect_head_pose_db`depth文件的数量

f_names.rgb：定义用来储存`kinect_head_pose_db`文件夹下所有文件名为`.png`的属性数组，按照m × n排列，m是文件的数量
n_rgbframes: `kinect_head_pose_db`文件夹下`png`文件的数量

f_names.mask:  `head_pose_masks`文件夹下`.png`文件的文件名
n_mframes:  `head_pose_masks`文件夹下`png`文件数目

n_frames:  一组文件的数量

## gt_data

gt_data： 用来存储`db_annotations`文件夹的相关信息

gt_data.fnames:  列出`db_annotations`文件夹下的文件目录并保存为m×n矩阵
gt_data.nframe:  得到`bin`文件的数量
gt_data.gt_loc:  生成一个3行，gt_data.nframes列的零矩阵，用来储存ground信息中的位置信息
gt_data.gt_ang:  用于储存ground信息的角度信息

validate_data文件中的`gt`其实就是`gt_data`

## success:  存储用来判断文件完整性的变量

## dep_intrinsic：和下面的作用一样，只不过下面的是一个是局部变量

cam_intrinsic：用于存储深度配置文件depth.cal的9行1列数组

## pt_cld 读取点云和RGB图像的数据

# 函数相关
