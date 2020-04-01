function [success] = validate_data (f_names,n_frames, gt)    gt其实就是gt_data

% This function checks whether or not for every frame # there exists a               这个程序是用来判断文件的完整性，三个文件是否存在
% depth frame, a mask frame and a ground truth frame.

for frame_id = 1:1:n_frames                 % n_frames是文件的数目
    d_name = f_names.depth(frame_id,:);     % depth文件的名称                    此处可能有问题
    m_name = f_names.mask(frame_id,:);      % mask文件的名称
    gt_name = gt.fnames(frame_id,:);
    
    % - get the depth frame number
    [~,b]=strtok(d_name,'_');      % ~表示占位符，用于接收不需要的参数，此处意思是以_作为分隔符，第一个分隔符之前的字符扔掉，第一个分隔符及之后的字符给b
    disp(d_name)             %加一行，验证输出是否符合需要，输出完整文件名

    [d_framenum]=strtok(b,'_');     % 此处是把b中第一个分隔符之前的字符赋值给d_framenum
    disp(d_framenum)          %验证输出是否正确
    
    % - get the mask frame number
    [~,q]=strtok(m_name,'_');
    [m_framenum]=strtok(q,'_');
    
    % - get the gt frame number
    [~,n]=strtok(gt_name,'_');
    [gt_framenum]=strtok(n,'_');
    
    success1 = strcmp(d_framenum,m_framenum);             %比较两个不同的字符向量
    success2 = strcmp(d_framenum,gt_framenum);
    
    if(~success1) 
        fprintf('[Error] Match failed for depth image frame: %s with mask frame',d_framenum)
        return;
    end
    if(~success2) 
        fprintf('[Error] Match failed for depth image frame: %s with groundtruth frame',d_framenum)
        return;
    end
    success = success1 & success2;
end

disp('[Info] Database frame# OK')