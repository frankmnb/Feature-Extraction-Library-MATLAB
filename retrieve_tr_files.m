%--------------------------------------------------------------------------
% retrieve_tr_files Returns a set of paths of tr files to be processed
%   tcum = retrieve_video_files(tdir,ftp)
%
%   Input -----
%      'tdir': path to tr files
%      'ftp': cell array of files to be found
%
%   Output -----
%      'tcum': Cell array of tr file locations to be processed
%--------------------------------------------------------------------------
function tcum = retrieve_tr_files(tdir,ftp)
    tcum = {}; cd(tdir);

    % Gets all file names without file commands
    d = dir; d = {d.name}; d = d(3:end);

    for i = ftp
        j = 1;
        while(j <= length(d))
            fn = d{j};
            found = strfind(lower(fn),strcat(i,'_mmdet'));
            if ~isempty(found)
                tcum = [tcum strcat(tdir,fn)];
                break;
            end
            j = j + 1;
        end
    end