%--------------------------------------------------------------------------
% video_to_snips Extracts bounding boxes in a TR file from the video
%   [f, dto, ar, ac] = video_to_snips(tdir,ds,tr,vn)
%
%   Input -----
%      'tdir': path to where output folder is to be saved
%      'ds': dataset name
%      'tr': path to TR file
%      'vn': path to video
%
%   Output -----
%      'f': path to subfolder with snips
%      'dto': path to output folder (to use as location for saving data)
%      'ar': average bounding box height
%      'ac': average bounding box width
%--------------------------------------------------------------------------
function [f, dto, ar, ac] = video_to_snips(tdir,ds,tr,vn)

    % Extracts snips from video using tr data (a function)

    % output dir
    dto = strcat(tdir,'Snips\');

    vr = VideoReader(vn); v = read(vr); % Video
    fte = vr.Duration * vr.FrameRate; % Frames to extract

    tr = table2cell(readtable(tr));

    ar = mean(cell2mat(tr(:,5))); ac = mean(cell2mat(tr(:,6)));

    f = strcat(dto,ds);
    if ~exist(f, 'dir')
        mkdir(f)
    end
    cd(f) % create an output directory for this video

    for i = 1:fte % for every frame
        g = v(:,:,:,i);
        tr2 = tr(cat(1,tr{:,1})==i,:);

        for j = 1:size(tr2,1) %for every bob in that frame
            c = imcrop(g,[tr2{j,3},tr2{j,4},tr2{j,5},tr2{j,6}]);
            n = [num2str(i) '_' num2str(tr2{j,2}) '.jpg'];
            imwrite(c,n);
        end
    end
end