%--------------------------------------------------------------------------
% retrieve_video_files Returns a set of paths of videos to be processed
%   vcum = retrieve_video_files(vdir,ftp)
%
%   Input -----
%      'vdir': path to video files
%      'ftp': cell array of videos to be found
%
%   Output -----
%      'vcum': Cell array of video locations to be processed
%--------------------------------------------------------------------------
function vcum = retrieve_video_files(vdir,ftp)
    vcum = {}; cd(vdir);

    % Gets all file names without file commands
    d = dir; d = {d.name}; d = d(3:end);
    
    for i = ftp
        j = 1;
        while(j <= length(d))
            fn = d{j};
            found = strfind(lower(fn),i);
            if ~isempty(found)
                vcum = [vcum strcat(vdir,fn)];
                break;
            end
            j = j + 1;
        end
    end